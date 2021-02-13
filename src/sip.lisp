(in-package :cl-hashing)

(defconstant +c-rounds+ 2)
(defconstant +d-rounds+ 4)

(defmacro sip-round (v0 v1 v2 v3)
  `(setf ,v0 (m64 (+ ,v0 ,v1))
         ,v1 (rotl64 13 ,v1)
         ,v1 (m64 (logxor ,v1 ,v0))
         ,v0 (rotl64 32 ,v0)
         ,v2 (m64 (+ ,v2 ,v3))
         ,v3 (rotl64 16 ,v3)
         ,v3 (m64 (logxor ,v3 ,v2))
         ,v0 (m64 (+ ,v0 ,v3))
         ,v3 (rotl64 21 ,v3)
         ,v3 (m64 (logxor ,v3 ,v0))
         ,v2 (m64 (+ ,v2 ,v1))
         ,v1 (rotl64 17 ,v1)
         ,v1 (m64 (logxor ,v1 ,v2))
         ,v2 (rotl64 32 ,v2)))

(defun sip-hash/64 (buffer size key)
  (let ((v0 #x736f6d6570736575)
        (v1 #0x646f72616e646f6d)
        (v2 #x6c7967656e657261)
        (v3 #x7465646279746573)
        (k0 (ldb (byte 64 64) key))
        (k1 (ldb (byte 64 0) key))
        (b (ash size 56))
        (last-index (- size (mod size 8)))
        (left (logand size 7)))
    (declare (uint64 v0 v1 v2 v3 k0 k1))
    (setf v3 (logxor v3 k1)
          v2 (logxor v2 k0)
          v1 (logxor v1 k1)
          v0 (logxor v0 k0))
    
    (loop for index of-type uint32 from 0 below last-index by 8
          do (let ((m (bytes->le64 buffer index)))
               (declare (uint64 m))
               (setf v3 (logxor m v3))
               (loop for i from 0 below +c-rounds+
                     do (sip-round v0 v1 v2 v3))
               (setf v0 (logxor v0 m))))

    (loop for index from 0 below left
          do (setf b (logior b (ash (aref buffer (+ last-index index)) (* 8 index)))))

    (setf v3 (logxor v3 b))

    (loop for index from 0 below +c-rounds+
          do (sip-round v0 v1 v2 v3))

    (setf v0 (logxor v0 b))

    (setf v2 (logxor v2 #xff))

    (loop for index from 0 below +d-rounds+
          do (sip-round v0 v1 v2 v3))

    (setf b (logxor v0 v1 v2 v3))

    b))

(in-package :cl-hashing)

(defmacro halfsiprounds (rounds v0 v1 v2 v3)
  `(loop for i of-type uint8 from 0 below ,rounds
         do (setf ,v0 (m32 (+ ,v0 ,v1))
                  ,v1 (rotl32 5 ,v1)
                  ,v1 (m32 (logxor ,v1 ,v0))
                  ,v0 (rotl32 16 ,v0)
                  ,v2 (m32 (+ ,v2 ,v3))
                  ,v3 (rotl32 8 ,v3)
                  ,v3 (m32 (logxor ,v3 ,v2))
                  ,v0 (m32 (+ ,v0 ,v3))
                  ,v3 (rotl32 7 ,v3)
                  ,v3 (m32 (logxor ,v3 ,v0))
                  ,v2 (m32 (+ ,v2 ,v1))
                  ,v1 (rotl32 13 ,v1)
                  ,v1 (m32 (logxor ,v1 ,v2))
                  ,v2 (rotl32 16 ,v2))))

(defmacro mid-mix-half-32-1 (v))
(defmacro mid-mix-half-32-2 (v) `(setf ,v (logxor ,v #xff)))
(defmacro finalize-half-32 (b d-rounds v0 v1 v2 v3) `(values ,b))

(defmacro mid-mix-half-64-1 (v) `(setf ,v (logxor ,v #xee)))
(defmacro mid-mix-half-64-2 (v) `(setf ,v (logxor ,v #xee)))
(defmacro finalize-half-64 (b d-rounds v0 v1 v2 v3)
  `(let ((ret (ash ,b 32)))
     (declare (uint64 ret))
     (setf ,v1 (logxor ,v1 #xdd))
     (halfsiprounds ,d-rounds ,v0 ,v1 ,v2 ,v3)
     (setf ,b (logxor ,v1 ,v3))
     (logior ret ,b)))

(defmacro finalize-half-fixnum (b d-rounds v0 v1 v2 v3)
  `(mfix (finalize-half-64 ,b ,d-rounds, v0 ,v1 ,v2, v3)))

(defmacro define-halfsiphash (name (out-type key c-rounds d-rounds mid-mix-1 mid-mix-2 finalizer))
  (with-unique-names (k0 k1)
    `(let ((,k0 (ldb (byte 32 32) ,key))
           (,k1 (ldb (byte 32 0) ,key)))
       (declaim (ftype (function (octet-array uint32) ,out-type) ,name))
       (defun ,name (buffer size)
         (declare (optimize (speed 3) (safety 0) (debug 0)))
         (let ((v0 0)
               (v1 0)
               (v2 #x6c796765)
               (v3 #x74656462)
               (b (m32 (ash size 24)))
               (last-index (- size (mod size 4)))
               (left (logand size 3)))
           (declare (uint32 v0 v1 v2 v3 ,k0 ,k1 b))
           (setf v3 (logxor v3 ,k1)
                 v2 (logxor v2 ,k0)
                 v1 (logxor v1 ,k1)
                 v0 (logxor v0 ,k0))
           (,mid-mix-1 v1)

           (loop for index of-type uint32 from 0 below last-index by 4
                 do (let ((m (bytes->le32 buffer index)))
                      (declare (uint32 m))
                      (setf v3 (logxor m v3))
                      (halfsiprounds ,c-rounds v0 v1 v2 v3)
                      (setf v0 (logxor v0 m))))
           
           (loop for index from 0 below left
                 do (setf b (logior b (ash (aref buffer (+ last-index index)) (* 8 index)))))

           (setf v3 (logxor v3 b))
           (halfsiprounds ,c-rounds v0 v1 v2 v3)
           (setf v0 (logxor v0 b))
           (,mid-mix-2 v2)
           (halfsiprounds ,d-rounds v0 v1 v2 v3)
           (setf b (logxor v1 v3))
           (,finalizer b ,d-rounds v0 v1 v2 v3))))))

(defmacro define-halfsiphash/32 (name (key c-rounds d-rounds))
  `(define-halfsiphash ,name (uint32 ,key ,c-rounds ,d-rounds mid-mix-half-32-1 mid-mix-half-32-2 finalize-half-32)))

(defmacro define-halfsiphash/64 (name (key c-rounds d-rounds))
  `(define-halfsiphash ,name (uint64 ,key ,c-rounds ,d-rounds mid-mix-half-64-1 mid-mix-half-64-2 finalize-half-64)))

(defmacro define-halfsiphash/fixnum (name (key c-rounds d-rounds))
  `(define-halfsiphash ,name (fixnum ,key ,c-rounds ,d-rounds mid-mix-half-64-1 mid-mix-half-64-2 finalize-half-fixnum)))

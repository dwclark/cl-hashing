(in-package :cl-hashing)

(declaim (type (uint32) +prime-32-1+ +prime-32-2+ +prime-32-3+ +prime-32-4+ +prime-32-5+))
(defconstant +prime-32-1+ #x9e3779b1)
(defconstant +prime-32-2+ #x85ebca77)
(defconstant +prime-32-3+ #xc2b2ae3d)
(defconstant +prime-32-4+ #x27d4eb2f)
(defconstant +prime-32-5+ #x165667b1)

(declaim (type (uint64) +prime-64-1+ +prime-64-2+ +prime-64-3+ +prime-64-4+ +prime-64-5+))
(defconstant +prime-64-1+ 11400714785074694791)
(defconstant +prime-64-2+ 14029467366897019727)
(defconstant +prime-64-3+ 1609587929392839161)
(defconstant +prime-64-4+ 9650029242287828579)
(defconstant +prime-64-5+ 2870177450012600261)

(defmacro first-mix-32 (v buffer offset)
  `(progn (setf ,v (m32 (+ ,v (* (bytes->le32 ,buffer ,offset) +prime-32-2+)))
                ,v (rotl32 13 ,v)
                ,v (m32 (* ,v +prime-32-1+)))
          (incf ,offset 4)))

(defmacro first-mix-64 (v buffer offset)
  `(progn (setf ,v (m64 (+ ,v (* (bytes->le64 ,buffer ,offset) +prime-64-2+)))
                ,v (rotl64 31 ,v)
                ,v (m64 (* ,v +prime-64-1+)))
          (incf ,offset 8)))

(defmacro second-mix-64 (hash v)
  `(setf ,v (m64 (* ,v +prime-64-2+))
         ,v (rotl64 31 ,v)
         ,v (m64 (* ,v +prime-64-1+))
         ,hash (m64 (logxor ,hash ,v))
         ,hash (m64 (+ (* ,hash +prime-64-1+) +prime-64-4+))))

(declaim (ftype (function (octet-array uint32) uint32) xxhash/32))
(defun xxhash/32 (buffer size)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let ((offset 0) (hash 0))
    (declare (uint32 hash offset))
    (if (<= 16 size)
        (let ((v1 (m32 (+ +prime-32-1+ +prime-32-2+)))
              (v2 +prime-32-2+)
              (v3 0)
              (v4 (m32 (- +prime-32-1+)))
              (limit (- size 16)))
          (declare (uint32 v1 v2 v3 v4 limit))
          (loop while (<= offset limit)
                do (progn
                     (first-mix-32 v1 buffer offset)
                     (first-mix-32 v2 buffer offset)
                     (first-mix-32 v3 buffer offset)
                     (first-mix-32 v4 buffer offset)))
          (setf hash (m32 (+ (rotl32 1 v1) (rotl32 7 v2) (rotl32 12 v3) (rotl32 18 v4)))))
        (setf hash +prime-32-5+))
    
    (setf hash (m32 (+ size hash)))
    
    (loop while (<= offset (- size 4))
          do (progn
               (setf hash (m32 (+ hash (* (bytes->le32 buffer offset) +prime-32-3+)))
                     hash (m32 (* (rotl32 17 hash) +prime-32-4+)))
               (incf offset 4)))

    (loop while (< offset size)
          do (progn
               (setf hash (m32 (+ hash (* (logand #xff (aref buffer offset)) +prime-32-5+)))
                     hash (m32 (* (rotl32 11 hash) +prime-32-1+)))
               (incf offset)))

    (setf hash (m32 (logxor hash (ash hash -15)))
          hash (m32 (* hash +prime-32-2+))
          hash (m32 (logxor hash (ash hash -13)))
          hash (m32 (* hash +prime-32-3+))
          hash (m32 (logxor hash (ash hash -16))))
    hash))

(defmacro xxhash-macro (buffer size)
  `(progn
     (let ((offset 0) (hash 0))
       (declare (uint64 hash)
                (uint32 offset))
       (if (<= 32 ,size)
           (let ((v1 (m64 (+ +prime-64-1+ +prime-64-2+)))
                 (v2 +prime-64-2+)
                 (v3 0)
                 (v4 (m64 (- +prime-64-1+)))
                 (limit (- ,size 32)))
             (declare (uint64 v1 v2 v3 v4)
                      (uint32 limit))
             (loop while (<= offset limit)
                   do (progn
                        (first-mix-64 v1 ,buffer offset)
                        (first-mix-64 v2 ,buffer offset)
                        (first-mix-64 v3 ,buffer offset)
                        (first-mix-64 v4 ,buffer offset)))
             (setf hash (m64 (+ (rotl64 1 v1) (rotl64 7 v2) (rotl64 12 v3) (rotl64 18 v4))))
             
             (second-mix-64 hash v1)
             (second-mix-64 hash v2)
             (second-mix-64 hash v3)
             (second-mix-64 hash v4))
           
           (setf hash +prime-64-5+))
       
       (setf hash (m64 (+ ,size hash)))
       
       (loop while (<= offset (- ,size 8))
             do (let ((k (bytes->le64 ,buffer offset)))
                  (declare (uint64 k))
                  (setf k (m64 (* k +prime-64-2+))
                        k (rotl64 31 k)
                        k (m64 (* k +prime-64-1+))
                        hash (m64 (logxor hash k))
                        hash (m64 (+ (* (rotl64 27 hash) +prime-64-1+) +prime-64-4+)))
                  (incf offset 8)))
       
       (when (<= offset (- ,size 4))
         (setf hash (m64 (logxor hash (* (bytes->le32 ,buffer offset) +prime-64-1+)))
               hash (m64 (+ (* (rotl64 23 hash) +prime-64-2+) +prime-64-3+)))
         (incf offset 4))
       
       (loop while (< offset ,size)
             do (progn
                  (setf hash (m64 (logxor hash (* (logand (aref ,buffer offset) #xff) +prime-64-5+)))
                        hash (m64 (* (rotl64 11 hash) +prime-64-1+)))
                  (incf offset)))
       
       (setf hash (m64 (logxor hash (ash hash -33)))
             hash (m64 (* hash +prime-64-2+))
             hash (m64 (logxor hash (ash hash -29)))
             hash (m64 (* hash +prime-64-3+))
             hash (m64 (logxor hash (ash hash -32))))
       hash)))

(declaim (ftype (function (octet-array uint32) uint64) xxhash/64))
(defun xxhash/64 (buffer size)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (xxhash-macro buffer size))

(declaim (ftype (function (octet-array uint32) fixnum) xxhash/fixnum))
(defun xxhash/fixnum (buffer size)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (mfix (xxhash-macro buffer size)))


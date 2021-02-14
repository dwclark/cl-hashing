(in-package :cl-hashing)

(defmacro define-polynomial-hash (name (out-size prime finalize))
  `(progn
     (declaim (ftype (function (octet-array uint32) (unsigned-byte ,out-size)) ,name))
     (defun ,name (buffer size)
       (declare (optimize (speed 3) (safety 0) (debug 0)))
       (loop with multiplier of-type (unsigned-byte ,out-size) = ,prime
             with hash of-type (unsigned-byte ,out-size) = ,prime
             for index of-type fixnum from 0 below size
             do (setf hash (mask-field (byte ,out-size 0) (+ (* hash multiplier) (aref buffer index))))
             finally (return (,finalize hash))))))

(define-polynomial-hash polynomial/32 (32 5231 ret-self))

(define-polynomial-hash polynomial/64 (64 7331 ret-self))

(define-polynomial-hash polynomial/fixnum (64 7331 mfix))


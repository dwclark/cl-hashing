(in-package :cl-hashing)

(deftype uint8 ()
  `(unsigned-byte 8))

(deftype int8 ()
  `(signed-byte 8))

(deftype uint16 ()
  `(unsigned-byte 16))

(deftype int16 ()
  `(signed-byte 16))

(deftype uint32 ()
  `(unsigned-byte 32))

(deftype int32 ()
  `(signed-byte 32))

(deftype uint64 ()
  `(unsigned-byte 64))

(deftype int64 ()
  `(signed-byte 64))

(deftype uint128 ()
  `(unsigned-byte 128))

(deftype int128 ()
  `(signed-byte 128))

(deftype octet-array ()
  `(simple-array uint8 *))

(defmacro m32 (val)
  `(mask-field (byte 32 0) ,val))

(defmacro m64 (val)
  `(mask-field (byte 64 0) ,val))

#+sbcl
(defmacro rotl (count bytespec integer)
  `(mask-field ,bytespec (rotate-byte ,count ,bytespec ,integer)))

#-sbcl
(defmacro rotl (count bytespec integer)
  `(logior (ldb ,bytespec (ash ,integer ,count))
           (ldb ,bytespec (ash ,integer (- ,count (car ,bytespec))))))

(defmacro rotl32 (count integer)
  `(rotl ,count (byte 32 0) ,integer))

(defmacro rotl64 (count integer)
  `(rotl ,count (byte 64 0) ,integer))

(defmacro bytes->le32 (ary offset)
  `(logior (aref ,ary ,offset)
           (ash (aref ,ary (+ 1 ,offset)) 8)
           (ash (aref ,ary (+ 2 ,offset)) 16)
           (ash (aref ,ary (+ 3 ,offset)) 24)))

(defmacro bytes->le64 (ary offset)
  `(logior (aref ,ary ,offset)
           (ash (aref ,ary (+ 1 ,offset)) 8)
           (ash (aref ,ary (+ 2 ,offset)) 16)
           (ash (aref ,ary (+ 3 ,offset)) 24)
           (ash (aref ,ary (+ 4 ,offset)) 32)
           (ash (aref ,ary (+ 5 ,offset)) 40)
           (ash (aref ,ary (+ 6 ,offset)) 48)
           (ash (aref ,ary (+ 7 ,offset)) 56)))

(defconstant +max-fixnum-bits+ (integer-length most-positive-fixnum))
(defconstant +starting-length+ 128)

(defmacro ->fixnum (&body body)
  `(ldb (byte +max-fixnum-bits+ 0) ,@body))

(declaim (ftype (function () (values octet-vector output-buffer input-buffer)) hash-io-context))
(defun hash-io-context ()
  (let* ((backing (make-octet-vector +starting-length+))
         (output (make-output-buffer :vector backing))
         (input (make-input-buffer :vector backing)))
    (values backing output input)))

(declaim (inline reset-output reset-input))

(declaim (ftype (function (output-buffer input-buffer) (values)) reset-context))
(defun reset-context (output input)
  (declare (optimize speed))
  (setf (buffer-position input) 0
        (fast-io::output-buffer-len output) 0
        (fast-io::output-buffer-fill output) 0))

(defmacro define-output-function (name (the-type arg-name) &body body)
  `(progn
     (declaim (ftype (function (output-buffer ,the-type) (values)) ,name))
     (defun ,name (context ,arg-name)
       (declare (optimize (speed 3) (safety 0)))
       ,@body)))

(defmacro define-output-inline (name (the-type arg-name) &body body)
    `(progn
     (declaim (inline ,name))
     (declaim (ftype (function (output-buffer ,the-type) (values)) ,name))
     (defun ,name (context ,arg-name)
       (declare (optimize (speed 3) (safety 0)))
       ,@body)))

(define-output-inline hash-uint8 (uint8 u) (writeu8-le u context))
(define-output-inline hash-int8 (s int8) (write8-le s context))
(define-output-inline hash-uint16 (uint16 u) (writeu16-le u context))
(define-output-inline hash-int16 (int16 s) (write16-le s context))
(define-output-inline hash-uint32 (uint32 u) (writeu32-le u context))
(define-output-inline hash-int32 (int32 s) (write32-le s context))
(define-output-inline hash-uint64 (uint64 u) (writeu64-le u context))
(define-output-inline hash-int64 (int64 s) (write64-le s context))

(define-output-inline hash-character (character c)
  (let ((u (char-int c)))
    (cond ((<= u #xFF) (hash-uint8 context u))
          ((<= u #xFFFF) (hash-uint16 context u))
          (t (hash-uint32 context u)))))

(define-output-function hash-simple-string (simple-string s)
  (loop for c character across s
        do (hash-character context c)))

(define-output-function hash-integer (integer i)
  (if (minusp i)
      (progn
        (hash-int8 context 1)
        (hash-integer context (- i)))
      (let ((num-bits (integer-length i)))
        (multiple-value-bind (quotient remainder) (floor (/ num-bits 8))
          (loop with len fixnum = (* 8 (+ quotient (if (= 0 remainder) 0 1)))
                for pos from 0 below len by 8
                do (hash-int8 context (ldb (byte 8 pos) i)))))))

(define-output-function hash-float (float f)
  (multiple-value-bind (significand exponent sign) (integer-decode-float f)
    (hash-integer context sign)
    (hash-integer context significand)
    (hash-integer context exponent)))

(define-output-function hash-symbol (symbol s)
  (hash-simple-string context (package-name (symbol-package s)))
  (hash-simple-string context (symbol-name s)))

(define-output-function hash-ratio (ratio r)
  (hash-integer context (numerator r))
  (hash-integer context (denominator r)))

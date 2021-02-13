(defpackage :cl-hashing
  (:use :cl :fast-io #+sbcl :sb-rotate-byte)
  (:import-from :alexandria :define-constant :once-only :with-unique-names)
  (:export :hash-io-context :reset-context
           
           :fnv1a/32 :fnv1a/64 :fnv1a/128 :fnv1a/256 :fnv1a/512 :fnv1a/1024

           :xxhash/32 :xxhash/64

           :siphash
           
           :hash-uint8 :hash-int8 :hash-uint16 :hash-int16
           :hash-uint32 :hash-int32 :hash-uint64 :hash-int64
           :hash-character :hash-simple-string :hash-integer
           :hash-float :hash-symbol :hash-ratio))

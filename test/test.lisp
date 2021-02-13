;; put tests here

(fiasco:define-test-package #:cl-hashing/test
    (:use :cl :cl-hashing))

(in-package #:cl-hashing/test)

(deftest test-bytes->le ()
  (is (= #xdeadbeef (cl-hashing::bytes->le32 (vector #xef #xbe #xad #xde) 0)))
  (is (= #xdeadbeefdeadbeef (cl-hashing::bytes->le64 (vector #xef #xbe #xad #xde #xef #xbe #xad #xde) 0))))

(deftest test-fnv ()
  (multiple-value-bind (buffer output input) (hash-io-context)
    (hash-simple-string output "qwertyuiop")
    (is (= #x9b89b808 (fnv1a/32 buffer 10)))
    (is (= #x6a297d225dc8acc8 (fnv1a/64 buffer 10)))))

(deftest test-xxhash/32 ()
  (multiple-value-bind (buffer output input) (hash-io-context)
    (hash-simple-string output "asdf")
    (is (= 1584409650 (xxhash/32 buffer (fast-io::output-buffer-len output))))
    (reset-context output input)
    (hash-simple-string output "qwertyuiop")
    (is (= 1976878101 (xxhash/32 buffer (fast-io::output-buffer-len output))))
    (reset-context output input)
    (hash-simple-string output "abcdefghijklmnopqrstuvwxyz")
    (is (= 1671515487 (xxhash/32 buffer (fast-io::output-buffer-len output))))))

(deftest test-xxhash/64 ()
  (multiple-value-bind (buffer output input) (hash-io-context)
    (hash-simple-string output "b")
    (is (= 8666379929374662555 (xxhash/64 buffer 1)))
    (reset-context output input)
    (hash-simple-string output "asdf")
    (is (= 4708639809588864798 (xxhash/64 buffer (fast-io::output-buffer-len output))))
    (reset-context output input)
    (hash-simple-string output "023456789")
    (is (= 7657887521216858946 (xxhash/64 buffer (fast-io::output-buffer-len output))))
    (reset-context output input)
    (hash-simple-string output "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz1")
    (is (= 7493943686480554688 (xxhash/64 buffer (fast-io::output-buffer-len output))))))

(defparameter *sip-buffer-1*
  (make-array 8 :element-type '(unsigned-byte 8) :initial-contents '(1 2 3 4 5 6 7 8)))

(defparameter *sip-buffer-2*
  (make-array 19 :element-type '(unsigned-byte 8)
                 :initial-contents '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19)))

(defparameter *sip-buffer-3*
  (make-array 37 :element-type '(unsigned-byte 8)
                 :initial-contents '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
                                     20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37)))

(deftest test-siphash ()
  (let ((key #x18171615141312111817161514131211))
    (is (= #xC266649AFC8073CD (siphash *sip-buffer-2* (length *sip-buffer-2*) key 64 2 4)))
    (is (= #xC266649AFC8073CD (siphash *sip-buffer-2* (length *sip-buffer-2*) key)))
    (is (= #xE8E704BCA160ED28 (siphash *sip-buffer-1* (length *sip-buffer-1*) key 64 2 4)))
    (is (= #x1ABA65FE6E3BDA5F12AE34E5197A8D23
           (siphash *sip-buffer-2* (length *sip-buffer-2*) key 128 2 4)))
    (is (= #xD408DC2FA9D08338782EB82C9E9725C5
           (siphash *sip-buffer-3* (length *sip-buffer-3*) key 128)))))

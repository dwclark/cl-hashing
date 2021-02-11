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
 

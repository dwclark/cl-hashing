(asdf:defsystem "cl-hashing"
  :description "Hashing algorithms for common lisp"
  :author "David Clark <daveloper9000@gmail.com>"
  :license  "Apache 2"
  :version "0.0.1"
  :pathname "src/"
  :serial t
  :depends-on ("alexandria" "fast-io" #+sbcl "sb-rotate-byte")
  :components ((:file "package")
               (:file "twiddle")
               (:file "tabulation")
               (:file "fnv")
               (:file "xxhash")))

(asdf:defsystem "cl-hashing/test"
  :depends-on ("cl-hashing" "fiasco" "alexandria")
  :pathname "test/"
  :components ((:file "test")))

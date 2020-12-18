(defpackage bank/tests/main
  (:use :cl
        :bank
        :rove))
(in-package :bank/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :bank)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))

(defsystem "bank"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "bank/tests"))))

(defsystem "bank/tests"
  :author ""
  :license ""
  :depends-on ("bank"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for bank"
  :perform (test-op (op c) (symbol-call :rove :run c)))

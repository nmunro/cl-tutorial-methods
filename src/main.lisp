(defpackage bank
  (:use :cl))
(in-package :bank)

(defclass account ()
  ((opened-date :initform (get-universal-time) :reader opened-date)
   (balance     :initarg  :balance :initform 0 :accessor balance)
   (interest    :initform 0.1      :reader interest)
   (pin         :initarg  :pin     :reader pin)))

(defclass overdraft ()
  ((opened-date :initform (get-universal-time) :reader opened-date)
   (limit       :initform :limit               :reader limit)))

(defclass current-account (account overdraft)
  ())

(defgeneric show-opened-date (acc)
  (:documentation "Formats the date when an account was opened"))

(defmethod show-opened-date ((acc account))
  (multiple-value-bind
        (second minute hour date month year day-of-week dst-p tz)
      (decode-universal-time (opened-date acc))
    (declare (ignore day-of-week))
    (declare (ignore dst-p))
    (declare (ignore tz))
    (format nil "~A/~A/~A ~A:~A:~A" year month date hour minute second)))

(defgeneric deposit (acc value)
  (:documentation "Deposits a value into an account"))

(defgeneric withdraw (acc pin value)
  (:documentation "Withdraws a value from an account"))

(defmethod deposit ((acc account) value)
  (format t "Deposit: $~A~%" value)
  (setf (balance acc) (+ (balance acc) value)))

(defmethod withdraw ((acc account) pin value)
  (cond
    ((= pin (pin acc))
     (format t "Withdraw: $~A~%" value)
     (setf (balance acc) (- (balance acc) value)))

    (t (format t "Invalid pin~%"))))

(let ((acc (make-instance 'account :pin 2563)))
  (format t "~A (~A%): $~A~%" (show-opened-date acc) (interest acc) (balance acc))
  (deposit acc 500)
  (withdraw acc 2563 147.34)
  (format t "~A (~A%): $~A~%" (show-opened-date acc) (interest acc) (balance acc)))

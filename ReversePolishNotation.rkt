#lang racket
;The base numbers and operators list
(define numList (list '+ '+ '+  1 1 1 1))
;The answer number we are checking for
(define answerNumber 4)
;Get all the permutations without any duplicates
(define permsList (remove-duplicates (permutations numList)))


;Function to check if the RPN is correct, this is the code from class
(define (valid-rpn? e[s 0])
  (if(null? e)
     (if (= s 1)
         #t
         #f)
     (if(number? (car e) )
        (valid-rpn? (cdr e) (+ s 1))
        (if(> s 1)
           (valid-rpn? (cdr e) (- s 1))
           #f))))




;Evaluate whether the permutation is valid
(define (checkExpression perms)
  ;Check whether the expression is valid or not
  (if (valid-rpn? perms)
      (evaluateRPN perms)
      null
   )
)

;Calculate the RPN
(define (evaluateRPN perms)
  ;Create the current object value
  
  ;Create our stack object as a list
  (define stack (list ))
  (for ([n perms])
    (if (number? n)
        (display "yes")
        (display "no")
    )
  )
  perms
)

;Adapted the following two stack methods from:
;http://stackoverflow.com/questions/1041603/how-do-i-write-push-and-pop-in-scheme
;Push to a list like a stack
(define (push x a-list)
  (set-box! a-list (cons x (unbox a-list))))
;Pop from a list like a stack
(define (pop a-list)
  (let ((result (first (unbox a-list))))
    (set-box! a-list (rest (unbox a-list)))
    result))

;Main 
(define ExpressionMap ( map checkExpression permsList))
;ExpressionMap

;Print the correct Equations, this is necessary as empty objects are added to the map
(for([equation ExpressionMap])
  ;Check whether the object is an expresion
  (if( null? equation)
     ""
     (display (~a  equation " = " answerNumber "\n"))
  )
 )
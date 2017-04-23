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
  perms
)

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
#lang racket
(define ns (make-base-namespace))

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
(define (evaluateRPN perm)
  ;Create the current object value
  (define currentEq 2)
  ;Create our stack object as a list
  (define stack (list ))
  ;Iterate through all the objects in the list
  (for ([n perm])
    
    (if (number? n)
        ;If it is a number add it to the stack
        (set! stack(cons n stack))
        ;If it is a sign, apply it and get the result
        (begin
          (display ('n (list-ref stack 0) (list-ref stack 1)))
          ;(createEquation (list-ref stack 0) n (list-ref stack 1) )
           )
          ;End define
          )
        ;End if
        )


    perm
 )

     ;Method for calculating the current equation
(define (createEquation oAnswer sign currentNumber)
  (define ans (~a "( " sign " "   oAnswer  " "  (~v currentNumber) " )"))
  (eval (read (open-input-string ans )))
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
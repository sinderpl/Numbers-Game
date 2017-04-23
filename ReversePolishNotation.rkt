#lang racket

;The base numbers and operators list
(define rpn-perm (list '+ '+ 1 1))
;The answer number we are checking for
(define answerNumber 4)
;Get all the permutations without any duplicates
(define perms (remove-duplicates (permutations rpn-perm)))


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


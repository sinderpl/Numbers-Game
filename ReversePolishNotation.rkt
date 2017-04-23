#lang racket


;Function to check if a valid rpn
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


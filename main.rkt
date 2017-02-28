#lang racket
;The main file for the numbers game


      ;Define the namespace
(define ns (make-base-namespace))


      ;Initialise variables
;List of the six numbers, not random for now
(define l (list 2 3 ))
;The numerical answer for the equations to calculate it
(define answerNumber 3)
;Define the possible equation list
(define answerEquations (list))
(define signList (list "+" "-" "*" "/" ))
(define permCount 0)





     ;Initial method for beginning the search
(define(findAnswers originalList oAnswer )
  
  (define sets(permutations originalList)
    )
  
  (for ([set sets])
    (display set)
    ;Outer for loop iterating through each number in list
    (for([currentNumber set])
      (set! originalList (remove currentNumber originalList))
      ;Inner for loop applying each sign to the equation
      (for ([sign signList])
        
        ;Define the current equation
        (define currentEq (createEquation oAnswer sign currentNumber));
        
        ;Calculate the current Equation
        (define currentAnswer (eval (read (open-input-string currentEq)) ns))

        ;Evaluate if answer is equal to the answer number
        (if ( = currentAnswer answerNumber)
            (begin
              (display (string-append  " success" "\n" ))
              (display (string-append (~v currentEq) " = "(~v currentAnswer) "\n") )
              (set! permCount (+ permCount 1)))
            
            (printf (string-append " failure" "\n" ))) ;TODO return)
        
        ;Evaluate if the answer is a negative number or a fraction
        (if (exact-positive-integer? currentAnswer )
            (begin
              ;Display the calculation
              ;(display (string-append (~v currentEq) " = "(~v currentAnswer) "\n") )
              (findAnswers originalList currentAnswer))
            
            (begin
              ;Display the calculation
              ;(display (string-append (~v currentEq) " = "(~v currentAnswer) "\n") )
              display "Return \n"));TODO return
        ; )
        ;Evaulate whether the list is empty and if so call the same function recursively
        ;TODO loop function
        
        )
      ;(or ((modulo currentAnswer 2) not 0))
      ; (if (<= currentAnswer 0 )
  )
 )
)

     ;Method for calculating the current equation
(define (createEquation oAnswer sign currentNumber)
  (string-append "( " sign " " (~v oAnswer)" " (~v currentNumber) " )")
)

;Call the main search method
( findAnswers l 1 )
(display permCount)



#lang racket
;The main file for the numbers game


      ;Define the namespace for string evaluations
(define ns (make-base-namespace))


      ;Variables initialisation

;List of possible numbers to choose from
(define numbers(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7  8 8 9 9 10 10 25 50 75 100))

;List for the six chosen numbers to make up the equations
(define numberList (list))

;The numerical answer for the equations to calculate it
(define answerNumber 6) ; TODO Randomise this

;Define the possible equation list
(define answerEquations (list))

;List of all the possible signs that can be used
(define signList (list "+" "-" "*" "/" ))

;Countof all the possibilities that have been checked
(define permCount 0)

;Count of all the correct possibilites that have been evaluated
(define rightPerm 0)



     ; Recursion method, iterating through the number list and sign list
     ; It explores all possible permutations (Brute force style) and kills off
     ; any branches that result in a negative number or fraction
     ; originalList - The list currently being used for iteration
     ; oAnswer - The numerical or Equation answer to the previous method call
(define(findAnswers originalList oAnswer )
  
    ;Outer for loop iterating through each number in list
    (for([currentNumber originalList])
      
      ;Remove the used number from the current list
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
              ;(display (string-append  " success" "\n" ))
              ;(display (~a  currentEq " = " currentAnswer "\n") )
              ;(if
              (set! answerEquations (cons currentEq answerEquations))
              (set! permCount (+ permCount 1))
              (set! rightPerm (+ rightPerm 1)))
            
            (begin
              ;Account for the possible permutation
              (set! permCount (+ permCount 1))
            ))
        
        ; Evaluate if the answer is a positive integer
        ; not a negative number, fraction or zero.
        ; If it is true then we follow that branch further
        ; and explore other possibilities.
        ; If it is false then we finish the statement and not follow that branch
        (if (exact-positive-integer? currentAnswer )
            (begin
              ; Call the function again to allow for further exploration of this
              ; branch of the tree. Send the updated smaller list as well as the
              ; latest equation.
              (findAnswers originalList currentEq))

            ;This is only required for the if statement purposes
            ;as a failure condition for the if statement
            (display ""))
        )
  )
 )


;List randomisation
(define (randomiseList numbers)
  (for([i 4])
    (define random-number(list-ref numbers (random (length numbers))))
    (set! numbers(remove random-number numbers))
    (set! numberList(cons random-number numberList)))
  )




    ;Original method to call with
(define (setCreate currentList)
  (define sets(permutations currentList)
    )
  (for ([set sets])
    (define firstValue (car set))
    (set! set (remove firstValue set))
    (findAnswers set firstValue)
    )
)

     ;Method for calculating the current equation
(define (createEquation oAnswer sign currentNumber)
  (~a "( " sign " "   oAnswer  " "  (~v currentNumber) " )")
)

    ;Call the main search method
(randomiseList numbers)
;(set! answerNumber  (+ (random 101 1000) answerNumber ) ) 
(display (~a " random number: " answerNumber "\n"))

;Run the program 
( setCreate numberList  )

(display (~a "Total Permutations: " permCount "\n"))
(display (~a "Correct Permutations: " rightPerm "\n"))


;Display the resulting list
(display "Equations list: \n")
(for ([equation answerEquations] )
   (display (~a equation " = " answerNumber "\n"))
)



# COUNTDOWN GAME

Author
======
Student : Alan Niemiec - G00313177

Introduction
============
A numbers game imitating the popular countdown television game show. Using the Racket functional programming language I have created a program that calculates the possible combinations of six numbers that evaluate in a Equation to a single answer number.

ReversePolishNotation.rkt
=========================
The file contains the check if RPN is valid code from class.

ForLoopGame.rkt
===============
This has been my original brute force program that iterates through every possibile equation permutation.
It is not the most efficient way of solving this problem but this was before the Reverse Polish Notation has been explained to us.

This approach also involves the possibility of lower memory computers crashing from the memory running out. Using certain tweaks in the code I have managed to get the total number of permutations required for this calculation to around 900 thousand.

The program is not efficent as it uses nested for loops for the equation numbers and signs, calling the method again each iteration.

 My modification included killing off any branches that equal to zero or less and are not positive, this was easy to achieve with some of rackets built in functions.
 ```
 (if (exact-positive-integer? currentAnswer )
```
If this statement evaluates to true we call the function again with the updated list and send it the list and the current equation that has been evaluated to a positive integer.
```
(findAnswers originalList currentEq))
```
The reason for adding the currentEq is so that we can nest the last equation inside the next one, creating a list of equations that represent actual racket equations.
```
( * ( - 6 3 ) 2 ) = 6
```
In this case the first equation ( - 6 3 ) has been evaluated, then sent to that findAnswers method again, with the originalList without the two numbers used in it. It is then evaluated along with the next number (2) then reaching 6.

When the findAnswers method is called initially in the permutations method, we have to take the initial number in the list and send it as currentEq to the method
```
(for ([set sets])
    (define firstValue (car set))
    (set! set (remove firstValue set))
    (findAnswers set firstValue)
    )
```

We can edit both the amount of numbers in the equation list and the answer number.
* Edit the list by changing the [i 6]  value to as many numbers as you need.
```
;List randomisation
(define (randomiseList numbers)
  (for([i 6])
    (define random-number(list-ref numbers (random (length numbers))))
    (set! numbers(remove random-number numbers))
    (set! numberList(cons random-number numberList)))
  )

```
* The answer number can be changed near the top of the page.
```
(define answerNumber 6)
```

## Sample Output
Sample output for a 6 number random list trying to evaluate to answer number of 6 :

```
Number list : (2 5 3 6 7 75)
Random number: 6
Total Permutations: 866732
Correct Permutations: 4870
Equations list:
( / ( + 7 5 ) 2 ) = 6
( + ( - 7 3 ) 2 ) = 6
( + ( - 7 6 ) 5 ) = 6
( * ( * ( - 7 6 ) 3 ) 2 ) = 6
( - ( + ( * ( - 7 6 ) 3 ) 5 ) 2 ) = 6
( + ( + ( - 7 6 ) 3 ) 2 ) = 6
( - ( - ( + 7 6 ) 5 ) 2 ) = 6
( * ( - 6 3 ) 2 ) = 6

...

```

* UPDATE : I have changed the forloop code and managed to cut the total permutations checked by between 50k - 100k. I have added the remove duplicates line to the permutations creator:

```
  (define sets( remove-duplicates (permutations currentList))
```
### Limitations:
* The program currently prints out duplicate answers to the equations

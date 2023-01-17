# Hungarian-optimizaion-method---MATLAB
It is a modified Hungarian algorithm that works with both square and non square matrix input.
Run the "MAIN.m" file
Input any assignment matrix as the objective matrix when prompted
If the type is maximization type then enter 1 other wise 0 when prompted
Then the max or min total is printed
After that the assignment matrix is printed where the element marked as 1 is considered assigned position, otherwise 0. Compare these matrix with the input matrix to recognize assignments.

The line matrix is given by minus signs, follow the minus trails to recognize the lines

Only unique solution sets are printed

N.B: For non square matrix this algorithm works best with matrix having one row/column short to be square

Functions used:
findminlines2coverall0(A) = to cover all the zeros with min number of lines
improve(A,linematrix) = if total line number is less than row=col number then add the min uncovered val with the intersection elements and subtract from the uncovered elements(done according to present line matrix)
finalAssignment(A) = making the final assignment sets

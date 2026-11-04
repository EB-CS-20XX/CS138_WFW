#import "../../../template.typ": project
#show: project.with(
  title: "Linear Least Squares: Solved Problems",
  contributor: "Emnace, James Jacob G.",
  date: "September 28 2026",
)

#show bibliography: set heading(numbering: none)

#set heading(numbering: none)
#set math.mat(delim: "[")

= Problem 1

Minimize the residual of an overdetermined system $1/2 norm(A x - b)_2 ^2$ subject to a strict linear equality constraint $C x = d$.

Let:

$
A = mat(delim: "[", 1, 0;0 ,1; 1, 1), b = mat(delim: "[", 2;1;4), C = mat(delim: "[", 1, -1), d = [0]
$

1. 
Compute the base components $A^T A$ and $A^T b$

$
A^T A = mat(delim: "[", 1,0,1;0,1,1) mat(delim: "[", 1,0;0,1;1,1) = mat(delim: "[",2,1;1,2)
$

$
A^T b = mat(delim: "[",1,0,1;0,1,1)mat(delim: "[",2;1;4) = mat(delim: "[",6;5)
$

2.

Apply the Lagrangian Function

$
L(x, lambda) = 1/2 x^T mat(delim: "[",2,1;1,2)x - mat(delim: "[",6,5)x + lambda( mat(delim: "[",1,-1) x- 0)
$

3.

Establish KKT System

$
mat(delim: "[", A^T A,C^T;C,0)mat(delim: "[",x;lambda) = mat(delim: "[",A^T b;d)
$

Plug in the previous values

$
mat(delim: "[",2,1,1;1,2,-1;1,-1,0) mat(delim: "[",x_1;x_2;lambda) = mat(delim: "[",6;5;0)
$

4. 

From the 3rd row of the system we get

$
x_1 - x_2 = 0
$
$
x_1 = x_2
$

Substitute these values into the 1st and 2nd row

$
2x_2 + x_2 + lambda = 6
$
$
3x_2 + lambda = 6
$
\
\
$
x_2 + 2x_2 - lambda = 5
$

$
3x_2 - lambda = 5
$

From these two equations we can get $x_1 = x_2 = 11/6$

$
lambda = 6 - 3(11/6) = 1/2
$

$x^* = mat(delim: "[", 11/6;11/6)$ with Lagrange multiplier $lambda = 1/2$

= Problem 2

Find the minimum value of the quadratic equation 
$
f (x, y) = x^2 + 4y^2 - 2x + 8y
$
with constraint $g(x,y) = x+2y = 7$

1. 

Translate to matrix form

$
A = mat(delim: "[",1,0;0,2), b =mat(delim: "[",1;-2)
$

with constraint

$
C = mat(delim: "[",1,2), d = mat(delim: "[",7)
$

2. Compute the base components $A^T A$ and $A^T b$

$
A^T A = mat(delim: "[",1,0;0,2)mat(delim: "[",1,0;0,2) = mat(delim: "[",1,0;0,4)
$

$
A^T b = mat(delim: "[",1,0;0,2)mat(delim: "[",1;-2) = mat(delim: "[",1;-4)
$

3.

Establish the KKT System

$
mat(delim: "[",A^T A, C^T;C,0)mat(delim: "[",x;lambda) = mat(delim: "[",A^T b;d)
$

Plug in the previous values

$
mat(delim: "[",1,0,1;0,4,2;1,2,0)mat(delim: "[",x;y;lambda) = mat(delim: "[",1;-4;7)
$

4.

From row 1 get $x = 1 - lambda$ and from row get $y = -1 - 1/2 lambda$

Substitute these into row 3

$
(1-lambda) + 2(-1-1/2 lambda) = 7
$

$
lambda = -4
$

Substitute $lambda$ back into row 1 and 2

$x= 5$
 
$y = 1$

$(x,y) = (5,1)$

= Problem 3 (Remix)

Minimize $1/2 norm(A x - b)_2 ^2$ subject to $C x = d$

Let:

$
A = mat(delim: "[",2,1,0;0,1,-1;1,0,1), b = mat(delim: "[",4;2;5)
$

$
C = mat(delim: "[",1,1,0;0,2,-1), d = mat(delim: "[",3;1)
$

1.

Compute the base components $A^T A$ and $A^T b$

$
A^T A = mat(delim: "[",2,0,1;1,1,0;0,-1,1)mat(delim: "[",2,1,0;0,1,-1;1,0,1) = mat(delim: "[",5,2,1;2,2,-1;1,-1,2)
$

$
A^T b = mat(delim: "[",2,0,1;1,1,0;0,-1,1)mat(delim: "[",4;2;5) = mat(delim: "[",13;6;3)
$

2.

Establish the KKT System

$
mat(delim: "[",A^T A, C^T;C,0)mat(delim: "[",x;lambda) = mat(delim: "[",A^T b;d)
$

Plug the previous values

$
mat(delim: "[",5,2,1,1,0;2,2,-1,1,2;1,-1,2,0,-1;1,1,0,0,0;0,2,-1,0,0)mat(delim: "[",x_1;x_2;x_3;lambda_1;lambda_2) = mat(delim: "[",13;6;3;3;1)
$

3.

From row 4 and row 5 get

$
x_1 = 3 - x_2
$

$
x_3 = 2x_2 - 1
$

Now get the following equations from Row 1, 2, and 3

$
5x_1 + 2x_2 + x_3 + lambda_1 = 13
\
2x_1 + 2x_2 - x_3 + lambda_1 + 2lambda_2 = 6
\
x_1 - x_2 + 2x_3 - lambda_2 = 3
$

Isolate $lambda$ in row 1 and 3

$
5(3 - x_2) + 2x_2 + (2x_2-1) + lambda_1 = 13
\
lambda_1 = x_2 - 1
$

$
(3-x_2) - x_2 + 2(2x_2 - 1) - lambda_2 = 3
\
lambda_2 = 2x_2 -2
$

Substitute all these values into row 2

$
2(3-x_2) + 2x_2 - (2x_2 - 1) + (x_2 - 1) + 2(2x_2 -2) = 6
\
2+3x_2 = 6
x_2 = 4/3
$

6.

Substitute $x_2$ into the previous equations

$
x_1 = 5/3
\
x_3 = 5/3
\
lambda_1 = 1/3
\
lambda_2 = 2/3
$

$
x^* = mat(delim: "[", 5/3;4/3;5/3), lambda^* = [1/3;2/3]
$

#bibliography("../../../resources/bibs/compendium/le1/1.4_constrained_least_squares.bib", style: "apa")
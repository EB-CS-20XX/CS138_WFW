#set page(paper: "a4", margin: (x: 2cm, y: 2cm))
#set text(font: "Liberation Serif", size: 11pt)
#set par(justify: true)

*The Formal Definition of Symmetric Positive Definite (SPD) Matrices*

*Special Matrices (Symmetric, Positive Definite Matrices)*

#block(fill: rgb("e6f2ff"), inset: 8pt, radius: 4pt, width: 100%)[
  *Definition (Symmetric Matrix)* \
  A matrix $A in M_n(RR)$ is symmetric iff $A^T = A$. \
  Let $A = [a_(i j)]_(n times n)$ , then $A$ is symmetric if and only if $a_(i j) = a_(j i)$, for all $i, j$.
]``

Consider
$ X = mat(0, 2; -2, 0) quad quad Y = mat(1, 1/2, 4; 1/2, 0, -3; 4, -3, 7) $
$Y$ is a symmetric matrix, $X$ is a skew-symmetric matrix.\
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*Deriviation:* \
Before analyzing symmetric matrix factorization, let us take a look at the expansion of the quadratic scalar function $q(x)=x^T A x$ into its individual components. \
We have:
- $(n times 1)$ vertical column of $n$ numbers for $x$ 
- $(n times n)$ $n times n $ grid of numbers for $A$
- $(1 times n )$ horizontal transpose $x^T$

#set math.mat(delim: "[")
$ x = mat(x_1; x_2; dots.v; x_n,) in RR^(n times 1),
quad
A = mat(a_11, a_12, ..., a_(1n);
        a_21, a_22, ..., a_(2n);
        dots.v, dots.v, dots.down, dots.v;
        a_(n 1), a_(n 2), ..., a_(n n);) in RR^(n times n),
quad
x^T = mat(x_1, x_2, ..., x_n) in RR^(1 times n) $
By multiplying $A times x$ we get $y=A x$ where each entry in $y_i$ is computed by taking the dot product of row $i$ of matrix $A$ with the vector $x$
#set math.mat(delim: "[")

$ y &= A x
    = mat(
      a_11, a_12, ..., a_(1n);
      a_21, a_22, ..., a_(2n);
      dots.v, dots.v, dots.down, dots.v;
      a_(n 1), a_(n 2), ..., a_(n n);) 
      mat(x_1; x_2; dots.v; x_n;) 
    = mat(
      a_11 x_1 + a_12 x_2 + ... + a_(1n) x_n;
      a_21 x_1 + a_22 x_2 + ... + a_(2n) x_n;
      dots.v;
      a_(n 1) x_1 + a_(n 2) x_2 + ... + a_(n n) x_n;
    ) 
  = mat(
      sum_(j=1)^n a_(1j) x_j;
      sum_(j=1)^n a_(2j) x_j;
      dots.v;
      sum_(j=1)^n a_(n j) x_j;) $
$q(x) = x^T y = x^T A x$. Since we already have $y$, we left-multiply it with $x^T$. In return, scales everything into a single scalar $(n times 1) times (1 times n)$ returns a $(1 times 1) $ matrix. 
$ q(x) &= x^T y
       = mat(delim: "[", x_1, x_2, ..., x_n) mat(
         delim: "[",
         sum_(j=1)^n a_(1j) x_j;
         sum_(j=1)^n a_(2j) x_j;
         dots.v;
         sum_(j=1)^n a_(n j) x_j;
       ) \
       &= x_1 (sum_(j=1)^n a_(1j) x_j) + x_2 (sum_(j=1)^n a_(2j) x_j) + ... + x_n (sum_(j=1)^n a_(n j) x_j) \
       &= sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j $
       
Since our double summation can visit every cell in an $n times n$ grid with row coords $i$ and col coords $j$, we can split thme into the following:
$
sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j = sum_(i=j) a_(i j) x_i x_j + sum_(i != j) a_(i j) x_i x_j $

The first summation sits directly on the main diagonal inwhich every column index $j$ is identically equal to the row index $i$. Thus, we can substitute $j=i$ for all col index:
// Equation (1): Diagonal terms
$ sum_(i=j) a_(i j) x_i x_j = sum_(i=1)^n a_(i i) x_i x_i = sum_(i=1)^n a_(i i) x_i^2 & quad ... (1) $

While the second summation $(i != j)$ covers the two opposite sides of the diagonal line: the strictly lower triangle $(i>j)$, and the strictly upper triangle $(j>1)$. Thus, we can write this off as the sum of the two triangular halves. It is also with certainty that swapping the $i$ and $j$ indices of the upper triangle does not change any numerical value. Then, we can relabel the upper with the same index of the lower.

$ sum_(i < j) a_(i j) x_i x_j = sum_(j < i) a_(j i) x_j x_i = sum_(i > j) a_(j i) x_i x_j $

//Equation (2): Off-diagonal decomposition 
$ sum_(i != j) a_(i j) x_i x_j = sum_(i > j) a_(i j) x_i x_j + sum_(i > j) a_(j i) x_i x_j = sum_(i > j) (a_(i j) + a_(j i)) x_i x_j $
\
Given that our matrix is symmetric, entries of $a_(i j)$ across the diagonal is idential with $a_(j i)$. Then, we can double them.
$ a_(i j) + a_(j i) = 2a_(i j) $
$ sum_(i != j) a_(i j) x_i x_j = 2sum_(i > j) a_(i j) x_i x_j & quad ... (2) $

combining both equations, we get:
$ sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j = sum_(i=1)^n a_(i i) x_i^2 + 2 sum_(i > j) a_(i j) x_i x_j $

#block(fill: rgb("e6f2ff"), inset: 8pt, radius: 4pt, width: 100%)[
  *Definition (Quadratic Form)* \
  A matrix $A in M_n(RR)$ is symmetric, then $x^T A x$ is the function
  $ x^T A x = sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j = sum_(i=1)^n a_(i i) x_i^2 + 2 sum_(i>j) a_(i j) x_i x_j. $
  This is also called a quadratic form.
]

Consider a $2 times 2$ symmetric matrix $A = mat(a_(11), a_(12); a_(12), a_(22))$ and vector $x = mat(x_1; x_2)$. 
The quadratic form expands explicitly as:
$ x^T A x = mat(x_1, x_2) mat(a_(11), a_(12); a_(12), a_(22)) mat(x_1; x_2) = a_(11) x_1^2 + 2a_(12) x_1 x_2 + a_(22) x_2^2 $
\

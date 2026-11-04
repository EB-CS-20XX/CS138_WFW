#import "../../../template.typ": project

#show: project.with(
  title: "(Chua Compendium Exercises)",
  contributor: "Nathan Kim Chua",
  date: "September 28, 2026",
)

= Problem 1 @burden2010numerical[p.569]

A persymmetric matrix is a matrix that is symmetric about both diagonals; that is, an $N times N$ matrix
$A = (a_(i j))$ is persymmetric if $a_(i j) = a_(j i) = a_(N+1-i,N+1-j)$, for all $i = 1,2,...,N$ and $j = 1,2,...,N$.

A number of problems in communication theory have solutions that involve the eigenvalues and eigenvectors of matrices that are in persymmetric form. For example, the eigenvector corresponding to the minimal eigenvalue of the $4 times 4$ persymmetric matrix

$
A =
mat(
  2, -1, 0, 0;
  -1, 2, -1, 0;
  0, -1, 2, -1;
  0, 0, -1, 2
)
$

gives the unit energy-channel impulse response for a given error sequence of length 2, and subsequently the minimum weight of any possible error sequence.

Use the Gershgorin Circle Theorem to show that if $A$ is the matrix given above and $lambda$ is its minimal eigenvalue, then
$|lambda - 4| = rho(A - 4 I)$,
where $rho$ denotes the spectral radius.

*Solution.*

  Subtract $4I$ from $A$:

  $
  A - 4I =
  mat(
    -2, -1, 0, 0;
    -1, -2, -1, 0;
    0, -1, -2, -1;
    0, 0, -1, -2
  )
  $

  Let $mu$ be an eigenvalue of $A - 4I$. Since subtracting $4I$ shifts every eigenvalue by $-4$, the eigenvalues of $A - 4I$ are
  $mu_i = lambda_i - 4$,
  where $lambda_i$ are the eigenvalues of $A$.

  For $A - 4I$, the Gershgorin disks are determined by the diagonal entries and the sums of the absolute values of the off-diagonal entries in each row.

  For rows 1 and 4:

  $
  c_1 = c_4 = -2, quad r_1 = r_4 = 1,
  $

  so the corresponding disks are

  $
  |mu + 2| <= 1.
  $

  These disks lie on the real interval $[-3,-1]$.

  For rows 2 and 3:

  $
  c_2 = c_3 = -2, quad r_2 = r_3 = 2,
  $

  so the corresponding disks are

  $
  |mu + 2| <= 2.
  $

  These disks lie on the real interval $[-4,0]$ along the real axis.

  By the Gershgorin Circle Theorem, every eigenvalue $mu$ of $A - 4I$ lies in the union of these disks. Since $A - 4I$ is symmetric, all of its eigenvalues are real. Therefore,

  $
  -4 <= mu_i <= 0
  $

  for every eigenvalue $mu_i$.

  Because $mu_i = lambda_i - 4$, and $lambda$ is the minimal eigenvalue of $A$, we have

  $
  mu_min = lambda - 4.
  $

  The Gershgorin result shows that all eigenvalues of $A - 4I$ are nonpositive. Hence the eigenvalue with the largest absolute value is the smallest eigenvalue:

  $
  rho(A - 4I)
  = max_i |mu_i|
  = |mu_min|
  = |lambda - 4|.
  $

  Since $lambda <= 4$, we can also write

  $
  |lambda - 4| = 4 - lambda.
  $

  Therefore,

  $
  #box(stroke: 0.5pt, inset: 3pt)[$|lambda - 4| = rho(A - 4I)$] 
  $

= Problem 1 Remix

Consider the centrosymmetric matrix

$

A_c =
mat(
  6, -4, 1, 0, 0;
  -4, 6, -4, 1, 0;
  1, -4, 6, -4, 1;
  0, 1, -4, 6, -4;
  0, 0, 1, -4, 6
)

$

and the persymmetric matrix

$

A_p =
mat(
  2, -1, 0, 0;
  -1, 2, -1, 0;
  0, -1, 2, -1;
  0, 0, -1, 2
).

$

Use the Gershgorin Circle Theorem to find the Gershgorin disks
for both matrices and compare the resulting bounds on their
eigenvalues.

*Solution.*

*Centrosymmetric Matrix*

For $A_c$, every diagonal entry is $6$. The Gershgorin radii are

$

r_1 = r_5 = 5,
quad
r_2 = r_4 = 9,
quad
r_3 = 10.
$

Therefore, the Gershgorin disks are

$

D_1=D_5
= {z : |z-6| <= 5},
$

$

D_2=D_4
= {z : |z-6| <= 9},
$

and

$

D_3
= {z : |z-6| <= 10}.
$

Since the disk with radius $10$ contains all the other disks, all
eigenvalues of $A_c$ lie in

$

|z-6| <= 10.
$

Since $A_c$ is symmetric, its eigenvalues are real. Thus,

$

#box(stroke: 0.5pt, inset: 3pt)[$
-4 <= lambda_i <= 16
$]


$
for every eigenvalue of $A_c$.

*Persymmetric Matrix*

For $A_p$, every diagonal entry is $2$. The radii are

$

r_1=r_4=1
$

and

$

r_2=r_3=2.
$

Therefore, the Gershgorin disks are

$

D_1=D_4
= {z : |z-2| <= 1},
$

and

$

D_2=D_3
= {z : |z-2| <= 2}.
$

The larger disk contains the smaller disks, so all eigenvalues of
$A_p$ lie in

$

|z-2| <= 2.
$

Since $A_p$ is symmetric, its eigenvalues are real. Hence,

$

#box(stroke: 0.5pt, inset: 3pt)[$
0 <= lambda_i <= 4
$]
$
for every eigenvalue of $A_p$.

*Comparison*

The Gershgorin bounds are

$

A_c: quad -4 <= lambda_i <= 16,
$

and

$

A_p: quad 0 <= lambda_i <= 4.
$

Thus, the centrosymmetric matrix has disks centered at $6$ with
radii $5$ and $10$, while the persymmetric matrix has disks centered
at $2$ with radii $1$ and $2$.

The resulting intervals are therefore

$

[-4,16]
quad "for" quad A_c
$

and

$

[0,4]
quad "for" quad A_p.
$

Hence, for these two matrices, the Gershgorin disks of the
persymmetric matrix give a narrower eigenvalue bound than those of
the centrosymmetric matrix.

= Problem 2 @burden2010numerical[p.459]

Find the first two iterations of the Jacobi method for the following linear system, using $x^((0)) = 0$.

  $
    cases(
      4 x_1 + x_2 + x_3 + x_5 = 6,
      -x_1 - 3 x_2 + x_3 + x_4 = 6,
      2 x_1 + x_2 + 5 x_3 - x_4 - x_5 = 6,
      -x_1 - x_2 - x_3 + 4 x_4 = 6,
      2 x_2 - x_3 + x_4 + 4 x_5 = 6
    )
  $
*Solution.*

Rewrite the system for Jacobi iteration

Solve each equation for its corresponding variable:

$
  x_1 = frac(6-x_2-x_3-x_5,4),
  \
  x_2 = frac(-6-x_1+x_3+x_4,3),
  \
  x_3 = frac(6-2x_1-x_2+x_4+x_5,5),
  \
  x_4 = frac(6+x_1+x_2+x_3,4),
  \
  x_5 = frac(6-2x_2+x_3-x_4,4).
$

Starting from $x^((0))=(0,0,0,0,0)^T$:

$
  x_1^((1)) = frac(6,4) = frac(3,2),
  \
  x_2^((1)) = frac(-6,3) = -2,
  \
  x_3^((1)) = frac(6,5),
  \
  x_4^((1)) = frac(6,4) = frac(3,2),
  \
  x_5^((1)) = frac(6,4) = frac(3,2).
$

Thus,

$
  #box(stroke: 0.5pt, inset: 3pt)[$(x^((1)) = mat(delim: "[", 3/2; -2; 6/5; 3/2; 3/2))$]
$

For the second iteration, substitute $x^((1))$ into every right-hand side:

$
  x_1^((2)) = frac(6-(-2)-6/5-3/2,4) = frac(53,40),
  \
  x_2^((2)) = frac(-6-3/2+6/5+3/2,3) = -frac(8,5),
  \
  x_3^((2)) = frac(6-2(3/2)-(-2)+3/2+3/2,5) = frac(8,5),
  \
  x_4^((2)) = frac(6+3/2-2+6/5,4) = frac(67,40),
  \
  x_5^((2)) = frac(6-2(-2)+6/5-3/2,4) = frac(97,40).
$

Therefore,

$
  #box(stroke: 0.5pt, inset: 3pt)[$(x^((2)) = mat(delim: "[", 53/40; -8/5; 8/5; 67/40; 97/40))$]
$

= Problem 2 Remix

Find the first two iterations of the Gauss-Seidel method for the following linear system, using $x^(0) = 0$, then compare its convergence with the Jacobi method.

  $
    cases(
      4 x_1 + x_2 + x_3 + x_5 = 6,
      -x_1 - 3 x_2 + x_3 + x_4 = 6,
      2 x_1 + x_2 + 5 x_3 - x_4 - x_5 = 6,
      -x_1 - x_2 - x_3 + 4 x_4 = 6,
      2 x_2 - x_3 + x_4 + 4 x_5 = 6
    )
  $

Starting with

$
  x^((0)) =
  mat(delim: "[",
    0;
    0;
    0;
    0;
    0
  )
$


Solving each equation for its corresponding variable gives

$
  x_1 = frac(6 - x_2 - x_3 - x_5, 4),
$

$
  x_2 = frac(-6 - x_1 + x_3 + x_4, 3),
$

$
  x_3 = frac(6 - 2x_1 - x_2 + x_4 + x_5, 5),
$

$
  x_4 = frac(6 + x_1 + x_2 + x_3, 4),
$

$
  x_5 = frac(6 - 2x_2 + x_3 - x_4, 4).
$

$$

*First Iteration*

Starting from $x^((0)) = 0$:

$
  x_1^((1))
  = frac(6 - 0 - 0 - 0, 4)
  = 1.5,
$

$
  x_2^((1))
  = frac(-6 - x_1^((1)) + 0 + 0, 3)
  = frac(-6 - 1.5, 3)
  = -2.5,
$

$
  x_3^((1))
  = frac(6 - 2x_1^((1)) - x_2^((1)) + 0 + 0, 5)
  = frac(6 - 2(1.5) - (-2.5), 5)
  = 1.1,
$

$
  x_4^((1))
  = frac(6 + x_1^((1)) + x_2^((1)) + x_3^((1)), 4)
  = frac(6 + 1.5 - 2.5 + 1.1, 4)
  = 1.525,
$

$
  x_5^((1))
  = frac(6 - 2x_2^((1)) + x_3^((1)) - x_4^((1)), 4)
  = frac(6 - 2(-2.5) + 1.1 - 1.525, 4)
  = 2.64375.
$

Therefore,

$
  #box(stroke: 0.5pt, inset: 3pt)[$
    x^((1)) =
    mat(delim: "[",
      1.5;
      -2.5;
      1.1;
      1.525;
      2.64375
    )
  $]
$

*Second Iteration*

Using the newly computed values from $x^((1))$:

$
  x_1^((2))
  = frac(6 - (-2.5) - 1.1 - 2.64375, 4)
  = 1.1890625,
$

$
  x_2^((2))
  = frac(-6 - 1.1890625 + 1.1 + 1.525, 3)
  = -1.5213542,
$

$
  x_3^((2))
  = frac(
    6 - 2(1.1890625) - (-1.5213542)
    + 1.525 + 2.64375,
    5
  )
  = 1.8623958,
$

$
  x_4^((2))
  = frac(
    6 + 1.1890625 - 1.5213542 + 1.8623958,
    4
  )
  = 1.8825260,
$

$
  x_5^((2))
  = frac(
    6 - 2(-1.5213542) + 1.8623958 - 1.8825260,
    4
  )
  = 2.2556445.
$

Therefore,

$
  #box(stroke: 0.5pt, inset: 3pt)[$
    x^((2)) =
    mat(delim: "[",
      1.1890625;
      -1.5213542;
      1.8623958;
      1.8825260;
      2.2556445
    )
  $]
$

For Jacobi iteration, the first two iterations were

$
  x_J^((1)) =
  mat(delim: "[",
    1.5;
    -2;
    1.2;
    1.5;
    1.5
  ),
$

and

$
  x_J^((2)) =
  mat(delim: "[",
    1.325;
    -1.6;
    1.6;
    1.675;
    2.425
  ).
$

For comparison, Gauss-Seidel gives

$
  x_"GS"^((1)) =
  mat(delim: "[",
    1.5;
    -2.5;
    1.1;
    1.525;
    2.64375
  ),
$

and

$
  x_"GS"^((2)) =
  mat(delim: "[",
    1.1890625;
    -1.5213542;
    1.8623958;
    1.8825260;
    2.2556445
  ).
$

*Computation of the Spectral Radius*

Write the coefficient matrix as

$
  A = D + L + U,
$

where $D$ is the diagonal part, $L$ is the strictly lower-triangular
part, and $U$ is the strictly upper-triangular part.

For this system,

$
  D =
  mat(
    4, 0, 0, 0, 0;
    0, -3, 0, 0, 0;
    0, 0, 5, 0, 0;
    0, 0, 0, 4, 0;
    0, 0, 0, 0, 4
  ),
$

$
  L =
  mat(
    0, 0, 0, 0, 0;
    -1, 0, 0, 0, 0;
    2, 1, 0, 0, 0;
    -1, -1, -1, 0, 0;
    0, 2, -1, 1, 0
  ),
$

and

$
  U =
  mat(
    0, 1, 1, 0, 1;
    0, 0, 1, 1, 0;
    0, 0, 0, -1, -1;
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0
  ).
$

*Jacobi Iteration Matrix*

For the Jacobi method,

$
  x^(k+1) = B_J x^(k) + D^(-1)b,
$

where

$
  B_J = -D^(-1)(L+U).
$

Therefore,

$
  B_J =
  mat(
    0, -0.25, -0.25, 0, -0.25;
    -0.333333, 0, 0.333333, 0.333333, 0;
    -0.4, -0.2, 0, 0.2, 0.2;
    0.25, 0.25, 0.25, 0, 0;
    0, -0.5, 0.25, -0.25, 0
  ).
$

Using a solver, the eigenvalues of $B_J$ are approximately

$
  lambda_1 = -0.455652 + 0.111190"i",
$

$
  lambda_2 = -0.455652 - 0.111190"i",
$

$
  lambda_3 = 0.417206 + 0.268835"i",
$

$
  lambda_4 = 0.417206 - 0.268835"i",
$

$
  lambda_5 = 0.076892.
$

The spectral radius is the largest absolute value of the
eigenvalues:

$
  rho(B_J)
  = max_i |lambda_i|
$

$
  = max(
    0.46903,
    0.46903,
    0.49632,
    0.49632,
    0.07689
  )
$

$
  #box(stroke: 0.5pt, inset: 3pt)[$(rho(B_J) approx 0.49632)$]
$

Since

$
  rho(B_J) < 1,
$

the Jacobi method converges.

*Gauss-Seidel Iteration Matrix*

For the Gauss-Seidel method,

$
  x^(k+1) = B_("GS") x^(k) + (D+L)^(-1)b,
$

where

$
  B_("GS") = -(D+L)^(-1)U.
$

For this system,

$
  B_("GS") approx
  mat(
    0, -0.25, -0.25, 0, -0.25;
    0, 0.083333, 0.416667, 0.333333, 0.083333;
    0, 0.083333, 0.016667, 0.133333, 0.283333;
    0, -0.020833, 0.045833, 0.116667, 0.029167;
    0, -0.015625, -0.215625, -0.162500, 0.021875
  ).
$

Using a solver, the eigenvalues of $B_("GS")$ are approximately

$
  lambda_1 = 0.094233 + 0.180899"i",
$

$
  lambda_2 = 0.094233 - 0.180899"i",
$

$
  lambda_3 = 0,
$

$
  lambda_4 = 0,
$

$
  lambda_5 = 0.050075.
$

Their absolute values are approximately

$
  |lambda_1| = |lambda_2| approx 0.203971,
$

$
  |lambda_3| = |lambda_4| = 0,
$

and

$
  |lambda_5| approx 0.050075.
$

Therefore,

$
  rho(B_("GS"))
  = max_i |lambda_i|
$

$
  #box(stroke: 0.5pt, inset: 3pt)[$(rho(B_("GS")) approx 0.20397$]
$

Since

$
  rho(B_("GS")) < 1,
$

the Gauss-Seidel method also converges.

*Comparison of Convergence*

The spectral radii are

$
  rho(B_J) approx 0.49632,
  quad
  rho(B_("GS")) approx 0.20397.
$

Thus,

$
  rho(B_("GS")) < rho(B_J).
$


The spectral radius determines the asymptotic convergence factor of
the iterative method. A smaller spectral radius indicates faster
asymptotic convergence.

Therefore, for this system, Gauss-Seidel has a smaller convergence
factor than Jacobi. This agrees with the numerical results from the first two iterations,
where the Gauss-Seidel approximation moves closer to the exact solution
more quickly.

#bibliography("../../../resources/bibs/compendium/le1/book_exercise_burden.bib", style: "apa")
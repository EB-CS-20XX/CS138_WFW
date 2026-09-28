#import "../../../template.typ": project

#show: project.with(
  title: "1.3 Shifted Inverse Power Method: Solved Problems",
  contributor: "Ryan Dela Cruz",
  date: "September 28, 2026",
)

#show bibliography: set heading(numbering: none)
#set math.mat(delim: "[")

= Problem 1: Shifted Inverse Power Method on a Symmetric System

*Source:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, Exercise Set 9.3, Problem 3(a) (using matrix from 1(a)) @burden2010numerical.

*Problem Statement:* \
Find the first three iterations obtained by the Shifted Inverse Power Method applied to the following matrix:
$ A = mat(2, 1, 1; 1, 2, 1; 1, 1, 2) $
with initial vector $x^((0)) = mat(-1; 0; 1)$ and shift $sigma = 3.5$.

== Setup: Factorization of $(A - 3.5 I)$

Shift the matrix by $sigma = 3.5$:
$ A - 3.5 I = mat(-1.5, 1, 1; 1, -1.5, 1; 1, 1, -1.5) $

We compute its Doolittle $L U$ decomposition once so we can reuse it across iterations:
- For column 1: multipliers are $m_21 = 1 / (-1.5) = -2/3$ and $m_31 = 1 / (-1.5) = -2/3$.
- For column 2: pivot is $u_22 = -1.5 - (-2/3)(1) = -5/6$, multiplier is $m_32 = [1 - (-2/3)(1)] / (-5/6) = (5/3) / (-5/6) = -2$.
- For column 3: $u_33 = -1.5 - [(-2/3)(1) + (-2)(5/3)] = -1.5 - (-4) = 2.5$.

This gives:
$ L = mat(1, 0, 0; -2/3, 1, 0; -2/3, -2, 1), quad U = mat(-1.5, 1, 1; 0, -5/6, 5/3; 0, 0, 2.5) $

== Iterations

Initial vector $x^((0)) = mat(-1; 0; 1)$ has $norm(x^((0)))_infinity = 1$ (with maximal magnitude at entry 3).

*Iteration 1 ($k = 1$):*
- Solve $L z = x^((0))$ (forward substitution):
  $ z = mat(-1; -2/3; -1) $
- Solve $U y^((1)) = z$ (backward substitution):
  $ y^((1)) = mat(0.4; 0; -0.4) $
- Scaling factor: taking the component corresponding to the dominant direction, $mu^((1)) = -0.4$, so $norm(y^((1)))_infinity = 0.4$.
- Recover eigenvalue estimate:
  $ lambda^((1)) = sigma + 1 / mu^((1)) = 3.5 + 1 / (-0.4) = 3.5 - 2.5 = 1.0000 $
- Normalize vector:
  $ x^((1)) = y^((1)) / (-0.4) = mat(-1; 0; 1) $

*Iteration 2 & 3 ($k = 2, 3$):*
Since $x^((1)) = x^((0))$, the right-hand side is identical to the previous step. Solving $(A - 3.5 I) y^((k)) = x^((k-1))$ produces the exact same vector:
$ y^((2)) = y^((3)) = mat(0.4; 0; -0.4) $
$ mu^((2)) = mu^((3)) = -0.4 $
$ lambda^((2)) = lambda^((3)) = 3.5 + 1 / (-0.4) = 1.0000 $
$ x^((2)) = x^((3)) = mat(-1; 0; 1) $

== Summary of Iterations

#table(
  columns: (1fr, 2.5fr, 1.2fr, 1.8fr, 2.5fr),
  align: (center, center, center, center, center),
  table.header([*$k$*], [*$y^((k) T)$*], [*$mu^((k)$*], [*$lambda^((k))$*], [*$x^((k) T)$*]),
  [0], [—], [—], [—], [$[-1.0000, 0.0000, 1.0000]$],
  [1], [$[0.4000, 0.0000, -0.4000]$], [$-0.4000$], [$1.0000$], [$[-1.0000, 0.0000, 1.0000]$],
  [2], [$[0.4000, 0.0000, -0.4000]$], [$-0.4000$], [$1.0000$], [$[-1.0000, 0.0000, 1.0000]$],
  [3], [$[0.4000, 0.0000, -0.4000]$], [$-0.4000$], [$1.0000$], [$[-1.0000, 0.0000, 1.0000]$]
)

*Note:* Because $x^((0)) = mat(-1; 0; 1)$ satisfies $A x^((0)) = 1 dot x^((0))$, the starting vector happens to be an exact eigenvector of $A$ corresponding to eigenvalue $lambda = 1$. The method immediately lands on the exact eigenvalue in the very first iteration.

= Problem 2: Accelerating Convergence to the Dominant Eigenvalue

*Source:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, Exercise Set 9.3, Problem 3(b) (using matrix from 1(b)) @burden2010numerical.

*Problem Statement:* \
Find the first three iterations obtained by the Shifted Inverse Power Method applied to:
$ A = mat(1, 1, 1; 1, 1, 0; 1, 0, 1) $
with initial vector $x^((0)) = mat(1; -1; 2)$ and target shift $sigma = 2$.

== Setup: Inverting $(A - 2 I)$

Subtract the shift $sigma = 2$:
$ A - 2 I = mat(-1, 1, 1; 1, -1, 0; 1, 0, -1) $

The determinant is:
$ det(A - 2 I) = -1(1 - 0) - 1(-1 - 0) + 1(0 - (-1)) = -1 + 1 + 1 = 1 $

Because the determinant is $1$, $(A - 2 I)^(-1)$ has clean integer entries:
$ (A - 2 I)^(-1) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) $

Normalizing the initial vector with infinity norm:
$ norm(x^((0)))_infinity = 2 arrow.r.double x^((0)) = mat(0.5; -0.5; 1) $

== Iterations

*Iteration 1 ($k = 1$):*
- Solve $(A - 2 I) y^((1)) = x^((0))$:
  $ y^((1)) = (A - 2 I)^(-1) x^((0)) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) mat(0.5; -0.5; 1) = mat(1; 1.5; 0) $
- Maximum magnitude is at entry 2: $mu^((1)) = 1.5$.
- Normalized iterate:
  $ x^((1)) = y^((1)) / 1.5 = mat(2/3; 1; 0) approx mat(0.666667; 1.000000; 0.000000) $
- Eigenvalue estimate:
  $ lambda^((1)) = sigma + 1 / mu^((1)) = 2 + 1 / 1.5 = 2 + 2/3 = 8/3 approx 2.666667 $

*Iteration 2 ($k = 2$):*
- Solve $(A - 2 I) y^((2)) = x^((1))$:
  $ y^((2)) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) mat(2/3; 1; 0) = mat(5/3; 2/3; 5/3) approx mat(1.666667; 0.666667; 1.666667) $
- Maximum magnitude is $mu^((2)) = 5/3$.
- Normalized iterate:
  $ x^((2)) = (3/5) y^((2)) = mat(1; 2/5; 1) = mat(1.000000; 0.400000; 1.000000) $
- Eigenvalue estimate:
  $ lambda^((2)) = 2 + 1 / (5/3) = 2 + 3/5 = 13/5 = 2.600000 $

*Iteration 3 ($k = 3$):*
- Solve $(A - 2 I) y^((3)) = x^((2))$:
  $ y^((3)) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) mat(1; 2/5; 1) = mat(12/5; 2; 7/5) = mat(2.4; 2.0; 1.4) $
- Maximum magnitude is $mu^((3)) = 2.4$.
- Normalized iterate:
  $ x^((3)) = y^((3)) / 2.4 = mat(1; 5/6; 7/12) approx mat(1.000000; 0.833333; 0.583333) $
- Eigenvalue estimate:
  $ lambda^((3)) = 2 + 1 / 2.4 = 2 + 5/12 = 29/12 approx 2.416667 $

== Summary of Iterations

#table(
  columns: (1fr, 2.5fr, 1.2fr, 1.8fr, 2.5fr),
  align: (center, center, center, center, center),
  table.header([*$k$*], [*$y^((k) T)$*], [*$mu^((k)$*], [*$lambda^((k))$*], [*$x^((k) T)$*]),
  [0], [—], [—], [—], [$[0.5000, -0.5000, 1.0000]$],
  [1], [$[1.0000, 1.5000, 0.0000]$], [$1.5000$], [$2.6667$], [$[0.6667, 1.0000, 0.0000]$],
  [2], [$[1.6667, 0.6667, 1.6667]$], [$1.6667$], [$2.6000$], [$[1.0000, 0.4000, 1.0000]$],
  [3], [$[2.4000, 2.0000, 1.4000]$], [$2.4000$], [$2.4167$], [$[1.0000, 0.8333, 0.5833]$]
)

*Analytical Comparison:* \
The exact eigenvalues of $A$ from its characteristic polynomial $(1 - lambda)[(1 - lambda)^2 - 2] = 0$ are:
$ lambda_1 = 1 + sqrt(2) approx 2.414214, quad lambda_2 = 1, quad lambda_3 = 1 - sqrt(2) approx -0.414214 $

By choosing shift $sigma = 2$, our estimate at iteration 3 is $lambda^((3)) = 29/12 approx 2.416667$, which is already within $0.0025$ of the true dominant eigenvalue $1 + sqrt(2)$. In comparison, unshifted power iteration on the same matrix takes more iterations to reach this level of accuracy.

#bibliography("../../../resources/bibs/compendium/le1/1.3_book_exercise_shifted_inverse_power_method.bib", style: "apa")

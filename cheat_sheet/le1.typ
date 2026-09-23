#set page(paper: "a4", margin: (x: 1.5cm, y: 1.5cm))
#set text(font: "Liberation Sans", size: 9.5pt)

#show heading.where(level: 2): set text(size: 13pt)
#show heading.where(level: 3): set text(size: 10.5pt)

== 1. Symbols Reference

#table(
  columns: (1.2fr, 2.5fr, 4.3fr),
  stroke: luma(200),
  fill: (col, row) => if row == 0 { rgb("f0f4f8") } else { none },
  [*Symbol*], [*Name*], [*Definition*],
  [$A$], [Coefficient Matrix], [System matrix $A in bb(R)^(n times n)$ for linear equations $A x = b$],
  [$b$], [Right-Hand Side Vector], [Target column vector $b in bb(R)^n$],
  [$x$], [Exact Solution Vector], [True unknown vector satisfying $A x = b$],
  [$hat(x)$ or $x^((k))$], [Approximate Solution], [Computed or $k$-th iteration solution vector],
  [$r$], [Residual Vector], [$r = b - A hat(x)$ (measures discrepancy in system constraint)],
  [$e$], [Error Vector], [$e = x - hat(x)$ (difference from true solution)],
  [$D$], [Diagonal Matrix Part], [$D = "diag"(a_11, a_22, ..., a_(n n))$ from $A = D + L + U$],
  [$L$], [Strictly Lower Part], [Strictly lower triangular matrix ($a_(i j)$ for $i > j$)],
  [$U$], [Strictly Upper Part], [Strictly upper triangular matrix ($a_(i j)$ for $i < j$)],
  [$T$], [Iteration Matrix], [Transition matrix in $x^((k)) = T x^((k-1)) + c$ ($T_J, T_"GS", T_omega$)],
  [$c$], [Iteration Constant], [Offset vector in $x^((k)) = T x^((k-1)) + c$ ($c_J, c_"GS", c_omega$)],
  [$k$], [Iteration Counter], [Step index $k = 1, 2, 3, ...$ in iterative schemes],
  [$omega$], [Relaxation Parameter], [Weighting scalar in SOR ($omega > 1$ for over-relaxation)],
  [$kappa(A)$ / $"cond"(A)$], [Condition Number], [$kappa(A) = ||A|| dot ||A^(-1)||$ (measures numerical sensitivity)],
  [$||A||$], [Induced Matrix Norm], [$||A|| = max_(x != 0) (||A x|| / ||x||)$ (e.g., $1$-norm or $oo$-norm)],
  [$rho(T)$], [Spectral Radius], [$rho(T) = max_i |lambda_i(T)|$ (governs convergence if $rho(T) < 1$)]
)

#v(1em)
#set page(columns: 2)

== 2. Linear Systems/Sensitivity Analysis
#line(length: 100%, stroke: 0.5pt + luma(200))
- *System Form:* $A x = b$
- *Column Sum Norm ($1$-norm):*
  $ ||A||_1 = max_(1 <= j <= n) sum_(i=1)^n |a_(i j)| $
- *Row Sum Norm ($oo$-norm):*
  $ ||A||_oo = max_(1 <= i <= n) sum_(j=1)^n |a_(i j)| $

#v(0.5em)
#text(weight: "bold")[Residual & Sensitivity Bounds]
#line(length: 100%, stroke: 0.5pt + luma(200))
- *Residual Vector:* $r = b - A hat(x)$
- *Relative Error Bound:*
  $ (||x - hat(x)||) / (||x||) <= kappa(A) (||r||) / (||A|| ||hat(x)||) $
- *Trustworthy Decimals ($d$):*
  $ d = |log_10 (epsilon_m)| - log_10 (kappa(A)) $

== 3. Direct Matrix Decompositions

=== 3.1 Matrix Splitting
$ A = D + L + U $
where $D$ is diagonal, $L$ is strictly lower triangular, and $U$ is strictly upper triangular.

=== 3.2 LU Factorization ($A = L U$)
Transforms a non-singular matrix into lower ($L$) and upper ($U$) triangular factors.

- *Doolittle Factorization* (Diagonal $l_(i i) = 1$):
  $ u_(k j) &= a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j), quad &j = k, dots, n \
    l_(i k) &= 1 / u_(k k) (a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k)), quad &i = k+1, dots, n $

- *Crout Factorization* (Diagonal $u_(i i) = 1$):
  $ l_(i k) &= a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k), quad &i = k, dots, n \
    u_(k j) &= 1 / l_(k k) (a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j)), quad &j = k+1, dots, n $

=== 3.3 Cholesky Factorization ($A = L L^T$)
Applicable ONLY to Symmetric Positive Definite (SPD) matrices ($A^T = A$ and $x^T A x > 0, forall x != 0$).

- *Quadratic Form:*
  $ q(x) = x^T A x = sum_(i=1)^n a_(i i) x_i^2 + 2 sum_(i > j) a_(i j) x_i x_j > 0 $

- *Diagonal Factor Entries ($i = j$):*
  $ l_(j j) = sqrt(a_(j j) - sum_(k=1)^(j-1) l_(j k)^2) $

- *Off-Diagonal Factor Entries ($i > j$):*
  $ l_(i j) = 1 / l_(j j) (a_(i j) - sum_(k=1)^(j-1) l_(i k) l_(j k)) $

== 4. Iterative Methods
#line(length: 100%, stroke: 0.5pt + luma(200))

=== 4.1 Jacobi Method ($A = D + L + U$)
- *Matrix Form:*
  $ x^((k)) = -D^(-1)(L + U)x^((k-1)) + D^(-1)b $
  $ T_J = -D^(-1)(L + U), quad c_J = D^(-1)b $
- *Component Form:*
  $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1, j != i)^n a_(i j) x_j^((k-1)) ) $

=== 4.2 Gauss-Seidel Method ($A = D + L + U$)
- *Matrix Form:*
  $ x^((k)) = -(D + L)^(-1) U x^((k-1)) + (D + L)^(-1) b $
  $ T_"GS" = -(D + L)^(-1) U, quad c_"GS" = (D + L)^(-1) b $
- *Component Form:*
  $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1)^(i-1) a_(i j) x_j^((k)) - sum_(j=i+1)^n a_(i j) x_j^((k-1)) ) $

=== 4.3 SOR Method ($A = D + L + U$)
- *Matrix Form:*
  $ x^((k)) = (D - omega L)^(-1) [(1 - omega)D + omega U] x^((k-1)) + omega (D - omega L)^(-1) b $
  $ T_omega = (D - omega L)^(-1) [(1 - omega)D + omega U], quad c_omega = omega (D - omega L)^(-1) b $
- *Component Form:*
  $ x_i^((k)) = (1 - omega)x_i^((k-1)) + omega / a_(i i) [b_i - sum_(j=1)^(i-1) a_(i j) x_j^((k)) - sum_(j=i+1)^n a_(i j) x_j^((k-1))] $

== 5. Iterative Refinement
#line(length: 100%, stroke: 0.5pt + luma(200))

- *Residual Vector:*
  $ r = b - A hat(x) $

- *Error Vector:*
  $ e = x - hat(x) $

- *Condition Number:*
  $ kappa(A) = ||A|| dot ||A^(-1)|| $
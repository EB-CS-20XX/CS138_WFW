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
  [$rho(T)$], [Spectral Radius], [$rho(T) = max_i |lambda_i(T)|$ (governs convergence if $rho(T) < 1$)],
  [$chevron.l x, y chevron.r$],[Dot Product],[Get the dot product between vectors $x$ and $y$]
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

  == 6. Eigenvalue Approximation

  === 6.1 Power Methods
  These methods are used to approximate eigenvalues by approximating eigenvectors. Once an approximate eigenvector $x^(\(k\))$ has been found, it can be used to calculate its associated eigenvalue
  ==== 6.1.1 Calculating Eigenvalue from Eigenvector
  ==== 6.1.1.1 Infinity Norm
  $ lambda = ||x^(\(k\))||_infinity $
  But only before normalization
  ==== 6.1.1.2 Rayleigh Quotient
  $ lambda = (x^(\(k\)T)A x^(\(k\)))/(x^(\(k\)T)x^(\(k\))) $
  ==== 6.1.2 Power Method
  Approximates the eigenvector associated with the largest eigenvalue $|lambda_1|$
  $ x^(\(k+1\)) = A x^(\(k\)) $

  === 6.1.3 Normalized Power method
  FApproximates the eigenvector associated with the largest eigenvalue $|lambda_1|$, but without the values of $x^(\(k\))$ going crazy
  $ x^(\(k+1\)) = (A x^(\(k\)))/(||A x^(\(k\))||_infinity) $

  Normalization of this kind can be applied to other Power Methods.
  === 6.1.4 Inverse Power Method
  Approximates the eigenvector associated with the eigenvalue $1/(|lambda_n|)$. From there you can derive the smallest eigenvalue $|lambda_n|$.
  $ x^(\(k+1\)) = A^(-1) x^(\(k\)) $
  or
  $ A x^(\(k+1\)) =  x^(\(k\)) $
  === 6.1.5 Shifted Inverse Power Method
  Approximates the eigenvector associated with the eigenvalue $|lambda|$ closest to some $sigma$.
  $ x^((k+1)) = (A - sigma I)^(-1) x^((k)) $
  or
  $ (A - sigma I) x^((k+1)) = x^((k)) $

  === 6.2 Gershgorin Circle Theorem
  The Shifted Inverse Power Method works best when $sigma$ is close to $lambda$. The Gershgorin Circle Theorem allows us to calculate bounds for a matrix's eigenvalues, giving us some idea of where they are. 

  ==== 6.2.1 Theorem
  For any complex eigenvalues, for any rows $i$ of the $n$x$n$ matrix $A$.

  $ |lambda - a_(i\i)| <= |limits(sum)_(c=1,c!=i)^n a_(i\c)| $

  This theorem lets us define circles on the complex plane, wherein the eigenvalues of $A$ are.
  
  Any circles that do not intersect with other circles must have an eigenvalue inside them. Any $k$ circles that intersect must have $k$ eigenvalues within their union.
  ==== 6.2.2 Gershgorin Discs

  $ D_i = {z ∈ CC: |z-a_(\i\i)| <= |limits(sum)_(c=1, c!=i)^n a_(i\c)|}$

  === 6.3 QR Factorization
  You wish to factor a matrix $A$ such that $A = Q\R$.

  $A = mat(delim: "[",
  dots.v, dots.v, dots.v;
  a_1, a_2, a_3;
  dots.v, dots.v, dots.v;
  )$
  $Q = mat(delim: "[",
  dots.v, dots.v, dots.v;
  q_1, q_2, q_3;
  dots.v, dots.v, dots.v;
  )$
  $R = mat(delim: "[",
  r_11, r_12, r_13;
  0, r_22, r_23;
  0,0,r_33)$

  $v_1 = a_(1)$, $r_11 = ||v_1||_2$, $q_1 = v_1/r_11$

  $r_12 = chevron.l q_1, a_2 chevron.r$
  
  $v_2 = a_2 - r_12q_1$
  
  $r_22 = ||v_2||_2$, $q_2 = v_2/r_22$

  $r_13 = chevron.l q_1, a_3 chevron.r$, $r_23 = chevron.l q_2, a_3 chevron.r$

  $v_3 = a_3 - r_13q_1 - r_23q_2$
  
  $r_33 = ||v_3||_2$, $q_3 = v_3/r_33$

  ...

  $r_(j\i) = cases(
    chevron.l q_j\, a_i chevron.r\, "if" j<i,
    0\,"if" j>i
  )$

  $v_i = a_i - limits(sum)_(j=1)^(i-1) r_(j\i)q_j$

  $r_(i\i) = ||v_i||_2$, $q_i = v_i/r_(i\i)$

  


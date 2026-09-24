#set page(paper: "a4", margin: (x: 2cm, y: 2cm))
#set text(font: "Liberation Serif", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true)
#set math.mat(delim: "[")

#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)

#show bibliography: set heading(numbering: none)
#let small(body) = text(size: 9.5pt, body)

#align(center)[
  #text(size: 18pt, weight: "bold")[CS138-Typst Notes] \
  #v(1em)
  #text(size: 14pt)[CS138 WFW] \
  #v(0.5em)
  S.Y. 2026 -- 2027
]
#v(2em)

#outline(title: "Contents")
#v(2em)
#line(length: 100%)
#v(2em)
#pagebreak()

= Applied Linear Algebra

#heading(level: 2, numbering: none)[1.0. [W0] Introduction to System of Linear Equations (SLEs)]

=== [W0] NLA: Introduction of Linear Systems

==== Systems of Linear Algebraic Equations (SLEs)
#pad(left: 2em)[
  A general system of $n$ linear equations with $n$ unknowns is: @burden2010numerical[p.362]
  $
    cases(
      a_11 x_1 + a_12 x_2 + ... + a_(1n) x_n = b_1,
      a_21 x_1 + a_22 x_2 + ... + a_(2n) x_n = b_2,
      dots.v,
      a_(n 1) x_1 + a_(n 2) x_2 + ... + a_(n n) x_n = b_n
    )
  $
  In matrix form, this is expressed as $A x = b$, or using the augmented matrix $[A | b]$.

    #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Existence and Uniqueness of Solutions
    #line(length: 100%)
    - *Nonsingular matrix $A$*: Exactly one unique solution exists ($x = A^(-1) b$).
    - *Singular matrix $A$*:
      - If $b in "span"(A)$: *Infinitely many solutions* (system is consistent).
      - If $b cancel(in) "span"(A)$: *No solution* (system is inconsistent).
  ]
]

==== Matrix Norms
#pad(left: 2em)[
  For $A in M_n (RR)$, the induced matrix norm is: @burden2010numerical[p.432]
  $ ||A|| = max_(x != 0) frac(||A x||, ||x||) $

  - *1-norm (maximum absolute column sum):* $||A||_1 = max_j sum_(i=1)^n |a_(i j)|$
  - *$oo$-norm (maximum absolute row sum):* $||A||_oo = max_i sum_(j=1)^n |a_(i j)|$
  - *2-norm (maximum singular value)*: $||A||_2 = max_(||x||_2 = 1) ||A x||_2$

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Properties of Norms
    #line(length: 100%)
    #set enum(numbering: "1.a)")
    + $||A|| > 0$ if $A != 0$
    + $||alpha A|| = |alpha| dot ||A|| forall alpha in RR$
    + $||A+B|| <= ||A||+||B||$
    + $||A B|| <= ||A|| dot ||B||$
    + $||A x|| <= ||A|| dot ||x|| forall x in RR^n$
  ]
]

==== Condition Number
#pad(left: 2em)[
  The condition number measures the sensitivity of the solution to perturbations in $A$ and $b$: @burden2010numerical[p.470-473]
  $ "cond"(A) equiv ||A|| ||A^(-1)||, quad 1 <= "cond"(A) <= oo $
  
  - *Well-conditioned:* $"cond"(A) approx 1$ (small perturbations yield small changes in $x$).
  - *Ill-conditioned:* $"cond"(A) >> 1$ (small errors or round-offs cause massive changes in $x$).
  - *Singular:* $"cond"(A) = oo$.
]

==== Residual Analysis
#pad(left: 2em)[
  Given an approximate computed solution $hat(x)$: @ruaya2026intro[Slide 18]
  - *True error:* $e = x - hat(x)$ ($x$ is mostly unknown).
  - *Residual vector:* $r = b - A hat(x)$.
  - *Relation:* $frac(||Delta x||, ||x||) <= "cond"(A) frac(||r||, ||A|| ||hat(x)||)$
    - If $A$ is well-conditioned, a small residual guarantees a small error.
    - If $A$ is ill-conditioned, $hat(x)$ can produce a tiny residual $r$ while still having large error $e$.

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Note on Precision
    #line(length: 100%)
    If input data is stored to machine precision $epsilon_m$, the number of trustworthy decimal digits $d$ in the computed solution is: @ruaya2026intro[Slide 35]
    $ d = |log_10 (epsilon_m)| - log_10 ("cond"(A)) $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Worked Example: Norms and Condition Number
    #line(length: 100%)
    Consider the matrix:
    $ A = mat(1, 2; 1.001, 2) $
    
    *1. Compute Matrix Norms:*
    - Maximum column sum ($1$-norm):
      $ ||A||_1 = max(|1| + |1.001|, |2| + |2|) = max(2.001, 4) = 4 $
    - Maximum row sum ($oo$-norm):
      $ ||A||_oo = max(|1| + |2|, |1.001| + |2|) = max(3, 3.001) = 3.001 $
    
    *2. Compute Inverse:*
    $ det(A) = (1)(2) - (2)(1.001) = 2 - 2.002 = -0.002 $
    $ A^(-1) = frac(1, -0.002) mat(2, -2; -1.001, 1) = mat(-1000, 1000; 500.5, -500) $
    
    *3. Evaluate Condition Number ($oo$-norm):*
    $ ||A^(-1)||_oo = max(|-1000| + |1000|, |500.5| + |-500|) = max(2000, 1000.5) = 2000 $
    $ "cond"_oo (A) = ||A||_oo dot ||A^(-1)||_oo = (3.001)(2000) = 6002 $
    
    Because $"cond"_oo (A) approx 6 times 10^3 >> 1$, the system is ill-conditioned. A relative error in $b$ could be amplified by up to a factor of $6002$ in the solution $x$, causing a loss of $log_10(6002) approx 3.78$ digits of precision.
  ]
]

== [W1-2] Direct Methods for solving SLEs
#align(right)[_*1.1a. System of Linear Algebraic Equations 1: Introduction, Direct Methods*_]

=== [W1] NLA: Gaussian Elimination, Pivoting

==== Direct Methods: Gaussian Elimination
#pad(left: 2em)[
  Elementary row operations preserve the solution space: @ruaya2026direct[Slides 23-26]
  #set enum(numbering: "1.")
  + Swapping two rows ($R_i <-> R_j$).
  + Multiplying a row by a non-zero scalar ($R_i <- c R_i$).
  + Adding a multiple of one row to another ($R_i <- R_i + c R_j$).

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Naive Gaussian Elimination Algorithm
    #line(length: 100%)
    Transforms $A x = b$ into an upper triangular system $U x = c$:
    
    *1. Elimination Phase (Forward):* \
    $ 
      mat(augment: #(-1),
        a_11, a_12, dots, a_(1k), dots, a_(1j), dots, a_(1n), b_1;
        a_21, a_22, dots, a_(2k), dots, a_(2j), dots, a_(2n), b_2;
        dots.v, dots.v, , dots.v, , dots.v, , dots.v, dots.v;
        0, 0, dots, a_(k k), dots, a_(k j), dots, a_(k n), b_k;
        dots.v, dots.v, , dots.v, , dots.v, , dots.v, dots.v;
        0, 0, dots, a_(i k), dots, a_(i j), dots, a_(i n), b_i;
        dots.v, dots.v, , dots.v, , dots.v, , dots.v, dots.v;
        0, 0, dots, a_(n k), dots, a_(n j), dots, a_(n n), b_n;
      )
    $
    For pivot row $k = 1, dots, n-1$: \
    For target row $i = k+1, dots, n$:
    $ gamma &= frac(a_(i k), a_(k k)) \
      a_(i j) &<- a_(i j) - gamma a_(k j), quad j = k, dots, n \
      b_i &<- b_i - gamma b_k $

    *2. Back Substitution Phase:*
    $ x_n &= frac(b_n, a_(n n)) \
      x_k &= frac(1, a_(k k)) [b_k - sum_(j=k+1)^n a_(k j) x_j], quad k = n-1, n-2, dots, 1 $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Worked Example: Naive Gaussian Elimination
    #line(length: 100%)
    Solve the following $3 times 3$ system:
    $ cases(
        2x_1 + x_2 - x_3 = 8,
        -3x_1 - x_2 + 2x_3 = -11,
        -2x_1 + x_2 + 2x_3 = -3
      )
    $

    *Step 1: Augmented Matrix Setup*
    $ [A | b] = mat(augment: #(-1), 2, 1, -1, 8; -3, -1, 2, -11; -2, 1, 2, -3) $

    *Step 2: Forward Elimination ($k=1$)*
    - Pivot $a_(1 1) = 2$.
    - Row 2 elimination ($i=2$): multiplier $gamma_(2 1) = frac(-3, 2) = -1.5$.
      $ R_2 &<- R_2 - (-1.5) R_1 \
        a_(2 2) &= -1 - (-1.5)(1) = 0.5 \
        a_(2 3) &= 2 - (-1.5)(-1) = 0.5 \
        b_2 &= -11 - (-1.5)(8) = 1 $
    - Row 3 elimination ($i=3$): multiplier $gamma_(3 1) = frac(-2, 2) = -1$.
      $ R_3 &<- R_3 - (-1) R_1 \
        a_(3 2) &= 1 - (-1)(1) = 2 \
        a_(3 3) &= 2 - (-1)(-1) = 1 \
        b_3 &= -3 - (-1)(8) = 5 $

    Matrix after step 1:
    $ mat(augment: #(-1), 2, 1, -1, 8; 0, 0.5, 0.5, 1; 0, 2, 1, 5) $

    *Step 3: Forward Elimination ($k=2$)*
    - Pivot $a_(2 2) = 0.5$.
    - Row 3 elimination ($i=3$): multiplier $gamma_(3 2) = frac(2, 0.5) = 4$.
      $ R_3 &<- R_3 - 4 R_2 \
        a_(3 3) &= 1 - (4)(0.5) = -1 \
        b_3 &= 5 - (4)(1) = 1 $

    Upper-triangular system:
    $ mat(augment: #(-1), 2, 1, -1, 8; 0, 0.5, 0.5, 1; 0, 0, -1, 1) $

    *Step 4: Backward Substitution*
    $ x_3 &= frac(1, -1) = -1 \
      x_2 &= frac(1 - (0.5)(-1), 0.5) = frac(1.5, 0.5) = 3 \
      x_1 &= frac(8 - (1)(3) - (-1)(-1), 2) = frac(8 - 3 - 1, 2) = 2 $

    Solution vector: $x = mat(2; 3; -1)$.
  ]
]

==== Pivoting Strategies
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Partial Pivoting
    #line(length: 100%)
    - Search the current column below, including the diagonal to find the maximum entry: @ruaya2026direct[Slides 27-28]
      $ |a_(i_p, k)| = max_(k <= i <= n) |a_(i, k)| $
    - Swap row $k$ with row $i_p$. No variable reordering needed.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Worked Example: Partial Pivoting
    #line(length: 100%)
    Consider solving the system below using 3-digit rounding arithmetic:
    $ mat(augment: #(-1), 0.0002, 3, 9; 2, 1, 7) $
    Solution: $x_1 approx 2.0001$, $x_2 approx 2.9999$

    *1. Without Pivoting (Naive Elimination):*
    - Use $a_(1 1) = 0.0002$ as the pivot. Compute multiplier:
      $ gamma = frac(2, 0.0002) = 10000 = 1.00 times 10^4 $
    - Row 2 update:
      $ a_(2 2) &= 1 - (1.00 times 10^4)(3) = 1 - 30000 = -29999 approx -3.00 times 10^4 \
        b_2 &= 7 - (1.00 times 10^4)(9) = 7 - 90000 = -89993 approx -9.00 times 10^4 $
    - Back substitution:
      $ x_2 &= frac(-9.00 times 10^4, -3.00 times 10^4) = 3.00 \
        x_1 &= frac(9 - 3(3.00), 0.0002) = frac(0, 0.0002) = 0 $
      $x_1 = 0$ is incorrect (true value is $approx 2.00$).

    *2. With Partial Pivoting:*
    - Compare column 1 candidates: $|a_(2 1)| = 2 > |a_(1 1)| = 0.0002$.
    - Swap rows ($R_1 <-> R_2$):
      $ mat(augment: #(-1), 2, 1, 7; 0.0002, 3, 9) $
    - The elimination multiplier is now bounded ($|gamma| <= 1$):
      $ gamma = frac(0.0002, 2) = 0.0001 = 1.00 times 10^(-4) $
    - Row 2 update:
      $ a_(2 2) &= 3 - (1.00 times 10^(-4))(1) = 2.9999 approx 3.00 \
        b_2 &= 9 - (1.00 times 10^(-4))(7) = 8.9993 approx 9.00 $
    - Back substitution:
      $ x_2 &= frac(9.00, 3.00) = 3.00 \
        x_1 &= frac(7 - 1(3.00), 2) = frac(4.00, 2) = 2.00 $
    With partial pivoting, we get $x = mat(2.00; 3.00)$.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Full Pivoting
    #line(length: 100%)
    - Search the entire remaining active submatrix: @ruaya2026direct[Slide 29-31]
      $ |a_(r, c)| = max_(k <= i, j <= n) |a_(i, j)| $
    - Then swap row $k$ with row $r$, and swap column $k$ with column $c$.
    - It is the most numerically stable, but very expensive in resources and requires permuting elements of the solution vector.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Scaled Partial Pivoting
    #line(length: 100%)
    Simulates full pivoting without actual column exchanges and without physically copying large row vectors in memory. @ruaya2026direct[Slide 32-34]

    - *Compute scale factors (row maximums):*
      $ s_i = max_(1 <= j <= n) |a_(i j)|, quad i = 1, dots, n $
    - *Initialize the row-order vector $ell$:*
      $ ell = [1, 2, dots, n] $
    - *At pivot column $k$ (for $k = 1, dots, n-1$):*
      - Choose $j$ that maximizes:
        $ frac(|a_(ell_j, k)|, s_(ell_j)) = max_(k <= i <= n) frac(|a_(ell_i, k)|, s_(ell_i)) $
      - Swap $ell_j$ and $ell_k$ in the row-order vector $ell$.
      - For $i = k+1, dots, n$, compute:
        $ m_(i k) = frac(a_(ell_i, k), a_(ell_k, k)) $
      - Update rows:
        $ R_(ell_i) <- R_(ell_i) - m_(i k) R_(ell_k) quad "for" k+1 <= i <= n $
    - *Back Substitution with Row-Order Vector $ell$:*
      $ x_n &= frac(b_(ell_n), a_(ell_n, n)) \
        x_k &= frac(1, a_(ell_k, k)) [b_(ell_k) - sum_(j=k+1)^n a_(ell_k, j) x_j], quad k = n-1, dots, 1 $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Worked Example: Scaled Partial Pivoting
    #line(length: 100%)
    $ mat(augment: #(-1), 2, 10, 100, 112; 1, 1, 1, 3; 3, 1, 2, 6) $

    *Scale Vector and Initial Row-Order Vector*
    - Compute row maximums:
      - Row 1: $s_1 = max(|2|, |10|, |100|) = 100$
      - Row 2: $s_2 = max(|1|, |1|, |1|) = 1$
      - Row 3: $s_3 = max(|3|, |1|, |2|) = 3$
      - Scale vector: $s = [100, 1, 3]$
    - Initial row-order vector: $ell = [1, 2, 3]$

    *Pivot Selection and Elimination ($k=1$)*
    - At column $k = 1$, choose $j$ that maximizes $frac(|a_(ell_i, 1)|, s_(ell_i))$ for $1 <= i <= 3$:
      - $i = 1 (ell_1 = 1): frac(|a_(1 1)|, s_1) = frac(2, 100) = 0.02$
      - $i = 2 (ell_2 = 2): frac(|a_(2 1)|, s_2) = frac(1, 1) = 1.0$
      - $i = 3 (ell_3 = 3): frac(|a_(3 1)|, s_3) = frac(3, 3) = 1.0$
    - The maximum is $1.0$ at $j = 2$ (row 2). Swap $ell_2$ and $ell_1$ in the row-order vector $ell$:
      $ ell = [2, 1, 3] $
    - For $i = 2, 3$, compute multipliers and update rows using pivot row $ell_1 = 2$:
      - For $i = 2 (ell_2 = 1)$:
        $ m_(2 1) &= frac(a_(ell_2, 1), a_(ell_1, 1)) = frac(a_(1 1), a_(2 1)) = frac(2, 1) = 2 \
          R_1 &<- R_1 - 2 R_2 \
          a_(1 2) &<- 10 - 2(1) = 8, quad a_(1 3) <- 100 - 2(1) = 98, quad b_1 <- 112 - 2(3) = 106 $
      - For $i = 3 (ell_3 = 3)$:
        $ m_(3 1) &= frac(a_(ell_3, 1), a_(ell_1, 1)) = frac(a_(3 1), a_(2 1)) = frac(3, 1) = 3 \
          R_3 &<- R_3 - 3 R_2 \
          a_(3 2) &<- 1 - 3(1) = -2, quad a_(3 3) <- 2 - 3(1) = -1, quad b_3 <- 6 - 3(3) = -3 $

    *Pivot Selection and Elimination ($k=2$)*
    - At column $k = 2$, choose $j$ that maximizes $frac(|a_(ell_i, 2)|, s_(ell_i))$ for $2 <= i <= 3$:
      - $i = 2 (ell_2 = 1): frac(|a_(1 2)|, s_1) = frac(8, 100) = 0.08$
      - $i = 3 (ell_3 = 3): frac(|a_(3 2)|, s_3) = frac(|-2|, 3) approx 0.667$
    - The maximum is at $j = 3$ (row 3). Swap $ell_3$ and $ell_2$ in the row-order vector $ell$:
      $ ell = [2, 3, 1] $
    - For $i = 3$, compute multiplier and update row using pivot row $ell_2 = 3$:
      $ m_(3 2) &= frac(a_(ell_3, 2), a_(ell_2, 2)) = frac(a_(1 2), a_(3 2)) = frac(8, -2) = -4 \
        R_1 &<- R_1 - (-4) R_3 \
        a_(1 3) &<- 98 - (-4)(-1) = 94, quad b_1 <- 106 - (-4)(-3) = 94 $

    *Back Substitution with $ell = [2, 3, 1]$*
    - For $x_3$ (from row $ell_3 = 1$):
      $ x_3 = frac(b_(ell_3), a_(ell_3, 3)) = frac(b_1, a_(1 3)) = frac(94, 94) = 1 $
    - For $x_2$ (from row $ell_2 = 3$):
      $ x_2 = frac(b_(ell_2) - a_(ell_2, 3) x_3, a_(ell_2, 2)) = frac(-3 - (-1)(1), -2) = 1 $
    - For $x_1$ (from row $ell_1 = 2$):
      $ x_1 = frac(b_(ell_1) - a_(ell_1, 2) x_2 - a_(ell_1, 3) x_3, a_(ell_1, 1)) = frac(3 - 1(1) - 1(1), 1) = 1 $

    Final solution: $x = mat(1; 1; 1)$.
  ]
]

==== Triangular Solvers
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Substitution Methods
    #line(length: 100%)
    - *Forward Substitution ($L y = b$):* \
      For lower triangular matrices. Solve top-to-bottom starting with $y_1$:
      $ y_1 = frac(b_1, l_(1 1)), quad y_i = frac(1, l_(i i)) [b_i - sum_(j=1)^(i-1) l_(i j) y_j] $
    - *Backward Substitution ($U x = y$):* \
      For upper triangular matrices. Solve bottom-to-top starting with $x_n$:
      $ x_n = frac(y_n, u_(n n)), quad x_i = frac(1, u_(i i)) [y_i - sum_(j=i+1)^n u_(i j) x_j] $
  ]
]

=== [W1] NLA: LU Decomposition

==== Introduction & Motivation
#pad(left: 2em)[
  Consider the matrix equation $A x = b$.

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Problem: Gaussian Elimination
    #line(length: 100%)
    Solving $A x = b$ repeats the entire elimination for every new $b$, even with the same $A$ ($arrow.r$ _redundant_).
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Attempt: Matrix Inverse
    #line(length: 100%)
    Solve for $A^(-1)$ once, then reuse it for any $b$:
    $ A x = b &==> A^(-1) A x = A^(-1) b ==> x = A^(-1) b $

    _Recall:_ $A^(-1)$ is similar to applying Gauss-Jordan Reduction (GJR) on the augmented matrix $[A | e_i]$ where $I_n = [e_1 quad e_2 quad dots quad e_n]$ ($arrow.r$ _costs $n$ additional solves_).
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Solution: LU Decomposition
    #line(length: 100%)
    Factor $A$ once as $A = L U$ where:

    - $A$: original non-singular matrix
    - $L$: lower triangular matrix, all elements above the main diagonal are zero.
    - $U$: upper triangular matrix, all elements below the main diagonal are zero.

    $ mat(
      a_11, a_12, dots.h, a_(1 n);
      a_21, a_22, dots.h, a_(2 n);
      dots.v, dots.v, dots.down, dots.v;
      a_(n 1), a_(n 2), dots.h, a_(n n)
    )
    =
    mat(
      l_11, 0, dots.h, 0;
      l_21, l_22, dots.h, 0;
      dots.v, dots.v, dots.down, dots.v;
      l_(n 1), l_(n 2), dots.h, l_(n n)
    )
    mat(
      u_11, u_12, dots.h, u_(1 n);
      0, u_22, dots.h, u_(2 n);
      dots.v, dots.v, dots.down, dots.v;
      0, 0, dots.h, u_(n n)
    ) $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Solving $A x = b$ with $L U$
    #line(length: 100%)
    Reuse $L$ and $U$ for any $b$ by solving $A x = b ==> (L U)x = b$:

    + Let $y = U x$
    + *Forward substitution:* solve the lower triangular system $L y = b$ for vector $y$.
      $ y_1 &= b_1 / l_11 \
        y_i &= 1 / l_(i i) (b_i - sum_(j=1)^(i-1) l_(i j) y_j), quad i = 2, dots, n $
    + *Backward substitution:* solve the upper triangular system $U x = y$ for solution $x$.
      $ x_n &= y_n / u_(n n) \
        x_i &= 1 / u_(i i) (y_i - sum_(j=i+1)^(n) u_(i j) x_j), quad i = n-1, n-2, dots, 1 $
  ]
]

==== Why This Works & Formal Definition
#pad(left: 2em)[
  Recall from GE that we transform a matrix $A arrow.r U$ using Elementary Row Operations (EROs). Each ERO is a left multiplication by an elementary matrix $E$. If $R = E_n dots E_2 E_1$ transforms $A arrow.r U$, then:

  $ E_n dots E_2 E_1 A &= U \
    A &= R^(-1) U = (E_1^(-1) E_2^(-1) dots E_n^(-1)) U \
    L &= R^(-1) = E_1^(-1) E_2^(-1) dots E_n^(-1) quad ==> quad A = L U $

  $L$ is lower triangular and stores the multipliers $gamma$ used in the EROs (e.g., $R_2 arrow.l R_2 + (-gamma) R_1$) #cite(<strang2023>).

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Definition: LU Factorization
    #line(length: 100%)
    A non-singular matrix $A$ has an LU factorization if it can be expressed as $A = L U$ #cite(<kiusalaas2013>). The decomposition is not unique unless specific constraints are placed:

    - *Doolittle Decomposition:* $L$ has 1s on its diagonal.
    - *Crout Decomposition:* $U$ has 1s on its diagonal.
    - *Cholesky Decomposition:* $U = L^T$ (or $L = U^T$, for SPD matrices).
  ]
]

==== Doolittle Decomposition
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Format
    #line(length: 100%)
    Store each multiplier in the lower triangular portion of the coefficient matrix, setting *supposed $l_(i i) = 1$*.

    $ bold([L | U]) = mat(
      u_11, u_12, u_13, dots.h, u_(1 n);
      l_21, u_22, u_23, dots.h, u_(2 n);
      l_31, l_32, u_33, dots.h, u_(3 n);
      dots.v, dots.v, dots.v, dots.down, dots.v;
      l_(n 1), l_(n 2), l_(n 3), dots.h, u_(n n)
    ) $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Doolittle Algorithm Steps
    #line(length: 100%)
    + Calculate the first row of $U$: $u_(1 j) = a_(1 j), quad forall j = 1, dots, n$.
    + Set 1s on the diagonal of $L$: $l_(i i) = 1, quad forall i = 1, dots, n$.
    + Calculate the first column of $L$: $l_(i 1) = a_(i 1) / u_11, quad forall i = 2, dots, n$.
    + For $k = 2, dots, n$:
      - *Row of $U$:* $u_(k j) = a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j)$ for $j = k, dots, n$.
      - *Column of $L$:* $l_(i k) = (a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k)) / u_(k k)$ for $i = k+1, dots, n$.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Worked Example: Doolittle Decomposition
    #line(length: 100%)
    Given $A = mat(1, 4, 1; 1, 6, -1; 2, -1, 2)$, $b = mat(7; 13; 5)$:

    - $k = 1$: $u_11 = 1, u_12 = 4, u_13 = 1$; $l_21 = 1, l_31 = 2$.
    - $k = 2$: $u_22 = 6 - (1)(4) = 2$, $u_23 = -1 - (1)(1) = -2$; $l_32 = (-1 - (2)(4)) / 2 = -9/2$.
    - $k = 3$: $u_33 = 2 - ((2)(1) + (-9/2)(-2)) = -9$.
    - *Resulting Factors:*
      $ L = mat(1, 0, 0; 1, 1, 0; 2, -9/2, 1),
        quad U = mat(1, 4, 1; 0, 2, -2; 0, 0, -9) $
    - *Solving:* Forward substitution yields $y = mat(7; 6; 18)$; Backward substitution yields $x = mat(5; 1; -2)$.
  ]
]

==== Crout Decomposition
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Format
    #line(length: 100%)
    Set *supposed $u_(i i) = 1$*.

    $ bold([L | U]) = mat(
      l_11, u_12, u_13, dots.h, u_(1 n);
      l_21, l_22, u_23, dots.h, u_(2 n);
      l_31, l_32, l_33, dots.h, u_(3 n);
      dots.v, dots.v, dots.v, dots.down, dots.v;
      l_(n 1), l_(n 2), l_(n 3), dots.h, l_(n n)
    ) $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Crout Algorithm Steps
    #line(length: 100%)
    + Calculate the first column of $L$: $l_(i 1) = a_(i 1), quad forall i = 1, dots, n$.
    + Set 1s on the diagonal of $U$: $u_(i i) = 1, quad forall i = 1, dots, n$.
    + Calculate the first row of $U$: $u_(1 j) = a_(1 j) / l_11, quad forall j = 2, dots, n$.
    + For $k = 2, dots, n$:
      - *Column of $L$:* $l_(i k) = a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k)$ for $i = k, dots, n$.
      - *Row of $U$:* $u_(k j) = (a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j)) / l_(k k)$ for $j = k+1, dots, n$.
  ]
]

==== LDU Decomposition
#pad(left: 2em)[
  To resolve non-uniqueness, factor out diagonal pivot values into a separate matrix $D$:

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Definition: $L D U$
    #line(length: 100%)
    $ A = L D U $
    where $L$ and $U$ have ones on the main diagonal, and $D = "diag"(d_1, d_2, dots, d_n)$ contains the pivots.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Theorem (Unique Factorization):* If $A$ is non-singular and transformable to $U$ without row interchanges, the factorization $A = L D U$ is unique.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Form Transformations
    #line(length: 100%)
    - *Doolittle to Crout:* $L_C = L_D D$, $U_C = D^(-1) U_D$
    - *Crout to Doolittle:* $L_D = L_C D^(-1)$, $U_D = D U_C$
  ]
]

==== AI Contribution

_I asked Claude to help me with some of the formatting in Typst for this document. \
Conversation:_ #link("https://claude.ai/share/a2c73a0e-7515-493e-b290-2af4721afa06")


=== [W2] NLA: Positive Definite Matrices, Cholesky Factorization

==== Special Matrices
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Symmetric Matrix
    #line(length: 100%)
    A matrix $A in M_n(RR)$ is symmetric iff $A^T = A$. \
    Let $A = [a_(i j)]_(n times n)$ , then $A$ is symmetric if and only if $a_(i j) = a_(j i)$, for all $i, j$.
  ]

  Consider
  $ X = mat(0, 2; -2, 0) quad quad Y = mat(1, 1/2, 4; 1/2, 0, -3; 4, -3, 7) $
  $Y$ is a symmetric matrix, $X$ is a skew-symmetric matrix.
]

==== Derivation of the Quadratic Form
#pad(left: 2em)[
  Before analyzing symmetric matrix factorization, let us take a look at the expansion of the quadratic scalar function $q(x)=x^T A x$ into its individual components. \
  We have:
  - $(n times 1)$ vertical column of $n$ numbers for $x$ 
  - $(n times n)$ $n times n $ grid of numbers for $A$
  - $(1 times n )$ horizontal transpose $x^T$

  $ x = mat(x_1; x_2; dots.v; x_n) in RR^(n times 1),
  quad
  A = mat(a_11, a_12, ..., a_(1n);
          a_21, a_22, ..., a_(2n);
          dots.v, dots.v, dots.down, dots.v;
          a_(n 1), a_(n 2), ..., a_(n n)) in RR^(n times n),
  quad
  x^T = mat(x_1, x_2, ..., x_n) in RR^(1 times n) $

  By multiplying $A times x$ we get $y=A x$ where each entry in $y_i$ is computed by taking the dot product of row $i$ of matrix $A$ with the vector $x$:

  $ y &= A x
      = mat(
        a_11, a_12, ..., a_(1n);
        a_21, a_22, ..., a_(2n);
        dots.v, dots.v, dots.down, dots.v;
        a_(n 1), a_(n 2), ..., a_(n n)) 
        mat(x_1; x_2; dots.v; x_n) 
      = mat(
        a_11 x_1 + a_12 x_2 + ... + a_(1n) x_n;
        a_21 x_1 + a_22 x_2 + ... + a_(2n) x_n;
        dots.v;
        a_(n 1) x_1 + a_(n 2) x_2 + ... + a_(n n) x_n
      ) 
    = mat(
        sum_(j=1)^n a_(1j) x_j;
        sum_(j=1)^n a_(2j) x_j;
        dots.v;
        sum_(j=1)^n a_(n j) x_j) $

  $q(x) = x^T y = x^T A x$. Since we already have $y$, we left-multiply it with $x^T$. In return, it scales everything into a single scalar; $(1 times n) times (n times 1)$ returns a $(1 times 1) $ matrix. 
  $ q(x) &= x^T y
         = mat(delim: "[", x_1, x_2, ..., x_n) mat(
           delim: "[",
           sum_(j=1)^n a_(1j) x_j;
           sum_(j=1)^n a_(2j) x_j;
           dots.v;
           sum_(j=1)^n a_(n j) x_j
         ) \
         &= x_1 (sum_(j=1)^n a_(1j) x_j) + x_2 (sum_(j=1)^n a_(2j) x_j) + ... + x_n (sum_(j=1)^n a_(n j) x_j) \
         &= sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j $
         
  Since our double summation can visit every cell in an $n times n$ grid with row coords $i$ and col coords $j$, we can split them into the following:
  $ sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j = sum_(i=j) a_(i j) x_i x_j + sum_(i != j) a_(i j) x_i x_j $

  The first summation sits directly on the main diagonal in which every column index $j$ is identically equal to the row index $i$. Thus, we can substitute $j=i$ for all col index:
  $ sum_(i=j) a_(i j) x_i x_j = sum_(i=1)^n a_(i i) x_i x_i = sum_(i=1)^n a_(i i) x_i^2 & quad ... (1) $

  While the second summation $(i != j)$ covers the two opposite sides of the diagonal line: the strictly lower triangle $(i>j)$, and the strictly upper triangle $(j>i)$. Thus, we can write this off as the sum of the two triangular halves. It is also with certainty that swapping the $i$ and $j$ indices of the upper triangle does not change any numerical value. Then, we can relabel the upper with the same index of the lower.

  $ sum_(i < j) a_(i j) x_i x_j = sum_(j < i) a_(j i) x_j x_i = sum_(i > j) a_(j i) x_i x_j $

  $ sum_(i != j) a_(i j) x_i x_j = sum_(i > j) a_(i j) x_i x_j + sum_(i > j) a_(j i) x_i x_j = sum_(i > j) (a_(i j) + a_(j i)) x_i x_j $
  \
  Given that our matrix is symmetric, entries of $a_(i j)$ across the diagonal is identical with $a_(j i)$. Then, we can double them.
  $ a_(i j) + a_(j i) = 2a_(i j) $
  $ sum_(i != j) a_(i j) x_i x_j = 2sum_(i > j) a_(i j) x_i x_j & quad ... (2) $

  Combining both equations, we get:
  $ sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j = sum_(i=1)^n a_(i i) x_i^2 + 2 sum_(i > j) a_(i j) x_i x_j $

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Quadratic Form
    #line(length: 100%)
    A matrix $A in M_n(RR)$ is symmetric, then $x^T A x$ is the function
    $ x^T A x = sum_(i=1)^n sum_(j=1)^n a_(i j) x_i x_j = sum_(i=1)^n a_(i i) x_i^2 + 2 sum_(i>j) a_(i j) x_i x_j. $
    This is also called a quadratic form.
  ]

  Consider a $2 times 2$ symmetric matrix $A = mat(a_(11), a_(12); a_(12), a_(22))$ and vector $x = mat(x_1; x_2)$. 
  The quadratic form expands explicitly as:
  $ x^T A x = mat(x_1, x_2) mat(a_(11), a_(12); a_(12), a_(22)) mat(x_1; x_2) = a_(11) x_1^2 + 2a_(12) x_1 x_2 + a_(22) x_2^2 $
]

==== Positive Definite & SPD Matrices
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Positive Definite Matrix
    #line(length: 100%)
    A matrix $A in M_n(RR)$ is positive definite iff $A$ is symmetric and for every $x != 0$, 
    $x^T A x = x dot (A x) > 0$. Equivalently, $lambda_i > 0$ for all eigenvalues of $A$.
  ]
  To look at an analogy, let's take a 1D parabola, $z=a x^2$, which curves strictly upward with a y-intercept at $x=0$ iff $a>0$. In an $n$ dimension space, we would have $z=x^T A x$ with infinitely many directions to look at. Let $x=t v$ where v is a unit direction vector, and t is a constant distance. \
  $ z &= (t v)^T A(t v)\
      &= (v^T A v) t^2 \ 
    a_v &= (v^T A v) \
    z &= a_v t^2 $
  Wherein $a_v$ is a single scalar number along the vector v. Generally, we define a Positive Definite Matrix as a matrix with directional coefficients strictly positive $(a_v >0)$ such that the surface curves upward in every direction we look at. It follows that all eigenvalues must be positive $(lambda_i > 0)$, which guarantees that the shape of the graph is upward opening. 

  *Remarks:*
  + Setting $x = e_i$ (the $i$-th standard basis vector) reveals that all main diagonal entries of a positive definite matrix must be strictly positive: $a_(i i) > 0$.
  + A simple example of a positive definite matrix is the Identity matrix $I$, since $x^T I x = ||x||_2^2 > 0$ for all $x != bold(0)$.
  
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
    *Note:* A matrix is positive definite if its quadratic form acts like a strictly positive "squared magnitude" for every possible non-zero direction in space.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Symmetric Positive Definite (SPD) Matrix
    #line(length: 100%)
    A real matrix $A in bb(M)_n(bb(R))$ is *Symmetric Positive Definite (SPD)* if and only if it satisfies two strict criteria:

    + $A$ is symmetric: $A^T = A$.
    + For every non-zero vector $x in bb(R)^n without {bold(0)}$, the scalar quadratic form is strictly positive:
  ]
  
  *Remarks: *
  1. Setting $x = e_i$ (the $i$-th standard basis vector) reveals an immediate necessary property for all diagonal entries of an SPD matrix:
  $ e_i^T A e_i = a_(i i) > 0 quad forall i in {1, 2, dots, n} $
  2. Testing along an eigenvector direction $x = v != bold(0)$ reveals:
  $ A v = lambda v ==> v^T A v = lambda v^T v = lambda ||v||_2^2 > 0 ==> lambda > 0 $
  3. Every eigenvalue of an SPD matrix is real and strictly positive ($lambda_i > 0$).
  4. An SPD matrix defines an inner product $chevron((x , y)_A) = x^T A y$ and induces a valid vector norm: $ norm(x)_A = sqrt(x^T A x) $
]

==== Cholesky's Decomposition
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Definition
    #line(length: 100%)
    Every positive definite matrix $A in M_n(RR)$ can be factored as $A = L L^T$, where $L$ is lower triangular with positive diagonal entries. $L$ is called the Choleski factor of $A$.

    It can be interpreted as a triangular "square root" of a positive definite matrix:
    $ A = L D L^T = L (D^(1/2) D^(1/2)) L^T = underbrace((L D^(1/2)), L) underbrace((D^(1/2) L^T), L^T) = L L^T $
    
    *Limitation:*
    Since $L L^T$ is always a symmetric matrix, Choleski's decomposition requires $A$ to be symmetric.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== The Matrices & Formulas
    #line(length: 100%)
    Choleski's decomposition method returns a lower triangular matrix $L$ and its transpose $L^T$ such that $A = L L^T$:
    $ L = mat(
      l_(11), 0, 0, dots, 0;
      l_(21), l_(22), 0, dots, 0;
      l_(31), l_(32), l_(33), dots, 0;
      dots.v, dots.v, dots.v, dots.down, dots.v;
      l_(n 1), l_(n 2), l_(n 3), dots, l_(n n)
    ) quad "and" quad
    L^T = mat(
      l_(11), l_(12), l_(13), dots, l_(1n);
      0, l_(22), l_(23), dots, l_(2n);
      0, 0, l_(33), dots, l_(3n);
      dots.v, dots.v, dots.v, dots.down, dots.v;
      0, 0, 0, dots, l_(n n)
    ) $

    A typical element in the lower triangular portion of $L L^T$ is of the form:
    $ (L L^T)_(i j) = l_(i 1) l_(j 1) + l_(i 2) l_(j 2) + ... + l_(i n) l_(j n) = sum_(k=1)^n l_(i k) l_(j k), quad i >= j $

    Equating this to the corresponding element of $A$ yields:
    $ a_(i j) = sum_(k=1)^j l_(i k) l_(j k), quad i = j, j+1, ..., n, quad j = 1, 2, ..., n $

    Taking out the term containing $l_(i j)$ outside the summation:
    $ a_(i j) = sum_(k=1)^(j-1) l_(i k) l_(j k) + l_(i j) l_(j j) $

    *Formula 1: Diagonal Term (If $i = j$)*
    $ l_(j j) = sqrt(a_(j j) - sum_(k=1)^(j-1) underbrace(l_(j k)^2, "Left of " l_(j j))), quad j = 2, 3, ..., n. $

    $ mat(
      X, 0, 0, 0, 0, 0, 0;
      "", X, 0, 0, 0, 0, 0;
      "", "", X, 0, 0, 0, 0;
      l_(i 1), l_(i 2), l_(i 3), sqrt(a_(i i) - sum(l_(j k))^2), 0, 0, 0;
      "", "", "", "", *, 0, 0;
      "", "", "", "", "", *, 0;
      "", "", "", "", "", "", *
    ) $

    *Formula 2: Nondiagonal Term (Else, $i > j$)*
    $ l_(i j) = 1/l_(j j) (a_(i j) - sum_(k=1)^(j-1) underbrace(l_(i k) l_(j k), "Dot"("Pair"_k))), quad i = j+1, j+2, ..., n. $

    $ mat(
      X, 0, 0, 0, 0, 0, 0, 0;
      "", X, 0, 0, 0, 0, 0, 0;
      "", "", X, 0, 0, 0, 0, 0;
      "", "", "", X, 0, 0, 0, 0;
      P_1, P_2, P_3, P_4, "", X, 0, 0;
      "", "", "", "", "", "", X, 0;
      P'_1, P'_2, P'_3, P'_4, 1/l_"diag"(a_"diag" - sum(P_k dot P'_k)), l_(j j), *, 0;
      *, *, *, *, *, *, *, *
    ) $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Steps
    #line(length: 100%)
    + Start with the first diagonal term, $l_(11)$; use Diagonal formula ($i = j$).
    + Compute the non-diagonal entries underneath the diagonal term (column).
    + Move on to the next diagonal term $l_(22)$.
    + Compute the non-diagonal entries underneath $l_(22)$.
    + Repeat for all diagonal entries until $L$ is populated.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Worked Examples
    #line(length: 100%)
    
    *Example 1:*
    Find the Choleski's decomposition of the matrix:
    $ A = mat(
      4, -2, 2;
      -2, 2, -4;
      2, -4, 11
    ) $

    *Solution:*
    - $l_(11) = sqrt(a_(11)) = sqrt(4) = 2$
    #v(0.01em)
    - $l_(21) = a_(21)/l_(11) = -2/2 = -1$
    #v(0.01em)
    - $l_(31) = a_(31)/l_(11) = 2/2 = 1$
    #v(0.01em)
    - $l_(22) = sqrt(a_(22) - l_(21)^2) = sqrt(2 - (-1)^2) = 1$
    #v(0.01em)
    - $l_(32) = (a_(32) - l_(21)l_(31))/l_(22) = (-4 - (-1)(1))/1 = -3$
    #v(0.01em)
    - $l_(33) = sqrt(a_(33) - l_(31)^2 - l_(32)^2) = sqrt(11 - 1^2 - (-3)^2) = 1$

    $ L = mat(
      2, 0, 0;
      -1, 1, 0;
      1, -3, 1
    ) $

    *Example 2:*
    Find the Choleski's decomposition of the matrix:
    $ A = mat(
      1, 1, 1;
      1, 2, 2;
      1, 2, 3
    ) $

    *Solution:*
    - $l_(11) = sqrt(a_(11)) = sqrt(1) = 1$
    #v(0.01em)
    - $l_(21) = a_(21)/l_(11) = 1/1 = 1$
    #v(0.01em)
    - $l_(31) = a_(31)/l_(11) = 1/1 = 1$ 
    #v(0.01em)
    - $l_(22) = sqrt(a_(22) - l_(21)^2) = sqrt(2 - 1^2) = 1$
    #v(0.01em)
    - $l_(32) = (a_(32) - l_(21)l_(31))/l_(22) = (2 - (1)(1))/1 = 1$
    #v(0.01em)
    - $l_(33) = sqrt(a_(33) - l_(31)^2 - l_(32)^2) = sqrt(3 - 1^2 - 1^2) = 1$

    $ L = mat(
      1, 0, 0;
      1, 1, 0;
      1, 1, 1
    ) $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Algorithmic Remarks
    #line(length: 100%)
    - Note that $a_(i j)$ appears only in the formula for $l_(i j)$. Thus, once $l_(i j)$ has been computed, $a_(i j)$ is no longer needed.
    - This makes it possible to write the elements of $L$ over the lower triangular portion of $A$ as they are computed. 
    - The elements above the leading diagonal of $A$ remain unchanged.
    - After the coefficient matrix $A$ is decomposed, the solution of $A x = b$ is obtained by forward and back substitution.
    
    *Remark about efficiency:*
    #set enum(indent: 10pt, numbering: (n) => [ *#n.* ])
    Cholesky Factorization offers massive performance advantages over standard LU (Doolittle/Crout) decompositions:
    + *Speed (1/3 $n^3$ Flops):* Because the matrix is symmetric, the factorization only requires $1/2$ of arithmetic operations (approximately $1/3 n^3$ flops compared to $2/3 n^3$ for LU). 
    + *Memory (50% Storage):* The matrix $A$ can be overwritten by $L$. Since $L^T$ is just the transpose of $L$, you only need to store the lower triangular half of the matrix, cutting memory requirements in half.
  ]
]

== [W3] Iterative Methods for solving SLEs, Iterative Refinement
#align(right)[_*1.1b. System of Linear Algebraic Equations 2: Iterative Methods*_]

=== [W2] NLA: Iterative Methods, Jacobi and Gauss-Seidel Method

==== What are Iterative Methods?
#pad(left: 2em)[
  ===== Definition
  *Iterative methods* are algorithms used to solve systems of linear equations. Compared to direct methods, iterative methods are much more efficient at processing sparse matrices (i.e., large systems with a high percentage of zero entries).
  
  ===== General Algorithm  
  Iterative methods generally start with some linear system _Ax=b_ and an initial guess $x^((0))$, which is used to generate a sequence of vectors $lr(\{ bold(x)^((k)) \})_(k=0)^oo$ that converge to x. More explicitly, we get this equation: $x^((k)) = T x^((k-1)) + c$, where _T_ is the iteration matrix.

  *Note:* $x^((k)) = T x^((k-1)) + c$ converges to the exact solution $x$ for any $x^((0))$ if and only if $rho(T)<1$. 

  ===== Initial Guess $x^((0))$ 
  The initial guess $x^((0))$ is often just the zero vector. However, in cases when additional information is available, a better guess may be used, which significantly reduces the number of iterations required to produce a result below a given error tolerance.

  *Note:* In well-behaved systems (e.g., SDD matrices), convergence to the exact solution is guaranteed mathematically.
]

==== Concepts to Recall
#pad(left: 2em)[
  ===== Matrix Norms 
    #pad(left: 1em)[
      - Two Norm $||A||_2 = sqrt(lambda_("max")(A^T A))$
      - Infinity Norm $||A||_oo = max_(1 <= i <= n) sum_(j=1)^n |a_(i j)|$
    ]
  ===== Norm Properties
  #pad(left: 1em)[
    + Non-negativity: $||A|| >= 0;$
    + Definiteness: $||A|| = 0$, iff $A$ is a matrix with all 0 entries;
    + Homogeneity $||alpha A|| = |alpha| ||A||$, for any scalar $alpha;$
    + Triangle Inequality: $||A + B|| <= ||A|| + ||B||;$
    + Submultiplicativity: $||A B|| <= ||A|| ||B||.$
  ]
  
  ===== Convergent Matrices
  A square matrix A is convergent if: 
  $ lim_(k -> oo) (A^k)_(i j) = 0, quad "for each" i = 1, 2, ..., n "and" j = 1, 2, ..., n. $
  
  *Remark:* This only occurs when $rho(A)<1$

  ===== Spectral Radius ($rho$)
  The spectral radius is the magnitude of the largest possible eigenvalue of matrix A: $rho(A) = max_(1 <= i <= n) |lambda_i|$. It is especially relevant for determining if a given iterative method converges for any arbitrary initial vector $x^((0))$. Specifically, given an iteration matrix $T$, it can be said that the iterative method is convergent when $rho(T) < 1$. 

  ===== Strictly Diagonally Dominant Matrix (SDD)
  A square matrix is strictly diagonally dominant (SDD) when the magnitude of the diagonal entry in each row is greater than the sum of the magnitude of the non-diagonal entries on the same row.

  $ |a_(i i)| > sum_(j=1, j != i)^n |a_(i j)|, quad "for" i = 1, 2, ..., n $

  *Note:* When a matrix $A$ is SDD, then it is guaranteed to be non-singular and that the associated iteration matrices are convergent (i.e., $rho(T) < 1$).
]

==== List of Iterative Methods
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Jacobi Method
    #line(length: 100%)

    *Algorithm:* \
    In essence, the Jacobi method solves for new x-values, then uses the x-value gained from the previous iteration to solve the x-values of the next iteration.

    *Requirements:* \
    (i) Square Matrix, (ii) Linear, (iii) Non-Zero Diagonal Entries, (iv) Ideally SDD to Ensure Convergence

    *Matrix Form (A = D+L+U):* \
    $ x^((k)) = -D^(-1)(L + U)x^(k-1) + D^(-1)b $
    $ T_J = -D^(-1)(L + U), " " c_J = D^(-1)b $

    *Component Form:* \
    $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1, j != i)^n a_(i j) x_j^(k-1) ) $
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    ===== Gauss-Seidel Method
    #line(length: 100%)

    *Algorithm:* \
    In essence, the Gauss-Seidel method solves for new x-values, then immediately uses the new x-value to solve for the succeeding x-value.

    *Requirements:* \
    (i) Square Matrix, (ii) Linear, (iii) Non-Zero Diagonal Entries, (iv) Ideally SDD to Ensure Convergence
    
    *Matrix Form (A = D+L+U):* \
    $ x^((k)) = -(D + L)^(-1) U x^(k-1) + (D + L)^(-1) b $
    $ T_"GS" = -(D + L)^(-1) U, " " c_"GS" = (D + L)^(-1) b $

    *Component Form:* \
    $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1)^(i-1) a_(i j) x_j^(k) - sum_(j=i+1)^n a_(i j) x_j^(k-1) ) $
  ]
]

=== [W3] NLA: Overrelaxation, Iterative Refinement

==== Successive Over-Relaxation (SOR)
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Algorithm:* \
    The successive relaxation method (or the SOR method, for short) produces a new estimate for an x-value by calculating the weighted average of the previous x-value and the Gauss-Seidel estimate.
    
    *Requirements:* \
    (i) Square Matrix, (ii) Linear, (iii) Ideally SDD as well to ensure convergence, (iv) Ideally Tridiagonal, (v) Valid Relaxation Factor $omega$
      - For the relaxation factor $omega$ to be valid, it must fall in the interval $0<omega<2$.
        - If $0<omega<1$, then the new estimate is found between the previous estimate and the Gauss-Seidel estimate. Thus, the algorithm is called "under-relaxation".
        - If $omega=1$, then the method for finding the new estimate simply becomes the Gauss-Seidel method.
        - If $1<omega<2$, then the new estimate is found beyond the Gauss-Seidel estimate. This algorithm is called "over-relaxation."
        
    *Matrix-Form (A = D+L+U):* \
    $ x^((k)) = (D-omega L)^(-1)[(1-omega)D+omega U]x^((k -1))+omega(D-omega L)^(-1)b $
    $ T_omega = (D-omega L)^(-1)[(1-omega)D+omega U], c_omega = omega(D-omega L)^(-1) $
    
    *Component Form:* \
    $ x_i^((k))=(1-omega)x_i^((k-1))+omega/a_(i i)[b_i - sum_(j=1)^(i-1)a_(i j)x_j^((k)) - sum_(j=i+1)^n a_(i j)x_j^((k-1))] $
  ]
]

==== Theorems Relevant to Iterative Methods
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Theorem 1:* For any $x^((0)) in RR$, the sequence ${x^((k))}^infinity_(k=0)$ defined by $x^((k))=T x^((k-1))+c$, for each $k>=1$, converges to the unique solution of $x = T x+c$ if and only if $rho(T) < 1$.
    #v(10pt)
    *Proof:* First, we show that if $rho(T)<1$, then the sequence as described converges to the unique solution $x = T x+c$.\ 
    #v(5pt)
    Assume that $rho(T)<1$. Then, it follows that\
    $x^((k))=T x^((k-1)) + c$\
    #h(20pt) $=T(T x^((k-2))+c)+c$\
    #h(20pt) $=T^2x^((k-2))+(T + I)c$\
    #h(20pt) $dots.v$\
    #h(20pt) $=T^k x^((0))+(T^(k-1) + dots + T + I)c$\
    #v(5pt)
    Since $rho(T)<1$, T is therefore convergent, and $lim_(k->infinity) T^k x^((0))=0$. Additionally, there exists $(I-T)^(-1)$ such that $(I-T)^(-1)=I+T+T^2+dots+sum_(j=0)^(n)T^j$.\
    Thus, $lim_(k->infinity)x^((k))=lim_(k->infinity) T^k x^((0))+(sum_(j=0)^(n)T^j)c=(I-T)^(-1)c$.\
    Multiplying both sides by $(I-T)$, we get $x(I-T)=c$. Distributing $x$ yields the equation $x-T x=c$, or $x=T x +c$ Thus, the sequence converges to the vector $x=T x+c$.\
    #v(5pt)
    Next, we show that if the sequence converges to the unique solution $x = T x+c$, then $rho(T) < 1$.
    #v(5pt)
    Let $z in RR^n$ be an arbitrary vector, and $x$ be the unique solution to $x=T x+c$. We define $x^((0))=x-z$, and, for $k >= 1$, $x^((k))=T x^((k-1))+c$. Then, ${x^((k))}$ converges to $x$. Note that \
    $x-x^((k))=(T x+c)-(T x^((k-1))+c)$\
    #h(40pt) $=T(x-x^((k-1)))$\
    #h(40pt) $=T^2(x-x^((k-2)))$\
    #h(40pt) $dots.v$\
    #h(40pt) $=T^k (x-x^((0)))$\
    #h(40pt) $=T^k z$\
    #v(5pt)
    Thus, $lim_(k->infinity) T^k z=lim_(k->infinity) T^k (x-x^((0)))=lim_(k->infinity)(x-x^((k)))=0$.\ 
    Since $z in RR^n$ is arbitrary, it follows that T is convergent, and that $rho(T)<1$.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Theorem 2:* If a matrix $A$ is SDD, then for any choice $x^((0))$, both the Jacobi and the Gauss-Seidel methods give sequences ${x^((k))}^infinity_(k=0)$ that converge to the unique solution of $A x=b$.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Theorem 3 (Stein-Rosenberg Theorem):* If $a_(i j) <= 0$, for each $i != j$ and $a_(i i) > 0$, for each $i=1,2,3,dots, n$, then one and only one of the following statements hold:\
    #v(5pt)
    1) $0<=rho(T_(G S))<=rho(T_J)<1$\
    2) $1<rho(T_J)<rho(T_(G S))$\
    3) $rho(T_J)=rho(T_(G S))=0$\
    4) $rho(T_J)=rho(T_(G S))=1$
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Theorem 4 (Kahan's Theorem):* If $a_(i i) != 0$, for each $i=1,2,3,dots, n$, then $rho(T_omega)>=abs(omega - 1)$. This implies that the SOR method only converges when $0<omega<2$.
    
    #v(10pt)
    *Proof:* The iteration matrix for SOR is given by $T_omega=(D-omega L)^(-1)[(1-omega)D+omega U]$. Getting the determinant of $T_omega$, we get $det(T_w)=det((D-omega L)^(-1))dot det((1-omega)D+omega U)$. Since $D-omega L$ is simply a lower triangular matrix, $det(D-omega L)$ is the product of its diagonal entries, giving us $product_(i=1)^(n) a_(i i)$. Thus, $det((D-omega L)^(-1))=1/(product_(i=1)^(n) a_(i i))$.\
    
    Since $(1-omega)D+omega U$ is an upper triangular matrix, $det((1-omega)D+omega U)$ is the product of its diagonal entries as well, giving us $det((1-omega)D+omega U)=$\
    $product_(i=1)^(n) (1-omega)a_(i i)=(1-omega)^n product_(i=1)^(n) a_(i i)$. Combining these two terms, we get $det(T_omega)=$\
    
    $1/(product_(i=1)^(n) a_(i i))dot (1-omega)^n product_(i=1)^(n) a_(i i)=(1-omega)^n$. Since the determinant for a square matrix is the product of its eigenvalues, we have $det(T_w)=product_(i=1)^n lambda_i = (1-omega)^n$. Taking \
    
    their absolute values, we get $product_(i=1)^n abs(lambda_i)=abs(1-omega)^n=abs(omega-1)^n$. We then take the geometric mean of the product of its eigenvalues, $product_(i=1)^n abs(lambda_i)^(1/n)$, and compare it to the spectral radius of $T_omega$. Since the spectral radius of a given square matrix is equal to its largest possible eigenvalue, it is greater than or equal to the geometric mean of the product of all of its eigenvalues. Thus, we have $product_(i=1)^n abs(lambda_i)^(1/n)<=rho(T_omega)$, or \
    
    $product_(i=1)^n abs(lambda_i)<=rho(T_omega)^n$. We substitute  $product_(i=1)^n abs(lambda_i)=abs(omega-1)^n$ for the left hand side and take their $n^(t h)$ root, giving us $rho(T_w)>=abs(omega-1)$. Since $rho(T_omega)<1$ for the SOR method to converge, we have the inequality $abs(omega-1)<=rho(T_omega)<1$. We then solve the absolute inequality $abs(omega-1)$, which yields $-1<omega-1<1$, or $0<omega<2$.\
    
    Thus, for the SOR method to converge, $0<omega<2$.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Theorem 5 (Ostrowski-Reich Theorem):* If a matrix $A$ is positive definite and $0<omega<2$, then the SOR method converges for any choice of initial approximate vector $x^((0))$.
  ]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    *Theorem 6:* If a matrix $A$ is positive definite and tridiagonal, then $rho(T_(G S))=[rho(T_J)]^2<1$, and the optimal choice for $omega$ for the SOR method is given by \
    #v(2pt)
    $omega=(2)/(1+sqrt(1-[rho(T_J)]^2))$. With this $omega$, we have $rho(T_omega) = omega - 1$.
  ]
]

==== What is Iterative Refinement?
#pad(left: 2em)[
  ===== Definition
  *Iterative refinement* is a method for improving the quality of an approximate solution _$hat(x)$_ to a linear system of equations $A x = b$ where $A$ is a nonsingular $n times n$ nonsingular matrix. #sub[(Higham, 2023)]

  It is also called as _iterative improvement_ and consists of performing iterations on the system whose right-hand side is the _residual vector_ for successive operations until satisfactory accuracy results. #sub[(Burden & Faires, 2010)]
]

==== Concepts to Recall
#pad(left: 2em)[
  ===== LU Decomposition
  Recall that *LU Decomposition*, also known as _LU Factorization_, solves the linear system $A x = b$ by splitting the coefficient matrix $A$ into a lower triangular matrix $L$ and an upper triangular matrix $U$ and using _forward and backward substitution_ to obtain the solution vector $x$. 
  
  ===== Residual
  The *residual vector* of an approximate solution _$hat(x)$_ is defined as
  $r = b - A hat(x) $ and measures how well _$hat(x)$_ satisfies the original system. Note that $r = 0$ if and only if _$hat(x)$_ is the exact solution. #sub[(Higham, 2023)]

  This is distinct from the *error*, $e = x - hat(x)$, which cannot be computed directly since $x$ is unknown but the residual _can_ be computed directly from $A$, $b$, and _$hat(x)$_, which is exactly why refinement uses it, not the error, as the right-hand side of each correction step. #sub[(Burden & Faires, 2010)]
  
  ===== Norms
  To quantify the "size" of a vector's error or residual, a *vector norm* $parallel dot parallel$ is used, most commonly the $ell_2$ _Euclidean norm_ or the $ell_infinity$ _max norm_, depending on the application.

  In the context of refinement, norms are what give the method a concrete and checkable stopping criterion. The iteration continues until the norm of the residual falls below some chosen tolerance, at which point _$hat(x)$_ is accepted as sufficiently accurate. #sub[(Heath, 2018)]
  
  ===== Conditioning
  The *condition number* of a nonsingular matrix $A$, denoted $kappa(A) = parallel A parallel dot parallel A^(-1) parallel$, measures how sensitive the solution of $A x = b$ is to small perturbations in the input data $A$ or $b$, with a large $kappa(A)$ meaning $A$ is *ill-conditioned*.

  Conditioning matters directly for refinement because a small residual $parallel r parallel$ does not guarantee a small error $parallel x - hat(x) parallel$ when $A$ is ill-conditioned since the two are related by roughly $(parallel x - hat(x) parallel) / (parallel x parallel) <= kappa(A) dot (parallel r parallel) / (parallel b parallel)$ which is the central motivation for refinement.
]

==== Motivation
#pad(left: 2em)[
  ===== Sources of Error
  Even a numerically stable method like Gaussian elimination does not produce an exact solution in floating point arithmetic since the rounding error accumulated during the elimination and substitution steps means the computed _$hat(x)$_ differs from the true $x$. #sub[(Burden & Faires, 2010)]
  
  ===== Refine not Resolve
  One option upon detecting a large residual is to solve $A x = b$ again from scratch, using more careful arithmetic but this costs a full $O(n^3)$ re-elimination. #sub[(Higham, 2023)]

  Since the $L U$ factorization of $A$ was already computed while finding _$hat(x)$_, it can be reused: solving the correction system $A z = r$ for $z$ via forward and backward substitution costs only $O(n^2)$, making refinement far cheaper than re-solving. #sub[(Burden & Faires, 2010)]

  This is why iterative refinement is preferred in practice because it improves accuracy at a fraction of the cost of computing a fresh solution. #sub[(Higham, 2023)]
]

==== Procedure
#pad(left: 2em)[
  Suppose the problem is to solve $A x = b$ for $x$. Using any previously discussed matrix method $M$, we obtain $A x = b limits(->)^M hat(x) approx x$, along with the residual $r = b - A hat(x)$ as a byproduct of $M$.

  We then solve $A delta = r$, i.e. $delta = A^(-1) r$, where $delta$ is the _ideal_ refinement for _$hat(x)$_ as can be verified by substitution:
  $ A(hat(x) + delta) = A hat(x) + A delta = A hat(x) + r = A hat(x) + b - A hat(x) = b $

  showing that _$hat(x) + delta$_ would recover $b$ exactly, if $delta$ could be found exactly.

  However, since the correction system $A delta = r$ is itself solved using the same method $M$, we don't actually obtain $delta$ exactly, we only obtain an approximation $hat(delta) approx delta$, which brings us only closer to $b$. We therefore update _$hat(x)$_ as
  $ hat(x) <- hat(x) + hat(delta) $
  and repeat the process until $Delta hat(x) = parallel hat(delta) parallel < "tol"$.

  This is the essence of iterative refinement: whatever accuracy is lost to the matrix method $M$ used initially has to be recovered gradually, through succeeding refinements, rather than all at once.

  *Remark.* LU factorization is especially desirable for this process because the refinement equation $A delta = r$ has a constant $A$ and a variable $r$, so $A = L U$ only needs to be computed once, and each subsequent correction $delta_i$ for a new residual $r_i$ requires only forward and backward substitution, avoiding repeated, expensive elementary row operations.
]

==== Algorithms for Iterative Refinement
#pad(left: 2em)[
  ===== Fixed-Precision Iterative Refinement
  This is the standard version of the procedure from Section 2.4, written out as an algorithm. It assumes $hat(x)$ was obtained by solving $A x = b$ via $L U$ (or $P A = L U$) factorization in the first place, so the *same* factors are reused for every correction — no re-factorization of $A$ is ever needed.

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
    *Algorithm: Iterative Refinement (Reusing an Existing LU Factorization)*
    #line(length: 100%)

    *Input:* $A$, $b$, precomputed factorization $P A = L U$, initial approximate solution $hat(x)$, tolerance $epsilon$, maximum refinement steps $N$.

    + Set $k <- 0$.
    + *Repeat:*
      + Compute the residual: $r <- b - A hat(x)$
      + Solve $L y = P r$ #h(1fr) (forward substitution, reuses existing $L$)
      + Solve $U delta = y$ #h(1fr) (back substitution, reuses existing $U$)
      + Update: $hat(x) <- hat(x) + delta$
      + *If* $||delta|| \/ ||hat(x)|| < epsilon$: stop, return $hat(x)$
      + $k <- k+1$
    + *Until* $k = N$: report failure to converge in $N$ steps.

    *Output:* refined approximate solution $hat(x)$, or a failure flag.
  ]

  *Note:* every step after the initial factorization costs only $O(n^2)$ (one residual, one forward solve, one back solve) — compare to the $O(n^3)$ cost of the original factorization. This is the entire reason refinement is worth doing (Section 2.3.2).

  ===== Mixed-Precision (Extended-Precision) Iterative Refinement
  A common refinement of the algorithm itself: compute the residual $r = b - A hat(x)$ in *higher precision* than the rest of the computation (e.g. double precision even if $A$, $b$, and the $L U$ factors are stored in single precision), then round $r$ back down before solving $L y = P r$ and $U delta = y$ as usual.

  *Why this matters:* once $hat(x)$ is already close to $x$, the subtraction $b - A hat(x)$ is a subtraction of two nearly-equal quantities — exactly the setup for catastrophic cancellation. If $r$ is computed at the *same* limited precision as everything else, this cancellation can wipe out the very information the next correction needs, and refinement stalls after one or two steps. Computing $r$ in extended precision avoids this and lets refinement continue improving $hat(x)$ closer to the limit set by $kappa(A)$ (Section 2.2.4).

  *Note:* only the residual computation needs the extra precision — the triangular solves for $delta$ can stay in the original (cheaper) precision, so this costs little extra.
]

==== When Refinement Helps, and When It Doesn't
#pad(left: 2em)[
  ===== Mechanism
  Each refinement step does not magically erase error — it is governed by the same residual/conditioning relationship as any other approximate solve (Section 2.2.4):
  $ (||hat(x) - x||)/(||x||) <= kappa(A) (||r||)/(||b||) $
  Because the correction $delta$ is only as good as $A$'s reused $L U$ factors allow, refinement does not recover the *exact* solution in one step — but each pass typically shrinks the residual (and, correspondingly, tightens the bound on forward error) by roughly the same relative factor, giving geometrically decreasing error much like the stationary methods of Section 1.3, until the limit imposed by $kappa(A)$ is reached.

  ===== Limitation: Refinement is Not a Cure for Ill-Conditioning
  If $kappa(A)$ is large, the inequality above still holds at *every* refinement step. Even if $r$ is driven down to the smallest value floating-point arithmetic allows, the forward error is still bounded below by roughly $kappa(A)$ times that. Refinement can only recover accuracy that was lost to the *algorithm's* rounding — it cannot recover accuracy lost to the *problem's* own sensitivity. For a severely ill-conditioned $A$, refinement may show little improvement or stagnate after the first correction.
]

==== Worked Example
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
    *One Step of Iterative Refinement*
    #line(length: 100%)

    Solve $A x = b$ where
    $ A = mat(3,2;4,3), quad b = mat(7;10) $
    The exact solution is $x = (1,2)$, but suppose a prior (limited-precision) solve produced
    $ hat(x) = mat(1.05; 1.90) $

    *Residual:*
    $ r = b - A hat(x) = mat(7;10) - mat(3(1.05)+2(1.90);4(1.05)+3(1.90)) = mat(7-6.95;10-9.90) = mat(0.05;0.10) $

    *Correction equation* $A delta = r$:
    $ mat(3,2;4,3) delta = mat(0.05;0.10) quad ==> quad delta = mat(-0.05;0.10) $

    *Update:*
    $ hat(x)_"new" = hat(x) + delta = mat(1.05-0.05;1.90+0.10) = mat(1.00;2.00) $
    which matches the exact solution — so the new residual is $r_"new" = mat(0;0)$ and no further refinement is needed. In genuine floating-point practice, the correction equation is itself only solved *approximately*, so a single step rarely zeroes out the residual exactly; this example uses exact arithmetic to keep each quantity (residual, correction, update) easy to follow by hand.
  ]
]

==== Iterative Refinement vs. Iterative Solvers
#pad(left: 2em)[
  It is easy to mistake iterative refinement for "Jacobi/Gauss-Seidel applied to the residual." They are related (both reduce error over repeated passes) but are structurally different methods.

  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + luma(150),
    fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { white },
    align: left,
    table.header([*Property*], [*Iterative Solver* (Jacobi / GS / SOR)], [*Iterative Refinement*]),
    [Starting point], [Arbitrary guess $x^((0))$, often $0$], [An already-computed, usually fairly accurate $hat(x)$],
    [Solves], [$A x = b$ itself, from scratch each pass], [The correction equation $A delta = r$],
    [Needs a factorization?], [No — never forms or reuses $L U$], [Yes — reuse is the entire point (Section 2.5.1)],
    [Typical origin], [Standalone method, esp. for large sparse systems], [Post-processing step after a direct solve],
  )
]

== [W4] Real Eigenvalue Approximations of a Square Matrix
#align(right)[_*1.2. Eigenvalue Approximations of a Square Matrix*_]
==== Motivation
Recall that the convergence of iterative methods discussed in Section 1.2 rely on the spectral radius of matrices being less than 1.

Recall further that the spectral radius of a matrix is defined as the magnitude of the largest eigenvalue of that matrix.

For these reasons it is a problem that there is no general formula for computing the eigenvalues for $n$x$n$ matrices when $n>= 5$.

And for these same reasons methods exist for finding/approximating eigenvalues and eigenvectors
=== [W4] Eigenvalue Approximations: Power Method, Gershgorin Circle Theorem
==== Power Method:
Let us say we have an $n$x$n$ matrix $A$ with eigenvalues $lambda_1, lambda_2,..., lambda_n$. And let us assume that they are numbered in order of magnitude:

$|lambda_1|>= |lambda_2|>=...>= |lambda_n|$

Any vector, $x$, can be formed using only a linear combination of its eigenvectors. #cite(<ruaya2026eigen>)

$A x = lambda x$

$A x = c_1 lambda_1 v_1+ c_2 lambda_2 v_2 + ... + c_n lambda_n v_n$

Should we decide to repeatedly multiply both sides by $A$ until we reach $A^k$ we should find that

$A [A x] = lambda[c_1 lambda_1 v_1+ c_2 lambda_2 v_2 + ... + c_n lambda_n v_n]$

$A^2 x = c_1 lambda_1^2 v_1+ c_2 lambda_2^2 v_2 + ... + c_n lambda_n^2 v_n$

...

$A^k x = c_1 lambda_1^k v_1+ c_2 lambda_2^k v_2 + ... + c_n lambda_n^k v_n$

$A^k x = lambda_1^k (c_1  v_1+ c_2 (lambda_2 / lambda_1)^k v_2 + ... + c_n (lambda_n / lambda_1)^k v_n)$

If we assume that $|lambda_1|> |lambda_2|$ (STRICTLY GREATER THAN) then as $k → infinity, (lambda_i/lambda_1)^k → 0, forall i, 2<=i<=n$. This leaves us with

$A^k x = c_1 lambda_1^k v_1 $

Which means $A^k x$ approaches some multiple of the dominant eigenvector, $v_1$, as $k→infinity$. #cite(<tudelft>)

With this our iteration is as follows:

$x^(\(k+1\)) = A x^(\(k\)) = lambda_1 x^(\(k\))$

To solve for $lambda_1$ we can multiply $x^(\(k\)T)$ to both sides to get:

$x^(\(k\)T)x^(\(k+1\))= lambda_1 x^(\(k\)T)x^(\(k\)) $

$lambda_1 = (x^(\(k\)T)x^(\(k+1\)))/(x^(\(k\)T)x^(\(k\))) = (x^(\(k\)T)A x^(\(k\)))/(x^(\(k\)T)x^(\(k\)))$

Thus, we have found an approximation for $lambda_1$. Coincidentally, this formula follows the Rayleigh Quotient, which will be discussed somewhat, further in this section. cite pages

=== [W4] Eigenvalue Approximations: Gram-Schmidt, QR Factorization and Iteration

== [W5] Least Squares Approximation, Rayleigh Quotient
#align(right)[_*1.3. Least Squares (optional)*_]
=== [Arc 1] Async; Bonus Reading: Unconstrained Optimization: Objective Functions, Newton's Method, Linear Le...
=== [Arc 1] Async; Bonus Reading: Constrained Optimization: Lagrange Multipliers, KKT Conditions

== Cheatsheet


=== Symbols Reference

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


=== Linear Systems/Sensitivity Analysis
- *System Form:* $A x = b$
- *Column Sum Norm ($1$-norm):*
  $ ||A||_1 = max_(1 <= j <= n) sum_(i=1)^n |a_(i j)| $
- *Row Sum Norm ($oo$-norm):*
  $ ||A||_oo = max_(1 <= i <= n) sum_(j=1)^n |a_(i j)| $

#text(weight: "bold")[Residual & Sensitivity Bounds]
#line(length: 100%, stroke: 0.5pt + luma(200))
- *Residual Vector:* $r = b - A hat(x)$
- *Relative Error Bound:*
  $ (||x - hat(x)||) / (||x||) <= kappa(A) (||r||) / (||A|| ||hat(x)||) $
- *Trustworthy Decimals ($d$):*
  $ d = |log_10 (epsilon_m)| - log_10 (kappa(A)) $

=== Direct Matrix Decompositions

==== Matrix Splitting
$ A = D + L + U $
where $D$ is diagonal, $L$ is strictly lower triangular, and $U$ is strictly upper triangular.

==== LU Factorization ($A = L U$)
Transforms a non-singular matrix into lower ($L$) and upper ($U$) triangular factors.

- *Doolittle Factorization* (Diagonal $l_(i i) = 1$):
  $ u_(k j) &= a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j), quad &j = k, dots, n \
    l_(i k) &= 1 / u_(k k) (a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k)), quad &i = k+1, dots, n $

- *Crout Factorization* (Diagonal $u_(i i) = 1$):
  $ l_(i k) &= a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k), quad &i = k, dots, n \
    u_(k j) &= 1 / l_(k k) (a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j)), quad &j = k+1, dots, n $

==== Cholesky Factorization ($A = L L^T$)
Applicable ONLY to Symmetric Positive Definite (SPD) matrices ($A^T = A$ and $x^T A x > 0, forall x != 0$).

- *Quadratic Form:*
  $ q(x) = x^T A x = sum_(i=1)^n a_(i i) x_i^2 + 2 sum_(i > j) a_(i j) x_i x_j > 0 $

- *Diagonal Factor Entries ($i = j$):*
  $ l_(j j) = sqrt(a_(j j) - sum_(k=1)^(j-1) l_(j k)^2) $

- *Off-Diagonal Factor Entries ($i > j$):*
  $ l_(i j) = 1 / l_(j j) (a_(i j) - sum_(k=1)^(j-1) l_(i k) l_(j k)) $

=== Iterative Methods
#line(length: 100%, stroke: 0.5pt + luma(200))

==== Jacobi Method ($A = D + L + U$)
- *Matrix Form:*
  $ x^((k)) = -D^(-1)(L + U)x^((k-1)) + D^(-1)b $
  $ T_J = -D^(-1)(L + U), quad c_J = D^(-1)b $
- *Component Form:*
  $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1, j != i)^n a_(i j) x_j^((k-1)) ) $

==== Gauss-Seidel Method ($A = D + L + U$)
- *Matrix Form:*
  $ x^((k)) = -(D + L)^(-1) U x^((k-1)) + (D + L)^(-1) b $
  $ T_"GS" = -(D + L)^(-1) U, quad c_"GS" = (D + L)^(-1) b $
- *Component Form:*
  $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1)^(i-1) a_(i j) x_j^((k)) - sum_(j=i+1)^n a_(i j) x_j^((k-1)) ) $

==== SOR Method ($A = D + L + U$)
- *Matrix Form:*
  $ x^((k)) = (D - omega L)^(-1) [(1 - omega)D + omega U] x^((k-1)) + omega (D - omega L)^(-1) b $
  $ T_omega = (D - omega L)^(-1) [(1 - omega)D + omega U], quad c_omega = omega (D - omega L)^(-1) b $
- *Component Form:*
  $ x_i^((k)) = (1 - omega)x_i^((k-1)) + omega / a_(i i) [b_i - sum_(j=1)^(i-1) a_(i j) x_j^((k)) - sum_(j=i+1)^n a_(i j) x_j^((k-1))] $

=== Iterative Refinement
#line(length: 100%, stroke: 0.5pt + luma(200))

- *Residual Vector:*
  $ r = b - A hat(x) $

- *Error Vector:*
  $ e = x - hat(x) $

- *Condition Number:*
  $ kappa(A) = ||A|| dot ||A^(-1)|| $
  
== Contribution of Each Student

#align(center)[
  #block(width: 100%)[
    #table(
      columns: (1fr, auto),
      align: (col, row) => if col == 1 { center } else { left },
      stroke: none,
      
      table.header(
        [*Parts of notes*], [*Contributors*]
      ),
      
      [*1.0. [W0] Introduction of Linear Systems*], [#align(left)[]],
      
      
      [#h(2em) [W0] NLA: Introduction of Linear Systems], [#align(left)[]],
      
      [*1.1. [W1-2] Direct Methods for solving SLEs* \ #text(fill: luma(100), style: "italic")[1.1a. System of Linear Algebraic Equations 1: Introduction, Direct Methods]], [#align(left)[]],
      
      [#h(2em) [W1] NLA: Gaussian Elimination, Pivoting], [#align(left)[*Alcancia*]],
      
      [#h(2em) [W1] NLA: LU Decomposition], [#align(left)[*Mendoza*]],
      
      [#h(2em) [W2] NLA: Positive Definite Matrices, Cholesky Factorization], [#align(left)[*Bialen \ Carandang*]],
      
      [*1.2. [W3] Iterative Methods for solving SLEs, Iterative Refinement* \ #text(fill: luma(100), style: "italic")[1.1b. System of Linear Algebraic Equations 2: Iterative Methods]], [#align(left)[]],
      
      [#h(2em) [W2] NLA: Iterative Methods, Jacobi and Gauss-Seidel Method], [#align(left)[*Buenaventura \ Pagaduan*]],
      
      [#h(2em) [W3] NLA: Overrelaxation, Iterative Refinement], [#align(left)[*Aguilar \ Camacho \ Pagaduan*]],
      
      [*1.3. [W4] Real Eigenvalue Approximations of a Square Matrix* \ #text(fill: luma(100), style: "italic")[1.2. Eigenvalue Approximations of a Square Matrix]], [#align(left)[]],
      
      [#h(2em) [W3] Eigenvalue Approximations: Power Method, Gershgorin Circle Theorem], [#align(left)[*Baratang \ Cruz*]],
      
      [#h(2em) [W4] Eigenvalue Approximations: Gram-Schmidt, QR Factorization and Iteration], [#align(left)[*Contributor*]],
      
      [*1.4. [W5] Least Squares Approximation, Rayleigh Quotient* \ #text(fill: luma(100), style: "italic")[1.3. Least Squares (optional)]], [#align(left)[]]
    )
  ]
]


#bibliography("resources/bibs/class_notes/le1/Group_1_WFW.bib", style: "apa", full: true)
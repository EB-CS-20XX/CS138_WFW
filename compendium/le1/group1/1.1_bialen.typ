#import "../../../template.typ": project

#show: project.with(
  title: "LU Decomposition: Solved Problems",
  contributor: "Bialen",
  date: "September 23 2026",
)

#show bibliography: set heading(numbering: none)
#set math.mat(delim: "[")

#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)

== (Bialen)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Compendium Problem 1: Cholesky Factorization (Remixed)*
  #line(length: 100%)
  *Reference:* _Scientific Computing: An Introductory Survey_ (2nd ed.), Michael T. Heath
  #cite(<heath2002>)

  *Problem Statement:* \
  Determine the Cholesky factorization $A = L L^T$ for the symmetric positive definite matrix:
  $ A = mat(9, 6; 6, 5) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  Let the lower triangular factor be:
  $ L = mat(l_(11), 0; l_(21), l_(22)) $

  *Column 1 ($j = 1$):*
  - First diagonal entry ($i = 1$):
    $ l_(11) = sqrt(a_(11)) = sqrt(9) = 3 $
  - Subdiagonal entry ($i = 2$):
    $ l_(21) = a_(21) / l_(11) = 6 / 3 = 2 $

  *Column 2 ($j = 2$):*
  - Second diagonal entry ($i = 2$):
    $ l_(22) = sqrt(a_(22) - l_(21)^2) = sqrt(5 - (2)^2) = sqrt(5 - 4) = 1 $

  *Final Factors:*
  #align(center)[
    #rect(inset: 10pt, radius: 4pt, stroke: 1pt + black)[
      $ L = mat(3, 0; 2, 1), quad L^T = mat(3, 2; 0, 1) $
    ]
  ]

  *Verification:*
  $ L L^T = mat(3, 0; 2, 1) mat(3, 2; 0, 1) = mat(9 + 0, 6 + 0; 6 + 0, 4 + 1) = mat(9, 6; 6, 5) = A $
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Compendium Problem 2: Doolittle LU Factorization and Dual System Solution (Remixed)*
  #line(length: 100%)
  *Reference:* _Scientific Computing: An Introductory Survey_ (2nd ed.), Michael T. Heath
  #cite(<heath2002>)

  *Problem Statement:* \
  Given the coefficient matrix
  $ A = mat(3, 1, -2; 6, 4, -3; -3, 3, 7) $
  + Compute the Doolittle LU decomposition ($A = L U$, where $l_(i i) = 1$) and use it to solve $A x = b$ for $b = mat(7; 17; -4)$.
  + Without re-factorizing $A$, use the existing triangular factors to solve $A y = c$ for $c = mat(3; 5; -2)$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *Step 1: Compute LU Decomposition ($A = L U$)*
  - Diagonal elements of $L$ and first row of $U$:
    $ l_(11) = l_(22) = l_(33) = 1 $
    $ u_(11) = a_(11) = 3, quad u_(12) = a_(12) = 1, quad u_(13) = a_(13) = -2 $

  - First column multipliers of $L$:
    $ l_(21) = a_(21) / u_(11) = 6 / 3 = 2 $
    $ l_(31) = a_(31) / u_(11) = (-3) / 3 = -1 $

  - Second row of $U$:
    $ u_(22) = a_(22) - l_(21) u_(12) = 4 - (2)(1) = 2 $
    $ u_(23) = a_(23) - l_(21) u_(13) = -3 - (2)(-2) = 1 $

  - Second column multiplier of $L$:
    $ l_(32) = (a_(32) - l_(31) u_(12)) / u_(22) = (3 - (-1)(1)) / 2 = 4 / 2 = 2 $

  - Third row of $U$:
    $ u_(33) = a_(33) - (l_(31) u_(13) + l_(32) u_(23)) = 7 - ((-1)(-2) + (2)(1)) = 7 - 4 = 3 $

  *Triangular Factors:*
  $ L = mat(1, 0, 0; 2, 1, 0; -1, 2, 1), quad U = mat(3, 1, -2; 0, 2, 1; 0, 0, 3) $

  *Step 2: Solve $A x = b$ Using Forward and Backward Substitution*
  - Forward substitution ($L y' = b$):
    $ y'_1 = 7 $
    $ 2 y'_1 + y'_2 = 17 ==> y'_2 = 17 - 2(7) = 3 $
    $ -y'_1 + 2 y'_2 + y'_3 = -4 ==> y'_3 = -4 - (-7 + 6) = -3 $
    $ y' = mat(7; 3; -3) $

  - Backward substitution ($U x = y'$):
    $ 3 x_3 = -3 ==> x_3 = -1 $
    $ 2 x_2 + (1)(-1) = 3 ==> 2 x_2 = 4 ==> x_2 = 2 $
    $ 3 x_1 + (1)(2) - 2(-1) = 7 ==> 3 x_1 + 4 = 7 ==> x_1 = 1 $

  #align(center)[
    #rect(inset: 10pt, radius: 4pt, stroke: 1pt + black)[
      $ x = mat(1; 2; -1) $
    ]
  ]

  *Step 3: Solve $A y = c$ Without Refactoring*
  - Forward substitution ($L z = c$):
    $ z_1 = 3 $
    $ 2 z_1 + z_2 = 5 ==> z_2 = 5 - 2(3) = -1 $
    $ -z_1 + 2 z_2 + z_3 = -2 ==> z_3 = -2 - (-3 - 2) = 3 $
    $ z = mat(3; -1; 3) $

  - Backward substitution ($U y = z$):
    $ 3 y_3 = 3 ==> y_3 = 1 $
    $ 2 y_2 + (1)(1) = -1 ==> 2 y_2 = -2 ==> y_2 = -1 $
    $ 3 y_1 + (1)(-1) - 2(1) = 3 ==> 3 y_1 - 3 = 3 ==> y_1 = 2 $

  #align(center)[
    #rect(inset: 10pt, radius: 4pt, stroke: 1pt + black)[
      $ y = mat(2; -1; 1) $
    ]
  ]
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Compendium Problem 3: From Cholesky to Doolittle LU (Original Remix)*
  #line(length: 100%)
  *Reference:* Original problem conceptually bridging _Scientific Computing: An Introductory Survey_ (2nd ed.) Exercises 2.77 and 2.2.
  #cite(<heath2002>)

  *Problem Statement:* \
  Let the following matrix be symmetric positive definite:
  $ A = mat(1, 2, 1; 2, 8, 0; 1, 0, 11) $
  + Compute the Cholesky factorization $A = L L^T$.
  + Let $D$ be the diagonal matrix containing the diagonal entries of $L$. Define $hat(L) = L D^(-1)$ and $U = D L^T$. Show that $hat(L)$ is unit lower triangular and that $A = hat(L) U$.
  + Without performing a new factorization of $A$, use the factors from (a) to solve $A x = b$ for $b = mat(4; 10; 12)$. Explain why the two triangular solves obtained from the Cholesky factorization are equivalent to solving the corresponding system using the derived Doolittle factors.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *(a) Step 1: Cholesky Factorization ($A = L L^T$)* \
  Computing the non-zero entries of $L$ column by column:
  - *Column 1:* $l_(11) = sqrt(1) = 1$, $l_(21) = 2/1 = 2$, $l_(31) = 1/1 = 1$
  - *Column 2:* $l_(22) = sqrt(8 - 2^2) = 2$, $l_(32) = (0 - (2)(1))/2 = -1$
  - *Column 3:* $l_(33) = sqrt(11 - 1^2 - (-1)^2) = sqrt(9) = 3$

  $ L = mat(1, 0, 0; 2, 2, 0; 1, -1, 3), quad L^T = mat(1, 2, 1; 0, 2, -1; 0, 0, 3) $

  *(b) Step 2: Derive the Doolittle Factors* \
  Take $D$ as the diagonal matrix of $L$:
  $ D = mat(1, 0, 0; 0, 2, 0; 0, 0, 3), quad D^(-1) = mat(1, 0, 0; 0, 1/2, 0; 0, 0, 1/3) $

  Computing $hat(L) = L D^(-1)$:
  $ hat(L) = mat(1, 0, 0; 2, 2, 0; 1, -1, 3) mat(1, 0, 0; 0, 1/2, 0; 0, 0, 1/3) = mat(1, 0, 0; 2, 1, 0; 1, -1/2, 1) $
  Notice that $hat(L)$ is strictly unit lower triangular (all main diagonal entries are exactly $1$), fulfilling the primary condition for a Doolittle factorization.

  Computing $U = D L^T$:
  $ U = mat(1, 0, 0; 0, 2, 0; 0, 0, 3) mat(1, 2, 1; 0, 2, -1; 0, 0, 3) = mat(1, 2, 1; 0, 4, -2; 0, 0, 9) $

  Multiplying them together confirms the factorization $A = hat(L) U$:
  $ hat(L) U = mat(1, 0, 0; 2, 1, 0; 1, -1/2, 1) mat(1, 2, 1; 0, 4, -2; 0, 0, 9) = mat(1, 2, 1; 2, 8, 0; 1, 0, 11) = A $

  *(c) Step 3: Solve the System and Prove Equivalence* \
  Using the Cholesky factors, we first solve $L y = b$ (forward substitution):
  $ mat(1, 0, 0; 2, 2, 0; 1, -1, 3) mat(y_1; y_2; y_3) = mat(4; 10; 12) ==> y = mat(4; 1; 3) $

  Next, we solve $L^T x = y$ (backward substitution):
  $ mat(1, 2, 1; 0, 2, -1; 0, 0, 3) mat(x_1; x_2; x_3) = mat(4; 1; 3) ==> x = mat(1; 1; 1) $

  #align(center)[
    #rect(inset: 10pt, radius: 4pt, stroke: 1pt + black)[
      $ x = mat(1; 1; 1) $
    ]
  ]

  *Equivalence Explanation:* \
  The standard Cholesky method solves the system via $L y = b$ and $L^T x = y$. \
  The Doolittle method solves the system via $hat(L) z = b$ and $U x = z$. 

  If we substitute our derived mathematical definitions ($hat(L) = L D^(-1)$ and $U = D L^T$) into the Doolittle equations, we obtain:
  $ (L D^(-1)) z = b $
  Since we know that $L y = b$, we can directly map the internal vector as $z = D y$. 

  Substituting $z$ into the upper triangular Doolittle solve yields:
  $ U x = z ==> (D L^T) x = D y $
  Factoring out the diagonal scaling matrix $D$ from both sides simplifies the equation exactly to $L^T x = y$. Thus, solving a system with Doolittle factors derived this way is mathematically identical to performing the standard Cholesky substitution, merely scaled at the intermediate step by the matrix $D$.
]

#line(length: 100%)


// ─────────────────────────────────────────────
#bibliography("../../../resources/bibs/compendium/le1/arc1.bib")

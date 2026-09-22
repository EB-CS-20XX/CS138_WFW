#import "../../template.typ": project
#show: project.with(
  title: "LU Decomposition",
  contributor: "Janelle Mendoza ",
  date: "September 23 2026",
)

#show bibliography: set heading(numbering: none)
#let small(body) = text(size: 9.5pt, body)

// ─────────────────────────────────────────────
// INTRO
// ─────────────────────────────────────────────

Consider the matrix equation *$A x = b$*

*Problem:* _Gaussian elimination_
#pad(left: 1.5em)[
  Solving $A x = b$ repeats the entire elimination for every new $b$, even with the same $A$. \
  $arrow.r$ _redundant_
]

*Attempt:* _Matrix Inverse_
#pad(left: 1.5em)[
  Solve for $A^(-1)$ once, then reuse it for any $b$:
  $ A x = b \
    A^(-1) A x = A^(-1) b \
    x = A^(-1) b $

  _Recall:_ $A^(-1)$ is similar to applying GJR on the augmented matrix \

 
  #align(center)[
  $[A | e_i]$ where $I_n = [e_1 space e_2 space dots space e_n]$
]
  $arrow.r$ _costs $n$ additional solves_
] \

*Solution: _LU decomposition_*
#pad(left: 1.5em)[
  Factor $A$ once as $bold(A = L U)$ where,

 *$A$:* original non-singular matrix \
  *$L$:* lower triangular matrix, all elements above the main diagonal are zero. \
  *$U$:* upper triangular matrix, all elements below the main diagonal are zero.

   #small[
    $ mat(a_11, a_12, dots.h, a_(1 n); a_21, a_22, dots.h, a_(2 n); dots.v, dots.v, dots.down, dots.v; a_(n 1), a_(n 2), dots.h, a_(n n))
      = mat(l_11, 0, dots.h, 0; l_21, l_22, dots.h, 0; dots.v, dots.v, dots.down, dots.v; l_(n 1), l_(n 2), dots.h, l_(n n))
        mat(u_11, u_12, dots.h, u_(1 n); 0, u_22, dots.h, u_(2 n); dots.v, dots.v, dots.down, dots.v; 0, 0, dots.h, u_(n n)) $
  ]

  Then reuse $L$ and $U$ for any $b$.

  - *Solving* $bold(A x = b)$ *using* $bold(A = L U)$*:*
#align(center)[
  $bold(L U x = b)$ \
  let $bold(y = U x)$ \
  $bold(L y = b)$
]

  - *Forward substitution:* solve the lower triangular system $L y = b$ for vector $y$.
    $ y_1 = b_1 / l_11 $
    $ y_i = 1 / l_(i i) (b_i - sum_(j=1)^(i-1) l_(i j) y_j), quad i = 2, dots, n $ 
    
  - *Backward substitution:* solve the upper triangular system $U x = y$ for solution $x$.
    $ x_n = y_n / u_(n n) $
    $ x_i = 1 / u_(i i) (y_i - sum_(j=i+1)^(n) u_(i j) x_j), quad i = n-1, n-2, dots, 1 $
]

// ─────────────────────────────────────────────
#heading(numbering: none)[Why This Works]

Recall from GE that we transform a matrix $A arrow.r U$ using EROs. \
Each ERO is a left multiplication by an elementary matrix $E$. \
If $R = E_n dots E_2 E_1$ transforms $A arrow.r U$, then:

$ E_n dots E_2 E_1 A = U \
  A = R^(-1) U = (E_1^(-1) E_2^(-1) dots E_n^(-1)) U \
  L = R^(-1) = E_1^(-1) E_2^(-1) dots E_n^(-1) quad arrow.r quad A = L U $

$L$ is lower triangular and stores the multipliers $gamma$ used in the EROs
(e.g., $R_2 arrow.l R_2 + (-gamma) R_1$) #cite(<strang2023>).

// ─────────────────────────────────────────────
#heading(numbering: none)[Formal Definition]


The non-singular matrix $A$ has an LU factorization if it can be expressed as the product
of a lower-triangular matrix $L$ and upper-triangular matrix $U$ #cite(<kiusalaas2013>):

$ bold(A = L U) $

- If such $L$ and $U$ exist, this is the LU decomposition of $A$.
- The decomposition is not unique (it depends on constraints placed)
  - *Doolittle Decomposition*: If $L$ has 1s on its diagonal
  - *Crout Decomposition:* If $U$ has 1s on its diagonal
  - *Cholesky Decomposition*: If $U = L^T$ (or $L = U^T$)


// ─────────────────────────────────────────────
#heading(numbering: none)[LU Decomposition Methods]

// ================= DOOLITTLE =================
== Doolittle Decomposition
Store each multiplier in the lower triangular portion of the coefficient matrix,
replacing the entry it eliminates

*Set $l_(i i) = 1$*

#small[
  $ mat(a_11, a_12, dots.h, a_(1 n); a_21, a_22, dots.h, a_(2 n); dots.v, dots.v, dots.down, dots.v; a_(n 1), a_(n 2), dots.h, a_(n n))
    = mat(1, 0, dots.h, 0; l_21, 1, dots.h, 0; dots.v, dots.v, dots.down, dots.v; l_(n 1), l_(n 2), dots.h, 1)
      mat(u_11, u_12, dots.h, u_(1 n); 0, u_22, dots.h, u_(2 n); dots.v, dots.v, dots.down, dots.v; 0, 0, dots.h, u_(n n)) $
]

The diagonal entries of $L$ need not be stored since $l_(i i) = 1, forall i$

$ bold([L | U]) = mat(
  u_11, u_12, u_13, dots.h, u_(1 n);
  l_21, u_22, u_23, dots.h, u_(2 n);
  l_31, l_32, u_33, dots.h, u_(3 n);
  dots.v, dots.v, dots.v, dots.down, dots.v;
  l_(n 1), l_(n 2), l_(n 3), dots.h, u_(n n)
) $

*Formula:* \
Multiplying out $L U$ *(for $bold(n = 3)$)*
 and equating it entry by entry with $A$.

#small[
  $ mat(a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33)
    = mat(
      u_11, u_12, u_13;
      l_21 u_11, l_21 u_12 + u_22, l_21 u_13 + u_23;
      l_31 u_11, l_31 u_12 + l_32 u_22, l_31 u_13 + l_32 u_23 + u_33
    ) $
] \

*Doolittle Algorithm (General Steps):*

#[
  #set enum(numbering: "i.")

  + Calculate the first row of $U$: $u_(1 j) = a_(1 j), quad forall j = 1, dots, n$.
    - Row 1 is the pivot row, so nothing is subtracted from it and it is copied
      directly from $A$.

  + Substitute 1s in the diagonal of $L$: $l_(i i) = 1, quad forall i = 1, dots, n$.

  + Calculate the elements in the first column of $L$ (except $l_11$): \
    $l_(i 1) = a_(i 1) / u_11, quad forall i = 2, dots, n$.
    - $l_(i 1)$ is the multiplier used to eliminate the first column.
    - multiplier = entry to eliminate / pivot

  + Calculate the rest of the elements, with the elements of $U$ calculated first (they
    are used for calculating the elements of $L$):

    #[
      #set list(marker: [▸])
      For $k = 2, dots, n$:
      - for $j = k, k+1, dots, n$: ($k$-th row of $U$)
        $ u_(k j) = a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j) $
      - for $i = k+1, k+2, dots, n$: ($k$-th column of $L$)
        $ l_(i k) = (a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k)) / u_(k k) $
    ]

    - *Row of $U$*: For each entry $a_(i j)$, subtract the total amount that got removed
      from it during elimination.\
      _example_: $u_22 = a_22 - l_21 u_12$ \
      #h(2em) $a_22 = l_21 u_12 + u_22$ (same as $a_22$ in the formula matrix above)

    - *Column of $L$*: Do the same subtraction and divide by the current pivot. \
      _example:_ $l_32 = (a_32 - l_31 u_12) / u_22$ \
      #h(2em) $a_32 = l_31 u_12 + l_32 u_22$ (same as $a_32$ in the formula matrix above) #cite(<lu2021>)

  + *Forward substitution*: solve $L y = b$ for $y$
    - Since $l_(i i) = 1$, there is no division.

  + *Backward substitution:* solve $U x = y$ for $x$
    - Divide by $u_(i i)$.
]


*Doolittle Worked Example: (lec slide 9/35)*

- Given:
  $ A = mat(1, 4, 1; 1, 6, -1; 2, -1, 2), quad b = mat(7; 13; 5) $
  \

- Set $A = L U$, where $L$ has a unit diagonal:
  $ L = mat(1, 0, 0; l_21, 1, 0; l_31, l_32, 1), quad
    U = mat(u_11, u_12, u_13; 0, u_22, u_23; 0, 0, u_33) $

- Using the formula matrix above, multiply out $L U$ and set it equal to $A$. Each
  entry on the left equals the matching entry of $A$
  #small[
    $ mat(
      u_11, u_12, u_13;
      l_21 u_11, l_21 u_12 + u_22, l_21 u_13 + u_23;
      l_31 u_11, l_31 u_12 + l_32 u_22, l_31 u_13 + l_32 u_23 + u_33
    ) = mat(1, 4, 1; 1, 6, -1; 2, -1, 2) $
  ]

- *Pivot* $bold(k = 1)$
  - Row 1 of $U$: no subtraction, since nothing has been eliminated yet
    $ u_11 &= a_11 = 1 \
      u_12 &= a_12 = 4 \
      u_13 &= a_13 = 1 $
  - Column 1 of $L$: divide by the pivot $u_11$
    $ l_21 &= a_21 / u_11 = 1 / 1 = 1 \
      l_31 &= a_31 / u_11 = 2 / 1 = 2 $
    $ L = mat(1, 0, 0; 1, 1, 0; 2, l_32, 1), quad
      U = mat(1, 4, 1; 0, u_22, u_23; 0, 0, u_33) $

- *Pivot* $bold(k = 2)$
  - Row 2 of $U$: subtract what was removed during elimination
    $ u_22 &= a_22 - l_21 u_12 = 6 - (1)(4) = 2 \
      u_23 &= a_23 - l_21 u_13 = -1 - (1)(1) = -2 $
  - Column 2 of $L$: divide by the pivot $u_22$
    $ l_32 &= (a_32 - l_31 u_12) / u_22 \
           &= (-1 - (2)(4)) / 2 \
           &= (-9) / 2 $
    $ L = mat(1, 0, 0; 1, 1, 0; 2, -9/2, 1), quad
      U = mat(1, 4, 1; 0, 2, -2; 0, 0, u_33) $

\
\
\
- *Pivot* $bold(k = 3)$
  - Row 3 of $U$
    $ u_33 &= a_33 - l_31 u_13 - l_32 u_23 \
           &= 2 - (2)(1) - (-9/2)(-2) \
           &= 2 - 2 - 9 \
           &= -9 $
    $ L = mat(1, 0, 0; 1, 1, 0; 2, -9/2, 1), quad
      U = mat(1, 4, 1; 0, 2, -2; 0, 0, -9) $

- Forward Substitution: $l_(i i) = 1$, so there is no division
  $ y_1 &= b_1 &&= 7 \
    y_2 &= b_2 - l_21 y_1 &&= 13 - (1)(7) = 6 \
    y_3 &= b_3 - l_31 y_1 - l_32 y_2 &&= 5 - (2)(7) - (-9/2)(6) = 5 - 14 + 27 = 18 $
  $ y = mat(7; 6; 18) $

- Backward Substitution: divide by $u_(i i)$
  $ x_3 &= y_3 / u_33 &&= 18 / (-9) = -2 \
    x_2 &= (y_2 - u_23 x_3) / u_22 &&= (6 - (-2)(-2)) / 2 = 1 \
    x_1 &= (y_1 - u_12 x_2 - u_13 x_3) / u_11 &&= (7 - (4)(1) - (1)(-2)) / 1 = 5 $
  $ x = mat(5; 1; -2) $


// ================= CROUT =================
== Crout Decomposition

*Format:* \
*Set $u_(i i) = 1$*

#small[
  $ mat(a_11, a_12, dots.h, a_(1 n); a_21, a_22, dots.h, a_(2 n); dots.v, dots.v, dots.down, dots.v; a_(n 1), a_(n 2), dots.h, a_(n n))
    = mat(l_11, 0, dots.h, 0; l_21, l_22, dots.h, 0; dots.v, dots.v, dots.down, dots.v; l_(n 1), l_(n 2), dots.h, l_(n n))
      mat(1, u_12, dots.h, u_(1 n); 0, 1, dots.h, u_(2 n); dots.v, dots.v, dots.down, dots.v; 0, 0, dots.h, 1) $
]

The diagonal entries of $U$ need not be stored, since $u_(i i) = 1, forall i$

$ bold([L | U]) = mat(
  l_11, u_12, u_13, dots.h, u_(1 n);
  l_21, l_22, u_23, dots.h, u_(2 n);
  l_31, l_32, l_33, dots.h, u_(3 n);
  dots.v, dots.v, dots.v, dots.down, dots.v;
  l_(n 1), l_(n 2), l_(n 3), dots.h, l_(n n)
) $

*Formula:* \
Multiplying out $L U$  *(for $bold(n = 3)$)*
 and equating it entry by entry with $A$.

#small[
  $ mat(a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33)
    = mat(
      l_11, l_11 u_12, l_11 u_13;
      l_21, l_21 u_12 + l_22, l_21 u_13 + l_22 u_23;
      l_31, l_31 u_12 + l_32, l_31 u_13 + l_32 u_23 + l_33
    ) $
]

*Crout Algorithm (General Steps):*

#[
  #set enum(numbering: "i.")

  + Calculate the first column of $L$: $l_(i 1) = a_(i 1), quad forall i = 1, dots, n$.
    - Column 1 is the pivot column, so nothing is subtracted from it and it is
      copied directly from $A$.

  + Substitute 1s in the diagonal of $U$: $u_(i i) = 1, quad forall i = 1, dots, n$.

  + Calculate the elements in the first row of $U$ (except $u_11$): \
    $u_(1 j) = a_(1 j) / l_11, quad forall j = 2, dots, n$.
    - This scales the first row of $A$ down by the pivot $l_11$

  + Calculate the rest of the elements, with the $k$th column of $L$ calculated first (they
    are used for calculating $k$th row of $U$):

    #[
      #set list(marker: [▸])
      For $k = 2, dots, n$:
      - for $i = k, k+1, dots, n$: ($k$-th column of $L$)
        $ l_(i k) = a_(i k) - sum_(m=1)^(k-1) l_(i m) u_(m k) $
      - for $j = k+1, k+2, dots, n$: ($k$-th row of $U$)
        $ u_(k j) = (a_(k j) - sum_(m=1)^(k-1) l_(k m) u_(m j)) / l_(k k) $
    ]


    - *Column of $L$*: For each entry $a_(i j)$, subtract the total amount that got
      removed from it during elimination. \
      _example_: $l_32 = a_32 - l_31 u_12$ \
      #h(2em) $a_32 = l_31 u_12 + l_32$ (same as $a_32$ in the formula matrix above)

    - *Row of $U$*: Do the same subtraction and divide by the current pivot. \
      _example_: $u_23 = (a_23 - l_21 u_13) / l_22$ \
      #h(2em) $a_23 = l_21 u_13 + l_22 u_23$ (same as $a_23$ in the formula matrix above) #cite(<lu2021>)

  + *Forward substitution*: solve $L y = b$ for $y$
    - Divide by $l_(i i)$.

  + *Backward substitution:* solve $U x = y$ for $x$
    - Since $u_(i i) = 1$, there is no division.
] \
\


*Crout Worked Example: (lec slide 9/35)*

- Given:
  $ A = mat(1, 4, 1; 1, 6, -1; 2, -1, 2), quad b = mat(7; 13; 5) $

- Set $A = L U$, where $U$ has a unit diagonal:
  $ L = mat(l_11, 0, 0; l_21, l_22, 0; l_31, l_32, l_33), quad
    U = mat(1, u_12, u_13; 0, 1, u_23; 0, 0, 1) $

- Using the formula matrix above, multiply out $L U$ and set it equal to $A$. Each
  entry on the left equals the matching entry of $A$
  #small[
    $ mat(
      l_11, l_11 u_12, l_11 u_13;
      l_21, l_21 u_12 + l_22, l_21 u_13 + l_22 u_23;
      l_31, l_31 u_12 + l_32, l_31 u_13 + l_32 u_23 + l_33
    ) = mat(1, 4, 1; 1, 6, -1; 2, -1, 2) $
  ]

- *Pivot* $bold(k = 1)$
  - Column 1 of $L$: no subtraction since sum is empty
    $ l_11 &= a_11 = 1 \
      l_21 &= a_21 = 1 \
      l_31 &= a_31 = 2 $
  - Row 1 of $U$: divide by the pivot $l_11$
    $ u_12 &= a_12 / l_11 = 4 / 1 = 4 \
      u_13 &= a_13 / l_11 = 1 / 1 = 1 $
    $ L = mat(1, 0, 0; 1, l_22, 0; 2, l_32, l_33), quad
      U = mat(1, 4, 1; 0, 1, u_23; 0, 0, 1) $
      

- *Pivot* $bold(k = 2)$
  - Column 2 of $L$: subtract what was removed during elimination
    $ l_22 &= a_22 - l_21 u_12 = 6 - (1)(4) = 2 \
      l_32 &= a_32 - l_31 u_12 = -1 - (2)(4) = -9 $
  - Row 2 of $U$: divide by the pivot $l_22$
    $ u_23 &= (a_23 - l_21 u_13) / l_22 \
           &= (-1 - (1)(1)) / 2 \
           &= -1 $
    $ L = mat(1, 0, 0; 1, 2, 0; 2, -9, l_33), quad
      U = mat(1, 4, 1; 0, 1, -1; 0, 0, 1) $

- *Pivot* $bold(k = 3)$
  - Column 3 of $L$
    $ l_33 &= a_33 - (l_31 u_13 + l_32 u_23) \
           &= 2 - ((2)(1) + (-9)(-1)) \
           &= 2 - (2 + 9) \
           &= -9 $
    $ L = mat(1, 0, 0; 1, 2, 0; 2, -9, -9), quad
      U = mat(1, 4, 1; 0, 1, -1; 0, 0, 1) $

- Forward Substitution: divide by $l_(i i)$
  $ y_1 &= b_1 / l_11 &&= 7 / 1 = 7 \
    y_2 &= (b_2 - l_21 y_1) / l_22 &&= (13 - (1)(7)) / 2 = 3 \
    y_3 &= (b_3 - l_31 y_1 - l_32 y_2) / l_33 &&= (5 - (2)(7) - (-9)(3)) / (-9) = (5 - 14 + 27) / (-9) = -2 $
  $ y = mat(7; 3; -2) $

- Backward Substitution: since $u_(i i) = 1$, there is no division
  $ x_3 &= y_3 &&= -2 \
    x_2 &= y_2 - u_23 x_3 &&= 3 - (-1)(-2) = 1 \
    x_1 &= y_1 - u_12 x_2 - u_13 x_3 &&= 7 - (4)(1) - (1)(-2) = 5 $
  $ x = mat(5; 1; -2) $

// ─────────────────────────────────────────────
#heading(numbering: none)[LDU Decomposition]

*Recall:* $A = L U$ is not unique for a non-singular matrix $A$, it depends on the
constraints

LDU Decomposition resolves this by factoring out the diagonal pivot values into a
separate diagonal matrix $D$:

*$ A = L D U $*

$ A = underbrace(mat(1, 0, 0; *, 1, 0; *, *, 1), L)
      underbrace(mat(*, "", ""; "", *, ""; "", "", *), D)
      underbrace(mat(1, *, *; 0, 1, *; 0, 0, 1), U) $

where: \
*$L$* = unit lower triangular matrix (ones on the main diagonal) \
*$D$* = diagonal matrix of the pivots \
*$U$* = unit upper triangular matrix (ones on the main diagonal)

\

*Theorem (Unique Factorization):*

Suppose $A$ is non-singular and can be transformed to $U$ without row interchanges.
Then the factorization $A = L D U$ (with $L$ and $U$ having 1s on the diagonal and $D$
diagonal with non-zero diagonal entries) is 
*unique* \
\


*Getting LDU from LU decomposition:*

- *Doolittle decomposition (DooL1ttle)*
  - $bold(A) = L_D U_D$, where $L_D$ already has 1s on the diagonal
  - $bold(D) = "diag"(u_11, u_22, dots, u_(n n))$, the diagonal of $U_D$
  - $bold(U)_C = D^(-1) U_D$ (divide row $i$ of $U_D$ by $u_(i i)$)
  - $bold(L)_D$ stays the same.
- *Crout decomposition (CroU1)*
  - $bold(A) = L_C U_C$, where $U_C$ already has 1s on the diagonal
  - $bold(D) = "diag"(l_11, l_22, dots, l_(n n))$, the diagonal of $L_C$
  - $bold(L)_D = L_C D^(-1)$ (divide column $j$ of $L_C$ by $l_(j j)$)
  - $bold(U)_C$ stays the same.
  \

*Form Transformation *

$A = L_D U_D = (L_D D)(D^(-1) U_D) = L_C U_C$, where $D$ is a factored diagonal
matrix

- *From Doolittle $arrow.r$ Crout:* (row normalization)
  - $L_C = L_D D$ \
    $U_C = D^(-1) U_D$
  #small[
    $ underbrace(mat(2, 2, 4; 0, 3, -3; 0, 0, 4), U_D)
      = underbrace(mat(2, 0, 0; 0, 3, 0; 0, 0, 4), D)
        underbrace(mat(2/2, 2/2, 4/2; 0, 3/3, (-3)/3; 0, 0, 4/4), D^(-1) U_D = U_C)
        arrow.r.double A = underbrace((L_D D), L_C) U_C $
  ]

\
- *From Crout $arrow.r$ Doolittle:* (column normalization)
   - $U_C = D^(-1) U_D$ \
    $D U_C = D D^(-1) U_D$ \
    $U_D = D U_C$
  - $L_C = L_D D$ \
    $L_C D^(-1) = L_D D D^(-1)$ \
    $L_D = L_C D^(-1)$
  #small[
    $ underbrace(mat(2, 0, 0; 2, 3, 0; 4, -3, 4), L_C)
      = underbrace(mat(2/2, 0, 0; 2/2, 3/3, 0; 4/2, (-3)/3, 4/4), L_C D^(-1) = L_D)
        underbrace(mat(2, 0, 0; 0, 3, 0; 0, 0, 4), D)
        arrow.r.double A = L_D underbrace((D U_C), U_D) $
  ]
// ─────────────────────────────────────────────

#bibliography("../../resources/bibs/class_notes/le1/lu_decomposition.bib")
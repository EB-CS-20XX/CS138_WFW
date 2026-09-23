#import "../../template.typ": project
#show: project.with(
  title: "LU Decomposition: Solved Problems",
  contributor: "Janelle Mendoza ",
  date: "September 23 2026",
)

#show bibliography: set heading(numbering: none)
#let small(body) = text(size: 9.5pt, body)

// ─────────────────────────────────────────────
#heading(numbering: none)[Problem 1: Crout Decomposition]

*Book:* _Numerical Methods for Engineers_, Steven Chapra and Raymond Canale
#cite(<chapra2010>)

*Given:* Perform Crout decomposition on the system below, then multiply the
resulting $L$ and $U$ matrices to verify that $A$ is produced.

$ 2x_1 - 5x_2 + x_3 = 12 \
  -x_1 + 3x_2 - x_3 = -8 \
  3x_1 - 4x_2 + 2x_3 = 16 $
$ A = mat(2, -5, 1; -1, 3, -1; 3, -4, 2) $

- Set $A = L U$, where $U$ has a unit diagonal:
  $ L = mat(l_11, 0, 0; l_21, l_22, 0; l_31, l_32, l_33), quad
    U = mat(1, u_12, u_13; 0, 1, u_23; 0, 0, 1) $

- *Formula matrix:* multiplying out $L U$ (for $n = 3$) and equating it entry by entry
  with $A$.
  #small[
    $ mat(
      l_11, l_11 u_12, l_11 u_13;
      l_21, l_21 u_12 + l_22, l_21 u_13 + l_22 u_23;
      l_31, l_31 u_12 + l_32, l_31 u_13 + l_32 u_23 + l_33
    ) = mat(2, -5, 1; -1, 3, -1; 3, -4, 2) $
  ]

- *Pivot* $bold(k = 1)$
  - Column 1 of $L$: no subtraction since nothing has been eliminated yet

    $ l_11 &= a_11 = 2 \
      l_21 &= a_21 = -1 \
      l_31 &= a_31 = 3 $
  - Row 1 of $U$: divide by the pivot $l_11$
    $ u_12 &= a_12 / l_11 = (-5) / 2 = -2.5 \
      u_13 &= a_13 / l_11 = 1 / 2 = 0.5 $
    $ L = mat(2, 0, 0; -1, l_22, 0; 3, l_32, l_33), quad
      U = mat(1, -2.5, 0.5; 0, 1, u_23; 0, 0, 1) $

- *Pivot* $bold(k = 2)$
  - Column 2 of $L$: subtract what was removed during elimination
    $ l_22 &= a_22 - l_21 u_12 = 3 - (-1)(-2.5) = 0.5 \
      l_32 &= a_32 - l_31 u_12 = -4 - (3)(-2.5) = 3.5 $
  - Row 2 of $U$: divide by the pivot $l_22$
    $ u_23 &= (a_23 - l_21 u_13) / l_22 \
           &= (-1 - (-1)(0.5)) / 0.5 \
           &= -1 $
    $ L = mat(2, 0, 0; -1, 0.5, 0; 3, 3.5, l_33), quad
      U = mat(1, -2.5, 0.5; 0, 1, -1; 0, 0, 1) $

- *Pivot* $bold(k = 3)$
  - Column 3 of $L$
    $ l_33 &= a_33 - (l_31 u_13 + l_32 u_23) \
           &= 2 - ((3)(0.5) + (3.5)(-1)) \
           &= 2 - (-2) \
           &= 4 $
    $ L = mat(2, 0, 0; -1, 0.5, 0; 3, 3.5, 4), quad
      U = mat(1, -2.5, 0.5; 0, 1, -1; 0, 0, 1) $

*Verifying $bold(L U = A)$:*

Row 1 of $L U$
  $ (L U)_11 &= (2)(1) + (0)(0) + (0)(0) &= 2 \
    (L U)_12 &= (2)(-2.5) + (0)(1) + (0)(0) &= -5 \
    (L U)_13 &= (2)(0.5) + (0)(-1) + (0)(1) &= 1 $

Row 2 of $L U$
  $ (L U)_21 &= (-1)(1) + (0.5)(0) + (0)(0) &= -1 \
    (L U)_22 &= (-1)(-2.5) + (0.5)(1) + (0)(0) &= 3 \
    (L U)_23 &= (-1)(0.5) + (0.5)(-1) + (0)(1) &= -1 $

Row 3 of $L U$
  $ (L U)_31 &= (3)(1) + (3.5)(0) + (4)(0) &= 3 \
    (L U)_32 &= (3)(-2.5) + (3.5)(1) + (4)(0) &= -4 \
    (L U)_33 &= (3)(0.5) + (3.5)(-1) + (4)(1) &= 2 $

$ L U = mat(2, -5, 1; -1, 3, -1; 3, -4, 2) = A  $

// ─────────────────────────────────────────────
#heading(numbering: none)[Problem 2: Doolittle Decomposition]

*Book:* _Numerical Methods in Engineering with Python 3_, Jaan Kiusalaas
#cite(<kiusalaas2013>)

*Given:* Solve $A X = b$ by Doolittle's decomposition method, where

$ A = mat(2.34, -4.10, 1.78; -1.98, 3.47, -2.22; 2.36, -15.17, 6.18), quad
  b = mat(0.02; -0.73; -6.63) $

- Set $A = L U$, where $L$ has a unit diagonal:
  $ L = mat(1, 0, 0; l_21, 1, 0; l_31, l_32, 1), quad
    U = mat(u_11, u_12, u_13; 0, u_22, u_23; 0, 0, u_33) $

- *Formula matrix:* multiplying out $L U$ (for $n = 3$) and equating it entry by entry
  with $A$.
  #small[
    $ mat(
      u_11, u_12, u_13;
      l_21 u_11, l_21 u_12 + u_22, l_21 u_13 + u_23;
      l_31 u_11, l_31 u_12 + l_32 u_22, l_31 u_13 + l_32 u_23 + u_33
    ) = mat(2.34, -4.10, 1.78; -1.98, 3.47, -2.22; 2.36, -15.17, 6.18) $
  ]

- *Pivot* $bold(k = 1)$
  - Row 1 of $U$: no subtraction since nothing has been eliminated yet
    $ u_11 &= a_11 = 2.34 \
      u_12 &= a_12 = -4.10 \
      u_13 &= a_13 = 1.78 $
  - Column 1 of $L$: divide by the pivot $u_11$
    $ l_21 &= a_21 / u_11 = (-1.98) / 2.34 = -0.846154 \
      l_31 &= a_31 / u_11 = 2.36 / 2.34 = 1.008547 $
    $ L = mat(1, 0, 0; -0.846154, 1, 0; 1.008547, l_32, 1), quad
      U = mat(2.34, -4.10, 1.78; 0, u_22, u_23; 0, 0, u_33) $

- *Pivot* $bold(k = 2)$
  - Row 2 of $U$: subtract what was removed during elimination
    $ u_22 &= a_22 - l_21 u_12 = 3.47 - (-0.846154)(-4.10) = 0.000769 \
      u_23 &= a_23 - l_21 u_13 = -2.22 - (-0.846154)(1.78) = -0.713846 $
  - Column 2 of $L$: divide by the pivot $u_22$
    $ l_32 &= (a_32 - l_31 u_12) / u_22 \
           &= (-15.17 - (1.008547)(-4.10)) / 0.000769 \
           &= (-11.034957) / 0.000769 \
           &= -14345.444 $
    $ L = mat(1, 0, 0; -0.846154, 1, 0; 1.008547, -14345.444, 1), quad
      U = mat(2.34, -4.10, 1.78; 0, 0.000769, -0.713846; 0, 0, u_33) $

- *Pivot* $bold(k = 3)$
  - Row 3 of $U$
    $ u_33 &= a_33 - (l_31 u_13 + l_32 u_23) \
           &= 6.18 - ((1.008547)(1.78) + (-14345.444)(-0.713846)) \
           &= 6.18 - (1.795214 + 10240.440) \
           &= 6.18 - 10242.236 \
           &= -10236.056 $
    $ L = mat(1, 0, 0; -0.846154, 1, 0; 1.008547, -14345.444, 1), quad
      U = mat(2.34, -4.10, 1.78; 0, 0.000769, -0.713846; 0, 0, -10236.056) $

- *Forward substitution*: solve $L y = b$ for $y$ ($l_(i i) = 1$, so there is no division)
  $ y_1 &= b_1 &&= 0.02 \
    y_2 &= b_2 - l_21 y_1 &&= -0.73 - (-0.846154)(0.02) = -0.713077 \
    y_3 &= b_3 - l_31 y_1 - l_32 y_2 &&= -6.63 - (1.008547)(0.02) - (-14345.444)(-0.713077) \
        & &&= -6.63 - 0.020171 - 10229.405 = -10236.056 $
  $ y = mat(0.02; -0.713077; -10236.056) $

- *Backward substitution*: solve $U x = y$ for $x$ (divide by $u_(i i)$)
  $ x_3 &= y_3 / u_33 &&= (-10236.056) / (-10236.056) = 1 \
    x_2 &= (y_2 - u_23 x_3) / u_22 &&= (-0.713077 - (-0.713846)(1)) / 0.000769 = 0.000769 / 0.00769 =
     1 \
    x_1 &= (y_1 - u_12 x_2 - u_13 x_3) / u_11 &&= (0.02 - (-4.10)(1) - (1.78)(1)) / 2.34 = 2.34 / 2.34 & =
     1 $
  $ x = mat(1; 1; 1) $

// ─────────────────────────────────────────────
#heading(numbering: none)[Problem 3:  LDU Decomposition (Follow-up)]

*Given:* Using the $L$ and $U$ matrices already found from (Problem 2), compute the LDU decomposition of $A$.

$ A = mat(2.34, -4.10, 1.78; -1.98, 3.47, -2.22; 2.36, -15.17, 6.18) $

$ L = mat(1, 0, 0; -0.846154, 1, 0; 1.008547, -14345.444, 1), quad
  U = mat(2.34, -4.10, 1.78; 0, 0.000769, -0.713846; 0, 0, -10236.056) $

- *Step 1:* Extract $D$ (the pivots, diagonal of $U$)
  $ D = mat(2.34, 0, 0; 0, 0.000769, 0; 0, 0, -10236.056) $

- *Step 2:* Get new $U$ by dividing each row of old $U$ by its pivot

    - Row 1 /2.34:
    $ u_12 &= (-4.10) / 2.34 &&= -1.752137 \
      u_13 &= 1.78 / 2.34 &&= 0.760684 $

  - Row 2 /0.000769:
    $ u_23 &= (-0.713846) / 0.000769 &&= -928.278 $

  - Row 3 / (-10236.056):
    $ u_33 &= 1 & $

  $ U' = mat(1, -1.752137, 0.760684; 0, 1, -928.278; 0, 0, 1) $

*Result:*
#small[
  $ A = L D U = mat(1, 0, 0; -0.846154, 1, 0; 1.008547, -14345.444, 1)
    mat(2.34, 0, 0; 0, 0.000769, 0; 0, 0, -10236.056)
    mat(1, -1.752137, 0.760684; 0, 1, -928.278; 0, 0, 1) $
]

// ─────────────────────────────────────────────
#heading(numbering: none)[Problem 4: Solving $bold(A x = b)$  (Follow-up)]

*Given:* Using the $L$ and $U$ matrices already found from Problem 1, solve $A x = b$ by first solving $L y = b$ for $y$, then solving $U x = y$ for $x$.

$ A = mat(2, -5, 1; -1, 3, -1; 3, -4, 2), quad b = mat(1; 4; 9) $

$ L = mat(2, 0, 0; -1, 0.5, 0; 3, 3.5, 4), quad
  U = mat(1, -2.5, 0.5; 0, 1, -1; 0, 0, 1) $

- *Forward substitution:* solve $L y = b$
  $ y_1 &= b_1 / l_11 &&= 1 / 2 = 0.5 \
    y_2 &= (b_2 - l_21 y_1) / l_22 &&= (4 - (-1)(0.5)) / 0.5 = 4.5 / 0.5 = 9 \
    y_3 &= (b_3 - l_31 y_1 - l_32 y_2) / l_33 &&= (9 - 3(0.5) - 3.5(9)) / 4 = (-24) / 4 = -6 $
  $ y = mat(0.5; 9; -6) $

- *Backward substitution:* solve $U x = y$
  $ x_3 &= y_3 &&= -6 \
    x_2 &= y_2 - u_23 x_3 &&= 9 - (-1)(-6) = 9 - 6 = 3 \
    x_1 &= y_1 - u_12 x_2 - u_13 x_3 &&= 0.5 - (-2.5)(3) - (0.5)(-6) = 0.5 + 7.5 + 3 = 11 $
  $ x = mat(11; 3; -6) $

#bibliography("../../resources/bibs/compendium/le1/1.2_numerical_methods_for_engineers.bib")
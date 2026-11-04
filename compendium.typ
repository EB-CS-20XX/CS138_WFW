#set page(paper: "a4", margin: (x: 2cm, y: 2cm))
#set text(font: "Liberation Serif", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true)
#set math.mat(delim: "[")
#set math.vec(delim: "[")

#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)

#show bibliography: set heading(numbering: none)
#let small(body) = text(size: 9.5pt, body)

#align(center)[
  #text(size: 18pt, weight: "bold")[Arc 1 Compendium] \
  #v(0.3em)
  #text(size: 14pt)[CS138 WFW] \
  #v(0.5em)
  S.Y. 2026 -- 2027
]
#v(2em)

#heading(level: 2, numbering: none)[Group Assignments & Contributions]

#align(center)[
  #block(width: 100%)[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr),
      align: center,
      stroke: 0.5pt + luma(200),
      
      table.header(
        [*Group 1 (WFW-1)*], [*Group 2 (WFW-2)*], [*Group 3 (WFW-3)*], [*Group 4 (WFW-4)*]
      ),
      
      [Dean Robin Alcancia], [Nathan Kim Chua], [Justine Marvie Buenaventura], [Sean Vin David Disu],
      [Janelle Mendoza], [Allen Buck Diao], [Reuter Jan Camacho], [Ryan Luis Dela Cruz], 
      [Princess Chariz Bialen], [James Jacob Emnace], [Kolleen Geri Aguilar], [Enrico Baratang],
      [Alphonso Clarence Carandang], [Karl Benedict Real], [Jonathan David Pagaduan], [Jan Michael Tauli]
    )
  ]
]

#outline(title: "Contents")
#v(2em)
#line(length: 100%)
#v(2em)
#pagebreak()


// ==============================================================================
= Group 1 (WFW-1)
#v(1.5em)

// ─────────────────────────────────────────────
== (Alcancia)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Exercise 6.1 \#6a: Row Interchanges in Gaussian Elimination*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, p. 368
  #cite(<burden2010numerical>)

  *Problem Statement:* \
  Use the Gaussian Elimination Algorithm to solve the following linear system, if possible, and determine whether row interchanges are necessary:
  $ cases(
      x_2 - 2 x_3 = 4,
      x_1 - x_2 + x_3 = 6,
      x_1 - x_3 = 2
    ) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *Augmented form $[A | b]$:*
  $ [A | b] = mat(delim: "[", augment: #(-1), 0, 1, -2, 4; 1, -1, 1, 6; 1, 0, -1, 2) $

  #v(1em)

  *Forward Elimination ($k = 1$)*
  - The initial pivot entry is $a_(11) = 0$. Since division by zero is undefined, a *row interchange is needed.*
  - Search below $a_(11)$ for the first nonzero value and we find $a_(21) = 1 != 0$.
  - *Interchange:* $E_1 <-> E_2$:
    $ mat(delim: "[", augment: #(-1), 1, -1, 1, 6; 0, 1, -2, 4; 1, 0, -1, 2) $
  - Eliminate entry $a_(31)$ in row 3 using pivot row 1:
    $ m_(31) &= a_(31) / a_(11) = 1 / 1 = 1 \
      R_3 &<- R_3 - (1) R_1 \
      a_(32) &= 0 - (1)(-1) = 1 \
      a_(33) &= -1 - (1)(1) = -2 \
      b_3 &= 2 - (1)(6) = -4 $

  The updated matrix is:
  $ mat(delim: "[", augment: #(-1), 1, -1, 1, 6; 0, 1, -2, 4; 0, 1, -2, -4) $

  #v(1em)

  *Forward Elimination ($k = 2$)*
  - Current pivot entry is $a_(22) = 1 != 0$. No row interchange is needed.
  - Eliminate entry $a_(32)$ in row 3 using pivot row 2:
    $ m_(32) &= a_(32) / a_(22) = 1 / 1 = 1 \
      R_3 &<- R_3 - (1) R_2 \
      a_(33) &= -2 - (1)(-2) = 0 \
      b_3 &= -4 - (1)(4) = -8 $

  The upper triangular form is:
  $ mat(delim: "[", augment: #(-1), 1, -1, 1, 6; 0, 1, -2, 4; 0, 0, 0, -8) $

  #v(1em)

  *Conclusion*
  - Exactly one row interchange ($E_1 <-> E_2$) was required.
  - The third equation simplifies to $0 x_1 + 0 x_2 + 0 x_3 = -8$, which is impossible. Therefore, the system is inconsistent and no solution exists.
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Exercise 6.2 \#1a: Row Interchanges in Gaussian Elimination*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, p. 380
  #cite(<burden2010numerical>)

  *Problem Statement:* \
  Find the row interchanges that are required to solve the following linear system using Algorithm 6.1 (standard Gaussian Elimination with backward substitution):
  $ cases(
      x_1 - 5 x_2 + x_3 = 7,
      10 x_1 + 20 x_3 = 6,
      5 x_1 - x_3 = 4
    ) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *Augmented form $[A | b]$:*
  $ [A | b] = mat(delim: "[", augment: #(-1), 1, -5, 1, 7; 10, 0, 20, 6; 5, 0, -1, 4) $

  #v(1em)

  *Elimination Phase ($k = 1$)*
  - The initial pivot entry is $a_(11) = 1$. Since $a_(11) != 0$, a row interchange is not needed.
  - Multipliers:
    $ m_(21) = a_(21) / a_(11) = 10 / 1 = 10, quad m_(31) = a_(31) / a_(11) = 5 / 1 = 5 $
  - Row updates:
    - $R_2 <- R_2 - 10 R_1$:
      $ a_(22) &= 0 - 10(-5) = 50 \
        a_(23) &= 20 - 10(1) = 10 \
        b_2 &= 6 - 10(7) = -64 $
    - $R_3 <- R_3 - 5 R_1$:
      $ a_(32) &= 0 - 5(-5) = 25 \
        a_(33) &= -1 - 5(1) = -6 \
        b_3 &= 4 - 5(7) = -31 $

  Updated matrix:
  $ mat(delim: "[", augment: #(-1), 1, -5, 1, 7; 0, 50, 10, -64; 0, 25, -6, -31) $

  #v(1em)

  *Elimination Phase ($k = 2$)*
  - The pivot entry is $a_(22) = 50$. Since $a_(22) != 0$, a row interchange is not needed.
  - Multiplier:
    $ m_(3 2) = a_(32) / a_(22) = 25 / 50 = 0.5 $
  - Row update:
    - $R_3 <- R_3 - 0.5 R_2$:
      $ a_(3 3) &= -6 - 0.5(10) = -11 \
        b_3 &= -31 - 0.5(-64) = 1 $

  Upper triangular matrix:
  $ mat(delim: "[", augment: #(-1), 1, -5, 1, 7; 0, 50, 10, -64; 0, 0, -11, 1) $

  #v(1em)

  *Backward Substitution*
  - From row 3:
    $ x_3 = 1 / (-11) = -1/11 $
  - From row 2:
    $ x_2 = (-64 - 10 x_3) / 50 = (-64 - 10(-1/11)) / 50 = -694 / 550 = -347 / 275 $
  - From row 1:
    $ x_1 = 7 + 5 x_2 - x_3 = 7 + 5(-347 / 275) - (-1/11) = 215 / 275 = 43 / 55 $

  #v(1em)

  *Conclusion*
  - No row interchanges are needed when executing Algorithm 6.1, because all encountered pivot elements are nonzero ($a_(11) = 1 $ and $a_(22) = 50$).
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Exercise 6.1 & 6.2 Remixed Problems*
  #line(length: 100%)
  *Problem Statement:* \
  + *Part 1 (Inspired by 6.1 6a):*
    Consider the system:
    $ cases(
        x_2 - 2 x_3 = 4,
        x_1 - x_2 + x_3 = 6,
        x_1 - x_3 = b_3
      ) $
    Find the value of $b_3$ that makes the system consistent, and determine whether this eliminates the need for the row interchange in Algorithm 6.1.

  + *Part 2 (Inspired by 6.2 1a):*
    Consider the system:
    $ cases(
        x_1 - 5 x_2 + x_3 = 7,
        10 x_1 + 20 x_3 = 6,
        5 x_1 - x_3 = 4
      ) $
    Apply Scaled Partial Pivoting at step $k = 1$ and identify which row is chosen as the pivot row. Compare its multipliers against Algorithm 6.1.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *Solution: Part 1*

  *Augmented form $[A | b]$:*
  $ [A | b] = mat(delim: "[", augment: #(-1), 0, 1, -2, 4; 1, -1, 1, 6; 1, 0, -1, b_3) $

  *Analyze Matrix*
  - Notice how the rows are connected:
    $ R_1 + R_2 = R_3 $
  - For the augmented matrix to be consistent, the constants must satisfy the exact same linear combination:
    $ b_1 + b_2 = b_3 => 4 + 6 = b_3 => b_3 = 10 $

  *Elimination Phase ($k = 1$)*
  - The initial pivot entry is $a_(11) = 0$. Since division by zero is not possible, a row interchange is still required regardless of the value of $b_3$.
  - Swap $R_1 <-> R_2$:
    $ mat(delim: "[", augment: #(-1), 1, -1, 1, 6; 0, 1, -2, 4; 1, 0, -1, 10) $
  - Multiplier:
    $ m_(31) = a_(31) / a_(11) = 1 / 1 = 1 $
  - Row update:
    - $R_3 <- R_3 - 1 R_1$:
      $ a_(32) &= 0 - 1(-1) = 1 \
        a_(33) &= -1 - 1(1) = -2 \
        b_3 &= 10 - 1(6) = 4 $

  Updated matrix:
  $ mat(delim: "[", augment: #(-1), 1, -1, 1, 6; 0, 1, -2, 4; 0, 1, -2, 4) $

  *Elimination Phase ($k = 2$)*
  - The pivot entry is $a_(22) = 1$. Since $a_(22) != 0$, a row interchange is not needed.
  - Multiplier:
    $ m_(32) = a_(32) / a_(22) = 1 / 1 = 1 $
  - Row update:
    - $R_3 <- R_3 - 1 R_2$:
      $ a_(33) &= -2 - 1(-2) = 0 \
        b_3 &= 4 - 1(4) = 0 $

  Upper triangular matrix:
  $ mat(delim: "[", augment: #(-1), 1, -1, 1, 6; 0, 1, -2, 4; 0, 0, 0, 0) $

  *Conclusion: Part 1*
  - Setting $b_3 = 10$ makes the system consistent, producing infinitely many solutions:
    $ x(t) = mat(delim: "[", 10; 4; 0) + t mat(delim: "[", 1; 2; 1), quad t in RR $
  - Restoring consistency *does not* eliminate the need for the row interchange because pivot selection depends only on $A$, where $a_(1 1) = 0$ still forces $R_1 <-> R_2$.

  #line(length: 100%, stroke: 0.5pt + gray)

  *Solution: Part 2*

  *Augmented form $[A | b]$:*
  $ [A | b] = mat(delim: "[", augment: #(-1), 1, -5, 1, 7; 10, 0, 20, 6; 5, 0, -1, 4) $

  *Scale Factors and Initial Row-Order Vector*
  - Row maximums:
    - Row 1: $s_1 = max(|1|, |-5|, |1|) = 5$
    - Row 2: $s_2 = max(|10|, |0|, |20|) = 20$
    - Row 3: $s_3 = max(|5|, |0|, |-1|) = 5$
    - Scale vector: $s = [5, 20, 5]$
  - Initial row-order vector:
    $ ell = [1, 2, 3] $

  *Pivot Selection ($k = 1$)*
  - Evaluate relative ratios for column 1:
    - Row 1: $|a_(1 1)| / s_1 = 1 / 5 = 0.20$
    - Row 2: $|a_(2 1)| / s_2 = 10 / 20 = 0.50$
    - Row 3: $|a_(3 1)| / s_3 = 5 / 5 = 1.00$
  - The maximum ratio is at Row 3. Swap $ell_1 <-> ell_3$:
    $ ell = [3, 2, 1] $

  *Multiplier Comparison*
  - Multipliers with Scaled Partial Pivoting (Pivot row = Row 3):
    $ m_(11) = a_(11) / a_(31) = 1 / 5 = 0.20, quad m_(21) = a_(21) / a_(31) = 10 / 5 = 2.00 $
  - Multipliers from Algorithm 6.1 (Pivot row = Row 1):
    $ m_(21) = 10 / 1 = 10, quad m_(31) = 5 / 1 = 5 $

  *Conclusion: Part 2*
  - Scaled Partial Pivoting selects *Row 3* as the pivot row ($ell = [3, 2, 1]$).
  - Algorithm 6.1's choice of Row 1 yields large multipliers ($10$ and $5$) because $a_(11) = 1$ is the weakest relative entry ($0.20$ vs $1.00$), making it more prone to round-off errors in later eliminations.
]

#line(length: 100%)

#pad(left: 2em)[
  *AI Contribution Statement:* \
  During the preparation of this work, the author(s) utilized Google Gemini solely to aid in typesetting, formatting of mathematical expressions in Typst, syntax verification, and proofreading. (Conversation Link: #link("https://share.gemini.google/Es3lGDSaIlPk"))
]

#line(length: 100%)


// ─────────────────────────────────────────────
== (Mendoza)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 1: Crout Decomposition*
  #line(length: 100%)
  *Reference:* _Numerical Methods for Engineers_, Steven Chapra and Raymond Canale
  #cite(<chapra2010>)

  *Given:* Perform Crout decomposition on the system below, then multiply the
  resulting $L$ and $U$ matrices to verify that $A$ is produced.

  $ 2x_1 - 5x_2 + x_3 = 12 \
    -x_1 + 3x_2 - x_3 = -8 \
    3x_1 - 4x_2 + 2x_3 = 16 $
  $ A = mat(2, -5, 1; -1, 3, -1; 3, -4, 2) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  - Set $A = L U$, where $U$ has a unit diagonal:
    $ L = mat(l_11, 0, 0; l_21, l_22, 0; l_31, l_32, l_33), quad
      U = mat(1, u_12, u_13; 0, 1, u_23; 0, 0, 1) $

  - *Formula matrix:* multiplying out $L U$ (for $n = 3$) and equating it entry by entry
    with $A$.
    #text(size: 9.5pt)[
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

  $ L U = mat(2, -5, 1; -1, 3, -1; 3, -4, 2) = A $
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 2: Doolittle Decomposition*
  #line(length: 100%)
  *Reference:* _Numerical Methods in Engineering with Python 3_, Jaan Kiusalaas
  #cite(<kiusalaas2013>)

  *Given:* Solve $A X = b$ by Doolittle's decomposition method, where

  $ A = mat(2.34, -4.10, 1.78; -1.98, 3.47, -2.22; 2.36, -15.17, 6.18), quad
    b = mat(0.02; -0.73; -6.63) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  - Set $A = L U$, where $L$ has a unit diagonal:
    $ L = mat(1, 0, 0; l_21, 1, 0; l_31, l_32, 1), quad
      U = mat(u_11, u_12, u_13; 0, u_22, u_23; 0, 0, u_33) $

  - *Formula matrix:* multiplying out $L U$ (for $n = 3$) and equating it entry by entry
    with $A$.
    #text(size: 9.5pt)[
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
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 3: LDU Decomposition (Follow-up)*
  #line(length: 100%)
  *Given:* Using the $L$ and $U$ matrices already found from (Problem 2), compute the LDU decomposition of $A$.

  $ A = mat(2.34, -4.10, 1.78; -1.98, 3.47, -2.22; 2.36, -15.17, 6.18) $

  $ L = mat(1, 0, 0; -0.846154, 1, 0; 1.008547, -14345.444, 1), quad
    U = mat(2.34, -4.10, 1.78; 0, 0.000769, -0.713846; 0, 0, -10236.056) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
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
  #text(size: 9.5pt)[
    $ A = L D U = mat(1, 0, 0; -0.846154, 1, 0; 1.008547, -14345.444, 1)
      mat(2.34, 0, 0; 0, 0.000769, 0; 0, 0, -10236.056)
      mat(1, -1.752137, 0.760684; 0, 1, -928.278; 0, 0, 1) $
  ]
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 4: Solving $bold(A x = b)$ (Follow-up)*
  #line(length: 100%)
  *Given:* Using the $L$ and $U$ matrices already found from Problem 1, solve $A x = b$ by first solving $L y = b$ for $y$, then solving $U x = y$ for $x$.

  $ A = mat(2, -5, 1; -1, 3, -1; 3, -4, 2), quad b = mat(1; 4; 9) $

  $ L = mat(2, 0, 0; -1, 0.5, 0; 3, 3.5, 4), quad
    U = mat(1, -2.5, 0.5; 0, 1, -1; 0, 0, 1) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
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
]

#line(length: 100%)


// ─────────────────────────────────────────────
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
== (Carandang)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 6.3.26*
  #line(length: 100%)
  *Reference:* _Introduction to Linear Algebra_ (6th ed.), Gilbert Strang
  #cite(<strang2023>)

  *Problem Statement:* \
  For which numbers $b$ and $c$ is each matrix positive definite? Factor each matrix $S$ into $L D L^T$:
  $ S_1 = mat(1, b; b, 9), quad S_2 = mat(2, 4; 4, c), quad S_3 = mat(c, b; b, c) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1. First Matrix: $S_1 = mat(1, b; b, 9)$*
  - *Positive Definiteness:* \
    - first leading minors:
      - $det(S_(1,1)) = 1 > 0$  
    - second leading minor:
      - $det(S_1) = 9 - b^2$.
    $det(S_1) > 0 => 9 - b^2 > 0 ==> $* $ -3 < b < 3$ *
  
  - *Elimination & Factorization:* 
    - First Pivot: $d_1 = a_(11)= 1$. 
    - Multiplier: $ell_(21)=(a_(21)/d_1)=b/1=b$
    - Row operation $R_2 arrow.l R_2 - b R_1$ to second pivot: $d_2 = 9-b(b)=9 - b^2$.
    $ 
    L = mat(1, 0; ell_(21), 1)= mat(1, 0; b, 1), quad 
    D = mat(d_1, 0; 0, d_2) = mat(1, 0; 0, 9-b^2), quad
    L^T = mat(1,b; 0, 1) $
    $ L D L^T = mat(1, 0; b, 1) mat(1, 0; 0, 9 - b^2) mat(1, b; 0, 1) = mat(1, 0; b, 9 - b^2) mat(1, b; 0, 1) = mat(1, b; b, 9) = S_1 $
  
  #align(center)[#block(
    inset: 10pt,
    stroke: rgb("000000"),
  )[
    $ L D L^T = mat(1, 0; b, 1) mat(1, 0; 0, 9 - b^2) mat(1, b; 0, 1) $
  ]]

  #v(1em)

  *2. Second Matrix: $S_2 = mat(2, 4; 4, c)$*
  - *Positive Definiteness:* \
    - first leading minors:
      - $det(S_(2,1)) = 2 > 0$  
    - second leading minor:
      - $det(S_2) = 2c - 16$.
    $ det(S_2) > 0 => 2c - 16 > 0 ==>$* $c > 8 $*
  
  - *Elimination & Factorization:* 
    - First Pivot: $d_1 = a_(11) = 2$. 
    - Multiplier: $ell_(21)=(a_(21)/d_1)= 4/2 = 2$
    - Row operation $R_2 arrow.l R_2 - 2 R_1$ to second pivot: $d_2 = c-2(4)=c - 8$.
    $ 
    L = mat(1, 0; ell_(21), 1)= mat(1, 0; 2, 1), quad 
    D = mat(d_1, 0; 0, d_2) = mat(2, 0; 0, c-8), quad
    L^T = mat(1,2; 0, 1) $
    $ L D L^T = mat(1, 0; 2, 1) mat(2, 0; 0, c - 8) mat(1, 2; 0, 1) = mat(2, 0; 4, c - 8) mat(1, 2; 0, 1) = mat(2, 4; 4, c) = S_2 $
  
  #align(center)[#block(
    inset: 10pt,
    stroke: rgb("000000"),
  )[
    $ L D L^T =mat(1, 0; 2, 1) mat(2, 0; 0, c - 8) mat(1, 2; 0, 1) $
  ]]

  #v(1em)

  *3. Third Matrix: $S_3 = mat(c, b; b, c)$*
  - *Positive Definiteness:* \
    - first leading minors:
      - $det(S_(3,1)) = c > 0$  
    - second leading minor:
      - $det(S_3) = c^2 - b^2$.
    $ det(S_3) > 0 => c^2 - b^2 > 0 => c^2 > b^2==>$* $c > |b| $*
  
  - *Elimination & Factorization:* 
    - First Pivot: $d_1 = a_(11) = c$. 
    - Multiplier: $ell_(21)=(a_(21)/d_1)= b/c$
    - Row operation $R_2 arrow.l R_2 - (b/c) R_1$ to second pivot: $d_2 = c-b/c (b)=c - b^2/c=(c^2-b^2)/c$.
    $ 
    L = mat(1, 0; ell_(21), 1)= mat(1, 0; b/c, 1), quad 
    D = mat(d_1, 0; 0, d_2) = mat(c, 0; 0, c-b^2/c), quad
    L^T = mat(1,b/c; 0, 1) $
    $ L D L^T = mat(1, 0; b/c, 1) mat(c, 0; 0, c - b^2/c) mat(1, b/c; 0, 1) = mat(c, 0; b, c - b^2/c) mat(1, b/c; 0, 1) = mat(c, b; b, c) = S_3 $
  
  #align(center)[#block(
    inset: 10pt,
    stroke: rgb("000000"),
  )[
    $ L D L^T = mat(1, 0; b/c, 1) mat(c, 0; 0, c - b^2/c) mat(1, b/c; 0, 1) $
  ]]
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Exercise 4.11*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_, Urbain Vaes
  #cite(<vaes2023>)

  *Problem Statement:* \
  Let $A in RR^(n times n)$ be a symmetric positive definite matrix. Show that the functional
  $ norm(dot)_A : x |-> sqrt(x^T A x) $
  defines a norm on $RR^n$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  The mapping of $norm(dot)_A : RR^n -> RR$ is valid norm iff it satisfies these three axioms: \ 

  + *Positivity:*\
    Because $A$ is SPD, by definition $x^T A x > 0$ for every non-zero vector $x in RR^n without {(0)}$.
    Taking the squareroot of both sides preserves the inequality:
    $ norm(x)_A = sqrt(x^T A x) > 0 quad s.t. quad forall x != 0 $
    For $x = 0$, we have $norm(0)_A = sqrt(0^T A (0)) = 0$. Hence, $norm(x)_A = 0 <==> x = 0$.

  + *Homogeneity:*\
    It is clear that by the transpose rule for scalar products:
    $ norm(c x)_A = sqrt((c x)^T A (c x)) = sqrt(c^2 (x^T A x)) = sqrt(c^2) sqrt(x^T A x) = |c| norm(x)_A $

  + *Triangle Inequality:*\
    Expanding the squared functional of the sum $x + y$:
    $ norm(x + y)_A^2 &= (x + y)^T A (x + y) \
                      &= x^T A x + x^T A y + y^T A x + y^T A y $
  
    Since $A$ is symmetric ($y^T A x = x^T A y$):
    $ norm(x + y)_A^2 = norm(x)_A^2 + 2 x^T A y + norm(y)_A^2 $
  
    By Cauchy-Schwarz inequality for inner products ($x^T A y <= norm(x)_A norm(y)_A$):
    $ norm(x + y)_A^2 &<= norm(x)_A^2 + 2 norm(x)_A norm(y)_A + norm(y)_A^2 \
                      &= (norm(x)_A + norm(y)_A)^2 $
  
    Square root both sides:
    #align(center)[#block(
      inset: 10pt,
      stroke: rgb("000000"),
    )[
      $ norm(x + y)_A <= norm(x)_A + norm(y)_A $
    ]]

  #align(right)[*QED.*]
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix of Problem 1*
  #line(length: 100%)
  *Problem Statement:* \
  For which numbers $b$ and $c$ is each matrix positive definite? Factor each matrix $S$ into Cholesky $L_("Chol")  L^T_("Chol")$:
  $ S_1 = mat(1, b; b, 9), quad S_2 = mat(2, 4; 4, c), quad S_3 = mat(c, b; b, c) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1. First Matrix: $S_1 = mat(1, b; b, 9)$*
  - *Domain:* 
    - $det(S_1) > 0 => 9 - b^2 > 0 ==> $* $ -3 < b < 3$ *
  - *Cholesky Decomposition:*
    Using $S_1 = L D L^T = (L D^(1/2))(D^(1/2) L^T)$:
    $ L &= mat(1, 0; b, 1)\ 
      D &= mat(d_1, 0; 0, d_2) = mat(1, 0; 0, 9-b^2), quad "it follows:" \
      D^(1/2) &= mat(1, 0; 0, sqrt(9 - b^2)) \
      L_("chol") = L D^(1/2) &= mat(1, 0; b, 1) mat(1, 0; 0, sqrt(9 - b^2)) 
                 = mat(1, 0; b, sqrt(9 - b^2)) \
      L_("chol") L_("chol")^T &= mat(1, 0; b, sqrt(9 - b^2)) mat(1, b; 0, sqrt(9 - b^2)) \
                             &= mat(1, b; b, b^2 + (9-b^2))   
                              = mat(1, b; b, 9) \
                             &= S_1 $

  #v(1em)

  *2. Second Matrix: $S_2 = mat(2, 4; 4, c)$*
  - *Domain:* \
    - $ det(S_2) > 0 => 2c - 16 > 0 ==>$* $c > 8 $*
  - *Cholesky Decomposition:* \
    $ L &= mat(1, 0; 2, 1) \
      D &= mat(2, 0; 0, c - 8), quad "it follows:" \
      D^(1/2) &= mat(sqrt(2), 0; 0, sqrt(c - 8)) \
      L_("chol") = L D^(1/2) &= mat(1, 0; 2, 1) mat(sqrt(2), 0; 0, sqrt(c - 8)) = mat(sqrt(2), 0; 2sqrt(2), sqrt(c - 8)) \
      L_("chol") L_("chol")^T &= mat(sqrt(2), 0; 2sqrt(2), sqrt(c - 8)) mat(sqrt(2), 2sqrt(2); 0, sqrt(c - 8)) \
                              &= mat(2, 4; 4, 8+(c-8)) 
                               = mat(2 , 4; 4 ,c) \
                              &= S_2 $

  #v(1em)

  *3. Third Matrix: $S_3 = mat(c, b; b, c)$*
  - *Domain:* $ det(S_3) > 0 => c^2 - b^2 > 0 => c^2 > b^2==>$* $c > |b| $*
  - *Cholesky Decomposition:*
    $ L &= mat(1, 0; b/c, 1) \
      D &= mat(c, 0; 0, (c^2 - b^2)/c), quad "it follows:" \
      D^(1/2) &= mat(sqrt(c), 0; 0, sqrt((c^2 - b^2)/c)) \
      L_("chol") = L D^(1/2) &= mat(1, 0; b/c, 1) mat(sqrt(c), 0; 0, sqrt((c^2 - b^2)/c)) = mat(sqrt(c), 0; b/sqrt(c), sqrt((c^2 - b^2)/c)) \
      L_("chol") L_("chol")^T &= mat(sqrt(c), 0; b/sqrt(c), sqrt((c^2 - b^2)/c)) mat(sqrt(c), b/sqrt(c); 0, sqrt((c^2 - b^2)/c)) \
                              &= mat(c, b; b, b^2/c + ((c^2 - b^2)/c)) 
                               = mat(c, b; b, c) \
                              &= S_3 $
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix of Problem 2*
  #line(length: 100%)
  *Problem Statement:* \
  Let $A, B in RR^(n times n)$ both be Symmetric Positive Definite (SPD) matrices.

  1. Prove that $C = A + B$ is also Symmetric Positive Definite.
  2. Show that the induced norm $norm(x)_(A+B) = sqrt(x^T (A+B) x)$ satisfies:
     $ norm(x)_(A+B) = sqrt(norm(x)_A^2 + norm(x)_B^2) $
  3. Prove the inequality $norm(x)_(A+B) <= norm(x)_A + norm(x)_B$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  + *SPD Proof $C = A + B$:*
    - *Symmetry:* 
      $ (A + B)^T = A^T + B^T = A + B $
    - *Positivity:* For any non-zero vector $x != bold(0)$, we expand the quadratic form:
      $ x^T (A + B) x = x^T A x + x^T B x $
      Since both $A$ and $B$ are SPD, we know $x^T A x > 0$ and $x^T B x > 0$. The sum of two strictly positive numbers is strictly positive:
      $ x^T (A + B) x > 0 quad forall x != bold(0) $
      Therefore, $C = A + B$ is SPD.

  + *Norm Relation:*
    Square and distribute the terms:
    $ norm(x)_(A+B)^2 &= x^T (A + B) x \
                      &= x^T A x + x^T B x \
                      &= norm(x)_A^2 + norm(x)_B^2 $
  
    Square root both sides, then:
    $ norm(x)_(A+B) = sqrt(norm(x)_A^2 + norm(x)_B^2) $

  + *Inequality Proof:*
    Since $norm(x)_A >= 0$ and $norm(x)_B >= 0$, then $2 norm(x)_A norm(x)_B >= 0$ is also non-negative. 
  
    We form the following inequality:
    $ norm(x)_(A+B)^2 &= norm(x)_A^2 + norm(x)_B^2 \
                      &<= norm(x)_A^2 + 2 norm(x)_A norm(x)_B + norm(x)_B^2 \
                      &= (norm(x)_A + norm(x)_B)^2 $

    Square root both sides, then:
    #align(center)[#block(
      inset: 10pt,
      stroke: rgb("000000"),
    )[
      $ bold(norm(x)_(A+B) <= norm(x)_A + norm(x)_B) $
    ]]

  #align(right)[*QED.*]
]

#line(length: 100%)


// ==============================================================================
#pagebreak()
= Group 2 (WFW-2)
#v(1.5em)

// ─────────────────────────────────────────────
== (Real)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 1*
  #line(length: 100%)
  *Reference:* _Math 408: Linear Least Squares_, James V. Burke
  #cite(<burke2014math408>)

  *Problem Statement:* \
  Consider the data points $(lambda_i, y_i) in RR, (1, 1), (2, 0), (-1, 2), "and" (0, -1)$. We wish to determine a real polynomial of degree $2$ that best fits this data. A general polynomial of degree 2 has the form $p(lambda) = x_0 + x_1 lambda + x_2 lambda^2$, where $x = (x_0, x_1, x_2)^T in RR^3$. Note that there are more data points that there are unknown coefficients $x_0, x_1, "and" x_2$ and so it is unlikely that there exists a second degree polynomial that fits this data precisely.

  + Write the problem of determining the quadratic polynomial that "best" fits this data as a linear least squares problem by specificying the matrix $A$ and the vector $b$.
  + Solve this linear least squares problem.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1.* Write the problem of determining the quadratic polynomial that "best" fits this data as a linear least squares problem by specificying the matrix $A$ and the vector $b$.\
  *Solution.* Here, we are trying to satisfy $y_i = x_0 + x_1 lambda_i + x_2 lambda_i^2$ for the given data $(lambda_i, y_i)$. The associated linear least squares problem is to minimize the sum of the squares of the misfits:
  $ (x_0 + x_1 + x_2 - 1)^2 + (x_0 + 2x_1 + 4x_2)^2 + (x_0 - x_1 + x_2 - 2)^2 + (x_0 + 1)^2. $
  Then, in matrix form:
  $ A = mat(1, 1, 1; 1, 2, 4; 1, -1, 1; 1, 0, 0), quad b = vec(1, 0, 2, -1) $

  #v(1em)

  *2.* Solve this linear least squares problem.\
  *Solution.* We first find the associated normal equations: $A^top A x = A^top b$.
  $ A^top A &= mat(1, 1, 1, 1; 1, 2, -1, 0; 1, 4, 1, 0) mat(1, 1, 1; 1, 2, 4; 1, -1, 1; 1, 0, 0) = mat(4, 2, 6; 2, 6, 8; 6, 8, 18) \
    A^top b &= mat(1, 1, 1, 1; 1, 2, -1, 0; 1, 4, 1, 0) vec(1, 0, 2, -1) = vec(2, -1, 3) $
  Solving for $x$,
  $ A^top A x &= A^top b \
    mat(4, 2, 6; 2, 6, 8; 6, 8, 18) vec(x_1, x_2, x_3) &= vec(2, -1, 3) => x = vec(1/5, -9/10, 1/2). $
  Therefore, the polynomial of degree two that best fits this data in the least squares sense is
  $ p(lambda) = lambda^2/2 - (9lambda)/10 + 1/5. $
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 2*
  #line(length: 100%)
  *Reference:* _Least Squares Problems and QR Factorization_, TU Delft
  #cite(<tudelft-least-squares>)

  *Problem Statement:* \
  We want to find the least squares solution for a $3 times 2$ system using $Q R$ decomposition. Use the factorization $A = Q R$ to find the least-squares solution of $A x = b$, with
  $ A = mat(2, 3; 2, 4; 1, 1) = mat(2/3, -1/3; 2/3, 2/3; 1/3, -2/3) mat(3, 5; 0, 1), quad b = vec(7, 3, 1) $

  + Given any $A in M_(m times n)$ with $A = Q R$ where $Q$ has orthonormal columns, show that the normal equations $A^top A x = A^ top b$ reduces to $R x = Q^top b$.
  + Solve the least-squares solution to the linear system $A x = b$ using the equation: $R x = Q^top b$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1.* Given any $A in M_(m times n)$ with $A = Q R$ where $Q$ has orthonormal columns, show that the normal equations $A^top A x = A^ top b$ reduces to $R x = Q^top b$. \
  *Proof.*
  $ A^top A &= (Q R)^top (Q R) \
    &= R^top Q^top Q R \
    &= R^top (Q^top Q) R \
    &= R^top I R \
    &= R^top R $
  Then, 
  $ A^top A x = A^ top b => R^top R x = R^top Q^top b. $ 
  Since $R$ is invertible, $R^top$ is invertible too. Therefore,
  $ R^top R x &= R^top Q^top b \
    (R^top)^(-1) R^top R x &= (R^top)^(-1) R^top Q^top b \
    ((R^top)^(-1) R^top) R x &= ((R^top)^(-1) R^top) Q^top b \
    R x &= Q^top b quad square.filled $

  #v(1em)

  *2.* Solve the least-squares solution to the linear system $A x = b$ using the equation: $R x = Q^top b$.
  \
  $ R x &= Q^top b \
    mat(3, 5; 0, 1) vec(x_0, x_1) &= mat(2/3, 2/3, 1/3; -1/3, 2/3, -2/3) vec(7, 3, 1) \
    &= vec(7, -1) $
  Using back substitution,
  $ x_1 &= -1 \
    3x_0 + 5x_1 &= 7 => x_0 = (7-5x_1)/3 = 4 $
  Therefore,
  $ x = vec(4, -1) $
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 3 (Remix)*
  #line(length: 100%)
  *Problem Statement:* \
  Consider the following data points $(lambda_i, y_i) in RR$: $(-1, 13), (0, 8), (1, 79), (2, 206)$. Find a real polynomial of degree 2: $p(lambda) = x_0 + x_1 lambda + x_2 lambda^2$ where $x = (x_0, x_1, x_2)^top in RR^3$ that best fit the given data points.

  + Construct the LLS problem in matrix form: $A x tilde.equiv b$ and solve for the $Q R$ factorization $A = Q R$ using Gram-Schmidt.
  + Use the equation from Problem 2a to solve for $x$, then find the 2nd degree polynomial $p(lambda)$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1.* Construct the LLS problem in matrix form: $A x tilde.equiv b$ and solve for the $Q R$ factorization $A = Q R$ using Gram-Schmidt.\
  
  *Solution.* We want to minimize
  $ (x_0 - x_1 + x_2 - 13)^2 + (x_0 - 8)^2 + (x_0 + x_1 + x_2 - 79)^2 + (x_0 + 2x_1 + 4x_2 - 206)^2. $
  Then,
  $ A x &= b \
    mat(1, -1, 1; 1, 0, 0; 1, 1, 1; 1, 2, 4) vec(x_0, x_1, x_2) &= vec(13, 8, 79, 206) $
  Solving for $A = Q R$:
  $ a_1 = vec(1, 1, 1, 1), quad a_2 = vec(-1, 0, 1, 2), quad a_3 = vec(1, 0, 1, 4) $
  $ v_1 &= a_1 = vec(1, 1, 1, 1) => q_1 = 1/2 vec(1, 1, 1, 1) \
    r_(11) &= chevron.l q_1, a_1 chevron.r = 1/2 + 1/2 + 1/2 + 1/2 = 2 $
  $ r_(12) &= chevron.l q_1, a_2 chevron.r = -1/2+0+1/2+1=1 \
    v_2 &= a_2 - r_(12) q_1 = vec(-1, 0, 1, 2) - vec(1/2, 1/2, 1/2, 1/2) = vec(-3/2, -1/2, 1/2, 3/2) => \
    q_2 &= 1/sqrt(9/4+1/4+1/4+9/4) vec(-3/2, -1/2, 1/2, 3/2) = 1/(2sqrt(5)) vec(-3, -1, 1, 3) $
  $ r_(13) &= chevron.l q_1, a_3 chevron.r = 1/2(1+1+4)=3 \
    r_(22) &= chevron.l q_2, a_2 chevron.r = 1/(2sqrt(5))(3+1+6) = sqrt(5) \
    r_(23) &= chevron.l q_2, a_3 chevron.r = 1/(2sqrt(5))(-3+1+12)=sqrt(5) $
  $ v_3 &= a_3 - r_(13)q_1 - r_(23)q_2 = vec(1, 0, 1, 4) - 3/2 vec(1, 1, 1, 1) - 1/2 vec(-3, -1, 1, 3) = vec(1, -1, -1, 1) => \
    q_3 &= 1/2 vec(1, -1, -1, 1) \
    r_(33) &= chevron.l q_3, a_3 chevron.r = 1/2(1-1+4)=2 $
  Therefore,
  $ A = Q R = mat(1/2, -3/(2sqrt(5)), 1/2; 1/2, -1/(2sqrt(5)), -1/2; 1/2, 1/(2sqrt(5)), -1/2; 1/2, 3/(2sqrt(5)), 1/2) mat(2, 1, 3; 0, sqrt(5), sqrt(5); 0, 0, 2). $

  #v(1em)

  *2.* Use the equation from Problem 2a to solve for $x$, then find the 2nd degree polynomial $p(lambda)$.  \
  *Solution.* Substituting to $R x = Q^top b$:
  $ mat(2, 1, 3; 0, sqrt(5), sqrt(5); 0, 0, 2) vec(x_0, x_1, x_2) &= mat(1/2, 1/2, 1/2, 1/2; -3/(2sqrt(5)), -1/(2sqrt(5)), 1/(2sqrt(5)), 3/(2sqrt(5)); 1/2, -1/2, -1/2, 1/2) vec(13, 8, 79, 206) \
    &= vec(153, 325/sqrt(5), 66) $
  Then,
  $ 2x_2 &= 66 => x_2 = 33 \
    sqrt(5) x_1 &= 325/sqrt(5) - sqrt(5) x_2 => x_1 = 32 \
    2x_0 &= 153 - x_1 - 3x_2 => x_0 = 11 $
  Therefore, the polynomial that best estimate the given data points is 
  $ p(lambda) = 11 + 32 lambda + 33 lambda^2. $
]

#line(length: 100%)


// ==============================================================================
#pagebreak()
= Group 3 (WFW-3)
#v(1.5em)

// ─────────────────────────────────────────────
== (Buenaventura)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
*Jacobi and Gauss-Seidel Exercises*
#line(length: 100%) 
+ Find the first two iterations of the Jacobi method for the following linear systems, using $bold(x)^((0)) = [0, 0, 0]$ (Burden & Faires, 2010, p. 459, Item 1.a):


$ 3 x_1 - x_2 + x_3 &= 1, \
      3 x_1 + 6 x_2 + 2 x_3 &= 0, \
      3 x_1 + 3 x_2 + 7 x_3 &= 4. $

+ Find the first two iterations of the Gauss-Seidel method for the following linear systems, using $bold(x)^((0)) = [0, 0, 0]$ (Burden & Faires, 2010, p. 460, Item 3):

$     3 x_1 - x_2 + x_3 &= 1, \
      3 x_1 + 6 x_2 + 2 x_3 &= 0, \
      3 x_1 + 3 x_2 + 7 x_3 &= 4. $


+ *[Item 01 Remix]* Find the Jacobi iteration matrix of item 01 and, without checking the SDD, determine if the algorithm converges.


+ *[Item 02 Remix]* Find the Gauss-Seidel iteration matrix of item 02 and, without checking the SDD, determine if the algorithm converges.]

=== Solutions
#line(length: 50%)

+ 
  From the system, we get this matrix,
    $ mat(
      3, -1, 1,| 1;
      3, 6, 2, | 0;
      3, 3, 7, | 4
    ) $

  Isolating x, we get the following equations:
    $ x_1 = (x_2 - x_3 + 1) / 3 $

    $ x_2 = (-3 x_1 - 2 x_3) / 6 $

    $ x_3 = (-3 x_1 - 3 x_2 + 4) / 7 $

    #v(1em)
  We then use the initial guess $x^((0))$ to determine the values of $x_1^((1)), x_2^((1)), "and" x_1^((1))$ 
    $ x_1^((1)) = (0 - 0 + 1) / 3 = 1/3 $

    $ x_2^((1)) = (0 - 0) / 6 = 0 $

    $ x_3^((1)) = (0 - 0 + 4) / 7 = 4/7 $

    #v(1.5em)

  We repeat the process and use $x^((1))$ to determine the values of $x_1^((2)), x_2^((2)), "and" x_1^((2))$ 
    $ x_1^((2)) = (0 - 4/7 + 1) / 3 = 1/7 $

    $ x_2^((2)) = (-3(1/3) - 2(4/7)) / 6 = -5/14 $

    $ x_3^((2)) = (-3(1/3) - 3(0) + 4) / 7 = 3/7 $

    #v(1.5em)

    #underline[Iteration Summary Table]

    #v(0.5em)

    #align(center)[
      #table(
        columns: (auto, 1cm, 1.2cm, 1.5cm),
        align: center + horizon,
        [], [*0*], [*1*], [*2*],
        [$x_1$], [$0$], [$1/3$], [$1/7$],
        [$x_2$], [$0$], [$0$], [$-5/14$],
        [$x_3$], [$0$], [$4/7$], [$3/7$],
      )
    ]

+ 
  Using the same x equations from item 01, we get the following values after applying Gauss-Seidel

  Iteration 1:
    $ x_1^((1)) = (0 - 0 + 1) / 3 = 1/3 $

    $ x_2^((1)) = (-3(1/3)-2(0)) / 6 = -1/6 $

    $ x_3^((1)) = (-3(1/3)-3(-1/6)+4) / 7 = 1/2 $

    #v(1.5em)

  Iteration 2:
    $ x_1^((2)) = (-1/6 - 1/2 + 1) / 3 = 1/9 $

    $ x_2^((2)) = (-3(1/9) - 2(1/2)) / 6 = -2/9 $

    $ x_3^((2)) = (-3(1/9) - 3(-2/9) + 4) / 7 = 13/21 $

    #v(1.5em)

    #underline[Iteration Summary Table]

    #v(0.5em)

    #align(center)[
      #table(
        columns: (auto, 1cm, 1.2cm, 1.5cm),
        align: center + horizon,
        [], [*0*], [*1*], [*2*],
        [$x_1$], [$0$], [$1/3$], [$1/9$],
        [$x_2$], [$0$], [$-1/6$], [$-2/9$],
        [$x_3$], [$0$], [$1/2$], [$13/21$],
      )
    ]


+ #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[

    Note that: $T_J = -D^(-1)(L + U) "and" A=D+L+U$
  ]

  $
  L = mat(
    0, 0, 0;
    3, 0, 0;
    3, 3, 0
  )
  #h(2em)
  U = mat(
    0, -1, 1;
    0, 0, 2;
    0, 0, 0
  )
  $

  $
  L + U = mat(
    0, -1, 1;
    3, 0, 2;
    3, 3, 0
  )
  $

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  D = mat(
    3, 0, 0;
    0, 6, 0;
    0, 0, 7
  )
  #h(2em)
  -D^(-1) = mat(
    -1/3, 0, 0;
    0, -1/6, 0;
    0, 0, -1/7
  )
  $

  $
  T_j = mat(
    -1/3, 0, 0;
    0, -1/6, 0;
    0, 0, -1/7
  )
  mat(
    0, -1, 1;
    3, 0, 2;
    3, 3, 0
  )
  $

  $
  T_j = #rect(inset: 6pt)[$
    mat(
      0, 1/3, -1/3;
      -1/2, 0, -1/3;
      -3/7, -3/7, 0
    )
  $]
  $

  #v(1em)
  * We now find $rho(T_j)$*

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  det(T_j - lambda I) = mat(
    delim: "|",
    -lambda, 1/3, -1/3;
    -1/2, -lambda, -1/3;
    -3/7, -3/7, -lambda
  ) = 0
  $

  $
  => (-lambda)(lambda^2 - 1/7) - (1/3)(1/2 lambda - 1/7) + (-1/3)(3/14 - 3/7 lambda) = 0
  $

  $
  => -lambda^3 + 1/7 lambda - 1/6 lambda + 1/21 - 1/14 + 1/7 lambda = 0
  $

  $
  => -lambda^3 + 5/42 lambda - 1/42 = 0
  $

  $
  => lambda_1 = -0.4193 => |lambda_1| = 0.4193
  $

  $
  lambda_(2,3) = 0.20966 +- 0.1132 i
  $

  $
  => |lambda_(2,3)| = sqrt((1/42) / (|lambda_1|)) approx 0.23829
  $

  #v(0.5em)
  $
  therefore rho(T_j) = |lambda_1| = 0.4193 < 1
  $

  $therefore$ *The Jacobi method will converge.*





+
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[

    Note that: $T_"GS" = -(D+L)^(-1)U "and" A=D+L+U$
  ]

  $
  D = mat(
    3, 0, 0;
    0, 6, 0;
    0, 0, 7
  )
  #h(2em)
  L = mat(
    0, 0, 0;
    3, 0, 0;
    3, 3, 0
  )
  $

  $
  D+L = mat(
    3, 0, 0;
    3, 6, 0;
    3, 3, 7
  )
  $

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  (D+L)^(-1) = mat(
    1/3, 0, 0;
    -1/6, 1/6, 0;
    -1/14, -1/14, 1/7
  )

  #h(2em)
-(D+L)^(-1) = mat(
    -1/3, 0, 0;
    1/6, -1/6, 0;
    1/14, 1/14, -1/7
  )
  $

  $
  T_"GS" = mat(
    -1/3, 0, 0;
    1/6, -1/6, 0;
    1/14, 1/14, -1/7
  )
  mat(
    0, -1, 1;
    0, 0, 2;
    0, 0, 0
  )
  $

  $
  T_"GS" = #rect(inset: 6pt)[$
    mat(
      0, 1/3, -1/3;
      0, -1/6, -1/6;
      0, -1/14, 3/14
    )
  $]
  $

  #v(1em)
  * We now find $rho(T_"GS")$*

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  det(T_"GS" - lambda I) = mat(
    delim: "|",
    -lambda, 1/3, -1/3;
    0, -1/6-lambda, -1/6;
    0, -1/14, 3/14-lambda
  ) = 0
  $

  $
  => (-lambda)((-1/6 - lambda)(3/14 - lambda) - (-1/6)(-1/14)) = 0
  $

  $
  => -lambda((-1/28 + 1/6 lambda - 3/14lambda + lambda^2) - (1/84)) = 0
  $

  $
  => -lambda(lambda^2 - 1/21lambda - 1/21) = 0
  $

  $
  => lambda_1 = |(1+sqrt(85))/42| => |lambda_1| = 0.2433
  $

  $
  => lambda_2 = |(1-sqrt(85))/42| => |lambda_2| = 0.1957
  $

  $
  => |lambda_3| = 0
  $

  #v(0.5em)
  $
  therefore rho(T_"GS") = |lambda_1| = 0.2433 < 1
  $

  $therefore$ *The Gauss-Seidel method will converge.*

#line(length:100%)

== (Pagaduan)
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[ 
*Successive Over-Relaxation Exercises*
#line(length:100%)
1. Find the first two iterations of the SOR method with $omega=1.1$ for the following linear system, using $bold(x)^((0)) = [0, 0, 0]$ (Burden & Faires, 2010, p. 485, Item 1.b):

$ 10 x_1 - x_2 #h(34pt) &= 9, \
      - x_1 + 10 x_2 - 2 x_3 &= 7, \
      #h(34pt) - 2 x_2 + 10 x_3 &= 6. $
      
2. Determine if the matrix in item $1$ is both tridiagonal and positive definite. If so, find the optimal choice for $omega$. (Burden & Faires, 2010, p. 486, Item 7):

3. *[Item 1 and 2 Remix]* Given a tridiagonal and positive definite matrix, suppose we try to approximate $omega_"opt"$ by repeatedly taking the midpoint of a given search interval, starting at $(1, 2)$. In how many iterations would this method approximate $omega_"opt"$ to within an accuracy $epsilon$?  
]

=== Solutions
#line(length: 100%)
1. The system is equivalent to the coefficient matrix
  $
    mat(
      10, -1, 0;
      -1, 10, -2;
      0, -2, 10;
    )
  $
  The SOR method updates the $k^("th")$ approximation for $x_i$ using the following formula:
  $ x_i^((k))=(1-omega)x_i^((k-1))+omega/a_(i i)[b_i - sum_(j=1)^(i-1)a_(i j)x_j^((k)) - sum_(j=i+1)^n a_(i j)x_j^((k-1))] $
  Thus, with $omega=1.1$ and $x^((0)) = [0 #h(5pt) 0 #h(5pt) 0]^T$, the first iteration of the SOR method gives us
  $
  x_1^((1)) &= -0.1(0) + 0.11(9 + 0) = bold(0.99) \
  x_2^((1)) &= -0.1(0) + 0.11(7 + 0.99 + 0) = 0.11(7.99) = bold(0.8789) \
  x_3^((1)) &= -0.1(0) + 0.11(6 + 2(0.8789)) = 0.11(7.7578) = bold(0.853358)
  $
  The second iteration then gives us
  $
  x_1^((2)) &= -0.1(0.99) + 0.11(9 + 0.8789) = -0.099 + 1.086679 = bold(0.987679) \
  x_2^((2)) &= -0.1(0.8789) + 0.11(7 + 0.987679 + 2(0.853358)) = bold(0.978493) \
  x_3^((2)) &= -0.1(0.853358) + 0.11(6 + 2(0.97849345)) = bold(0.789933)
  $
  Thus, $x^((1)) = [0.99 #h(5pt) 0.8789 #h(5pt) 0.853358]^T$ and $x^((2)) = [0.987679 #h(5pt) 0.978493 #h(5pt) 0.789933]^T$.
#v(5pt)
2. First, we note that since we can observe that the the only nonzero entries of the matrix are found on its diagonal, subdiagonal, and superdiagonal, the matrix is tridiagonal. Furthermore, since the matrix is symmetric and strictly diagonally dominant, its eigenvalues are guaranteed to be greater than $0$. Thus, the matrix is positive definite as well.

  To find $omega_("opt")$, we utilize the following formula:\
  
  $
    omega_"opt"=(2)/(1+sqrt(1-[rho(T_J)]^2))
  $
  with $rho(T_J)$ as the spectral radius of the Jacobi iteration matrix, given by $T_J = -D^(-1)(L + U)$. Thus, we have
  $
    T_J = mat(1/10, 0, 0; 0, 1/10, 0; 0, 0, 1/10)mat(0, 1, 0; 1, 0, 2; 0, 2, 0) = mat(0, 1/10, 0; 1/10, 0, 1/5; 0, 1/5, 0)
  $
  Getting the eigenvalues of $T_J$, we have
  $
    det(T_J - lambda I) = mat(-lambda, 1/10, 0; 1/10, -lambda, 1/5; 0, 1/5, -lambda) = 0\
    -lambda(lambda^2-0.04) - 0.1(-0.1lambda) = 0\
    -lambda^3+0.04lambda+0.01lambda = 0\
    -lambda(lambda^2-0.05) = 0
  $
  Thus, $lambda_1=0$, $lambda_2=-(sqrt(5))/10$, and $lambda_3=sqrt(5)/10=rho(T_J)$.
  Plugging values into the formula yields us
  $
    omega_("opt") = 2/(1+sqrt(1-(sqrt(5)/10)^2))=2/(1+sqrt(1-1/20))=2/(1+sqrt(19/20))=2/((10+sqrt(95))/10)=1.0128
  $
  $therefore omega_"opt"=1.0128$.\
  
3. First, we must decide in which direction we search for $omega_"opt"$. Given the midpoint of the current interval, say $m$, we find $T_omega$ at $omega=m$. Then, we pick a test value for $omega$ that is close to $m$, but is either less than $m$ or greater than $m$. Let $T_(omega)$ be the SOR iteration matrix for $omega=m$, and $T_omega^*$ be the SOR iteration matrix for the test value. We then compare the value of their spectral radius:
  - If $rho(T_omega^*) < rho(T_omega)$, then picking a lesser value for $omega$ improves convergence. Thus, the next search interval we evaluate is $(1, omega^*]$.
  - If $rho(T_omega^*) > rho(T_omega)$, then picking a greater value for $omega$ improves convergence. Thus, the next search interval must be $[omega^*, 2)$.
  - If $omega_"opt"=m$, then picking test values in either direction results in a larger value for their spectral radius.
  Thus, eventually, this method will find $omega_"opt"$, albeit _very, very slowly_.\
  However, in how many iterations will it take?
  Given a search interval $[a, b]$ with length \
  $L=b-a$, after $n$ iterations, its length will eventually shrink to $(b-a)/2^n$. Keeping our approximation within a certain accuracy $epsilon$, we get the inequality \
  $
    (b-a)/2^n<=epsilon->2^n>=(b-a)/epsilon->n>=log_2((b-a)/epsilon)->n=ceil(log_2((b-a)/epsilon))
  $. \
  Thus, for example, if we want an accuracy of $epsilon=plus.minus 0.001$, the method will terminate in \
  $ n = ceil(log_2(1/0.001)) = ceil(9.9658) = 10$ iterations.
  

== (Aguilar)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[

*Iterative Refinement Exercises*
#line(length: 100%) 
  + *(i)* Use Gaussian elimination and three-digit rounding arithmetic to approximate the solutions to the following linear systems. *(ii)* Then use one iteration of iterative refinement to improve the approximation, and compare the approximations to the actual solutions

    $ 0.03x_1 + 58.9x_2 = 59.2, $
    $ 5.31x_1 - 6.10x_2 = 47.0, $
    
    Actual solution: $(10,1)^t$.
    
  + The linear system $ mat(1,2;1.0001,2) mat(x_1;x_2) = mat(3;3.0001) $ has solution $(1,1)^t$.
    
    Change $A$ slightly to $ mat(1,2;0.9999,2), $ and consider the linear system  $ mat(1,2;0.9999,2) mat(x_1;x_2) = mat(3;3.0001). $

    Compute the new solution using five-digit rounding arithmetic, and compare the actual error to the estimate $(7.25)$. Is $A$ ill-conditioned?
  
  + *[Item 01 Remix]* Use Gaussian elimination and three-digit rounding arithmetic to approximate the solutions to the following linear system. Then use one iteration of iterative refinement to improve the approximation, and compare the approximations to the actual solution.

    $ 0.04x_1 + 61.5x_2 = 123.4, $
    $ 4.21x_1 - 5.30x_2 = 31.5, $

    Actual solution: $(10,2)^t$.
    
  + *[Item 02 Remix]* The linear system $ mat(2,3;2.0001,3) mat(x_1;x_2) = mat(5;5.0001) $ has solution $(1,1)^t$.

    Change $A$ slightly to $ mat(2,3;1.9999,3), $ and consider the linear system $ mat(2,3;1.9999,3) mat(x_1;x_2) = mat(5;5.0001). $

    Compute the new solution using five-digit rounding arithmetic, compute the condition number $kappa(A)$, and use it to estimate the relative error bound. Compare this estimate to the actual relative error. Is $A$ ill-conditioned?
]

== Solutions
#line(length: 50%)

=== Item 1
#pad(left: 2em)[

  We get the following linear system:
  $ mat(0.03, 58.9; 5.31, -6.10) mat(x_1; x_2) = mat(59.2; 47.0) $
  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 5.31/0.03 = 177.$
  #pad(left: 2em)[
    $R_21 <- 5.31 - 177(0.03) = 0$
  
    $R_22 <- -6.10 - 177(58.9) approx -6.10 - 10400 approx -10400$
  
    $b_2 <- 47.0 - 177(59.2) approx 47.0 - 10500 approx -10500$
  
    We obtain
  
    $ mat(0.03, 58.9; 0, -10400) mat(x_1; x_2) = mat(59.2; -10500). $
    Using back substitution:
    $ x_2 = (-10500)/(-10400) = 1.009 approx 1.01 $
    $ 0.03 x_1 + 58.9(1.01) = 59.2 $
    $ 0.03x_1 + 59.5 = 59.2 $
    $ 0.03x_1 = 59.2-59.5 $
    $ 0.03x_1 = -0.3 $
    $ x_1 = -10 $
  
    We get the approximate solution $hat(x) = [-10, 1.01]^T$
]
  *ii.* Next, we apply iterative refinement and compare the approximations to the actual solution.
  #pad(left: 2em)[
    Get the residual $r = b - A hat(x)$.
    $ r = mat(59.2; 47) - mat(0.03,58.9;5.31,-6.10) mat(-10;1.01) $

    $ (0.03)(-10)+(58.9)(1.01) = 59.189 $
    $ (5.31)(-10)+(-6.10)(1.01) = -59.261 $
    $ r = mat(59.2 - 59.189; 47+59.261) = mat(0.011; 106.261) $

    Solve for $A delta = r$ where $delta = A^(-1)r.$

    First we solve for $A x = [1, 0]^T$

    $ L = mat(1,0;177,1), space U = mat(0.03,58.9;0,-10431.4) $
    Solve for $L y = mat(1;0)$
    $ mat(1,0;177,1) mat(y_1; y_2) = mat(1;0), space y = mat(1;-177) $
    Solve for $U x = y$
    $ mat(0.03,58.9;0,-10431.4) mat(x_1; x_2) = mat(1;-177) $
    $ x_2 = 177/10431.4 = 0.016968 $
    $ 0.03x_1 + 58.9(0.016968) = 1 $
    $ x_1 = 0.019493 $
    Which forms the first column of $ A^(-1) = mat(0.019493, ?; 0.016968, ?) $

    Next we solve for $A x = [0, 1]^T$

    Solve for $L y = mat(0;1)$
    $ mat(1,0;177,1) mat(y_1; y_2) = mat(0;1), space y = mat(0;1) $
    Solve for $U x = y$
    $ mat(0.03,58.9;0,-10431.4) mat(x_1; x_2) = mat(0;1) $
    $ x_2 = -0.0000959 $
    $ 0.03x_1 + 58.9(-0.0000959) = 0 $
    $ x_1 = 0.188283 $
    Which forms the second column of $ A^(-1) = mat(0.019493, 0.188283; 0.016968, -0.0000959) $

    Solve for $delta = A^(-1)r.$
    $ delta = mat(0.019493,0.188283;0.016968,-0.0000959) mat(0.011;106.261) $
    $ (0.019493)(0.011) + (0.188283)(106.261) = 20.007359 approx 20.007 $
    $ (0.016968)(0.011) + (-0.0000959)(106.261) = -0.0100037819 approx -0.01 $

    We get
    $ hat(x)_"new" = hat(x) + delta = mat(-10;1.01) + mat(20.007;-0.01) = mat(10.007;1) $
    $ r_"new" = b - A hat(x)_"new" = mat(59.2;47) - mat(0.03,58.9;5.31,-6.10) mat(10.007;1) $
    $ = mat(59.2;47) - mat(59.20021;47.03717) = mat(-0.00021;-0.03717) $

    Which is significantly smaller than our initial $r$.
  ]
]
#line(length: 100%)

=== Item 2
#pad(left: 2em)[

  The original system
  $ mat(1,2;1.0001,2) mat(x_1;x_2) = mat(3;3.0001) $
  has exact solution $hat(x) = (1,1)^T$. We now perturb $A$ slightly to
  $ mat(1,2;0.9999,2) mat(x_1;x_2) = mat(3;3.0001) $
  and solve using five-digit rounding arithmetic.

  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 0.9999/1 = 0.9999$.
  #pad(left: 2em)[
    $R_21 <- 0.9999 - 0.9999(1) = 0$

    $R_22 <- 2 - 0.9999(2) = 2 - 1.9998 = 0.0002$

    $b_2 <- 3.0001 - 0.9999(3) = 3.0001 - 2.9997 = 0.0004$

    We obtain

    $ mat(1,2;0,0.0002) mat(x_1;x_2) = mat(3;0.0004). $
    Using back substitution:
    $ x_2 = 0.0004/0.0002 = 2.0000 $
    $ x_1 + 2(2.0000) = 3 $
    $ x_1 = 3 - 4 $
    $ x_1 = -1.0000 $

    We get the approximate solution $hat(x) = [-1.0000, 2.0000]^T$
  ]

  *ii.* Next, we compute the actual error and compare it to the estimate given by (7.25).
  #pad(left: 2em)[
    Comparing to the exact solution of the original system, $x = (1,1)^T$:
    $ norm(x - hat(x))_infinity = norm(mat(1-(-1);1-2))_infinity = norm(mat(2;-1))_infinity = 2 $

    So $A$ changing by only $0.0002$ in one entry moved the solution by $2$ — a change of $200%$.

    We compute the perturbation $delta A = A' - A$:
    $ delta A = mat(1,2;0.9999,2) - mat(1,2;1.0001,2) = mat(0,0;-0.0002,0) $
    $ norm(delta A)_infinity = max(0, 0.0002) = 0.0002 $

    We compute $norm(A)_infinity$:
    $ norm(A)_infinity = max(1+2, 1.0001+2) = 3.0001 $

    So the relative perturbation is
    $ norm(delta A)_infinity/norm(A)_infinity = 0.0002/3.0001 approx 6.67 times 10^(-5) $

    Next we compute $K_infinity (A) = norm(A)_infinity norm(A^(-1))_infinity$.
    $ det A = 1(2) - 2(1.0001) = -0.0002 $
    $ A^(-1) = 1/(-0.0002) mat(2,-2;-1.0001,1) = mat(-10000,10000;5000.5,-5000) $
    $ norm(A^(-1))_infinity = max(10000+10000, 5000.5+5000) = 20000 $
    $ K_infinity (A) = (3.0001)(20000) approx 6.0 times 10^4 $

    Using estimate (7.25):
    $ (norm(x-hat(x)))/(norm(hat(x))) <= K_infinity (A) dot (norm(delta A)_infinity)/(norm(A)_infinity) approx (6.0 times 10^4)(6.67 times 10^(-5)) approx 4.0 $

    The actual relative error is
    $ (norm(x-hat(x))_infinity)/(norm(hat(x))_infinity) = 2/2 = 1 $

    which is well within the bound of $approx 4.0$ given by (7.25), confirming the estimate is consistent with the observed behavior.

    Since $K_infinity (A) approx 6.0 times 10^4$ is very large, a tiny relative change in $A$ (about $0.0067%$) produced a large relative change in the solution ($100%$, with the solution's sign effectively flipping). Therefore, *$A$ is ill-conditioned*.
  ]
]

#line(length: 100%)

=== Item 1 - Remix
#pad(left: 2em)[

  We get the following linear system:
  $ mat(0.04, 61.5; 4.21, -5.30) mat(x_1; x_2) = mat(123.4; 31.5) $
  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 4.21/0.04 = 105.25 approx 105.$
  #pad(left: 2em)[
    $R_21 <- 4.21 - 105(0.04) = 0.01 approx 0$

    $R_22 <- -5.30 - 105(61.5) approx -5.30 - 6460 approx -6470$

    $b_2 <- 31.5 - 105(123.4) approx 31.5 - 13000 approx -13000$

    We obtain

    $ mat(0.04, 61.5; 0, -6470) mat(x_1; x_2) = mat(123.4; -13000). $
    Using back substitution:
    $ x_2 = (-13000)/(-6470) = 2.0093 approx 2.01 $
    $ 0.04 x_1 + 61.5(2.01) = 123.4 $
    $ 0.04x_1 + 124 = 123.4 $
    $ 0.04x_1 = 123.4-124 $
    $ 0.04x_1 = -0.600 $
    $ x_1 = -15.0 $

    We get the approximate solution $hat(x) = [-15.0, 2.01]^T$
]
  *ii.* Next, we apply iterative refinement and compare the approximations to the actual solution.
  #pad(left: 2em)[
    Get the residual $r = b - A hat(x)$.
    $ r = mat(123.4; 31.5) - mat(0.04,61.5;4.21,-5.30) mat(-15.0;2.01) $

    $ (0.04)(-15.0)+(61.5)(2.01) = 123.015 $
    $ (4.21)(-15.0)+(-5.30)(2.01) = -73.803 $
    $ r = mat(123.4 - 123.015; 31.5-(-73.803)) = mat(0.385; 105.303) $

    Solve for $A delta = r$ where $delta = A^(-1)r.$

    First we solve for $A x = [1, 0]^T$

    $ L = mat(1,0;105,1), space U = mat(0.04,61.5;0,-6470) $
    Solve for $L y = mat(1;0)$
    $ mat(1,0;105,1) mat(y_1; y_2) = mat(1;0), space y = mat(1;-105) $
    Solve for $U x = y$
    $ mat(0.04,61.5;0,-6470) mat(x_1; x_2) = mat(1;-105) $
    $ x_2 = 105/6470 = 0.016229 $
    $ 0.04x_1 + 61.5(0.016229) = 1 $
    $ x_1 = 0.0479125 $
    Which forms the first column of $ A^(-1) = mat(0.0479125, ?; 0.016229, ?) $

    Next we solve for $A x = [0, 1]^T$

    Solve for $L y = mat(0;1)$
    $ mat(1,0;105,1) mat(y_1; y_2) = mat(0;1), space y = mat(0;1) $
    Solve for $U x = y$
    $ mat(0.04,61.5;0,-6470) mat(x_1; x_2) = mat(0;1) $
    $ x_2 = -0.0001546 $
    $ 0.04x_1 + 61.5(-0.0001546) = 0 $
    $ x_1 = 0.237698 $
    Which forms the second column of $ A^(-1) = mat(0.0479125, 0.237698; 0.016229, -0.0001546) $

    Solve for $delta = A^(-1)r.$
    $ delta = mat(0.0479125,0.237698;0.016229,-0.0001546) mat(0.385;105.303) $
    $ (0.0479125)(0.385) + (0.237698)(105.303) = 25.049 $
    $ (0.016229)(0.385) + (-0.0001546)(105.303) = -0.010032 $

    We get
    $ hat(x)_"new" = hat(x) + delta = mat(-15.0;2.01) + mat(25.049;-0.010032) = mat(10.049;2.00) $
    $ r_"new" = b - A hat(x)_"new" = mat(123.4;31.5) - mat(0.04,61.5;4.21,-5.30) mat(10.049;2.00) $
    $ = mat(123.4;31.5) - mat(123.402;31.706) = mat(-0.002;-0.206) $

    Which is significantly smaller than our initial $r$, and much closer to the actual solution $(10,2)^T$.
  ]
]
#line(length: 100%)

=== Item 2 - Remix
#pad(left: 2em)[

  The original system
  $ mat(2,3;2.0001,3) mat(x_1;x_2) = mat(5;5.0001) $
  has exact solution $hat(x) = (1,1)^T$. We now perturb $A$ slightly to
  $ mat(2,3;1.9999,3) mat(x_1;x_2) = mat(5;5.0001) $
  and solve using five-digit rounding arithmetic.

  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 1.9999/2 = 0.99995$.
  #pad(left: 2em)[
    $R_21 <- 1.9999 - 0.99995(2) = 1.9999 - 1.9999 = 0$

    $R_22 <- 3 - 0.99995(3) = 3 - 2.99985 = 0.00015$

    $b_2 <- 5.0001 - 0.99995(5) = 5.0001 - 4.99975 = 0.00035$

    We obtain

    $ mat(2,3;0,0.00015) mat(x_1;x_2) = mat(5;0.00035). $
    Using back substitution:
    $ x_2 = 0.00035/0.00015 = 2.3333 $
    $ 2x_1 + 3(2.3333) = 5 $
    $ 2x_1 + 6.9999 = 5 $
    $ 2x_1 = 5 - 6.9999 $
    $ 2x_1 = -1.9999 $
    $ x_1 = -0.99995 approx -1.0000 $

    We get the approximate solution $hat(x) = [-1.0000, 2.3333]^T$
  ]

  *ii.* Next, we compute the condition number $kappa(A)$ and use it to estimate the relative error bound, then compare it to the actual relative error.
  #pad(left: 2em)[
    We compute $norm(A)_infinity$:
    $ norm(A)_infinity = max(2+3, 2.0001+3) = 5.0001 $

    We compute $A^(-1)$:
    $ det A = 2(3) - 3(2.0001) = 6 - 6.0003 = -0.0003 $
    $ A^(-1) = 1/(-0.0003) mat(3,-3;-2.0001,2) = mat(-10000,10000;6667.0,-6666.7) $
    $ norm(A^(-1))_infinity = max(10000+10000, 6667.0+6666.7) = max(20000,13333.7) = 20000 $

    So the condition number is
    $ kappa_infinity (A) = norm(A)_infinity dot norm(A^(-1))_infinity = (5.0001)(20000) approx 1.0 times 10^5 $

    We compute the perturbation $delta A = A' - A$:
    $ delta A = mat(2,3;1.9999,3) - mat(2,3;2.0001,3) = mat(0,0;-0.0002,0) $
    $ norm(delta A)_infinity = max(0, 0.0002) = 0.0002 $

    So the relative perturbation is
    $ norm(delta A)_infinity/norm(A)_infinity = 0.0002/5.0001 approx 4.0 times 10^(-5) $

    Using estimate (7.25), the relative error bound is
    $ (norm(x-hat(x)))/(norm(hat(x))) <= kappa_infinity (A) dot (norm(delta A)_infinity)/(norm(A)_infinity) approx (1.0 times 10^5)(4.0 times 10^(-5)) approx 4.0 $

    Comparing to the exact solution of the original system, $x = (1,1)^T$:
    $ norm(x - hat(x))_infinity = norm(mat(1-(-1.0000);1-2.3333))_infinity = norm(mat(2.0000;-1.3333))_infinity = 2.0000 $

    The actual relative error is
    $ (norm(x-hat(x))_infinity)/(norm(hat(x))_infinity) = 2.0000/2.3333 approx 0.8571 $

    which is well within the bound of $approx 4.0$ given by (7.25), confirming the estimate is consistent with the observed behavior.

    Since $kappa_infinity (A) approx 1.0 times 10^5$ is very large, a tiny relative change in $A$ (about $0.004%$) produced a large relative change in the solution ($approx 85.7%$). Therefore, *$A$ is ill-conditioned*.
  ]
]

#line(length: 100%)

== (Camacho)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
*Iterative Refinement Practice Problems*
#line(length: 100%)
  + *Problem 1: One Step of Refinement with a Reused LU.* Let
    $ A = mat(2,1;1,3), quad b = mat(3;4), quad L = mat(1,0;0.5,1), quad U = mat(2,1;0,2.5), $
    where $A = L U$. A previous solve in limited precision produced $hat(x) = (1.1, 0.9)^T$.

    #[
      #set enum(numbering: "a)")
      + Compute the residual $r = b - A hat(x)$.
      + Using the given $L$ and $U$ (*not* by re-eliminating $A$), solve $L y = r$ by forward substitution, then $U delta = y$ by back substitution.
      + Update $hat(x)$ and compute the new residual. What does it tell you?
      + Verify by substitution that $A(hat(x) + delta) = b$.
    ]

  + *Problem 2: Mixed Precision and Conditioning.* You solve two systems in single precision (unit roundoff $u approx 6 times 10^(-8)$) using LU factorization, then apply iterative refinement. System I has $kappa(A) = 10^4$. System II has $kappa(A) = 10^9$.

    #[
      #set enum(numbering: "a)")
      + In fixed-precision refinement, roughly what is the best relative forward error you can hope for in each system? (Use the estimate $kappa(A) dot u$.)
      + For which system do you expect refinement to succeed, and for which to stagnate or fail? Explain using
        $ norm(hat(x) - x) / norm(x) <= kappa(A) norm(r) / norm(b). $
      + A classmate says: "Just run more refinement steps on System II and it will eventually fix itself." Explain why this is wrong.
      + Explain why computing $r = b - A hat(x)$ in extended (double) precision helps, while the two triangular solves can stay in single precision. Name the numerical phenomenon involved.
    ]

  + *Remix Question.* Take $n = 1000$ and use these flop counts: LU factorization $approx 2/3 n^3$; residual computation $approx 2 n^2$; each triangular solve $approx n^2$.

    #[
      #set enum(numbering: "a)")
      + Estimate the flops for the initial factorization and for *one* refinement step. What percentage of the factorization cost do 3 refinement steps add?
      + Compare this with re-factorizing $A$ from scratch at each of 3 correction steps. Roughly how many times more expensive is that?
      + Successive corrections satisfy $norm(delta^((0))) = 2 times 10^(-2)$, $norm(delta^((1))) = 4 times 10^(-4)$, $norm(delta^((2))) = 8 times 10^(-6)$, and $norm(hat(x)) approx 2$ throughout. With the stopping test $norm(delta) \/ norm(hat(x)) < 10^(-5)$, after which step does the algorithm stop?
      + Estimate the per-step error reduction factor from the $delta$ sequence. Is this behavior closer to linear or quadratic convergence?
      + State two differences between iterative refinement and Gauss-Seidel.
    ]
]

=== Solutions
#line(length: 50%)

=== Item 1
#pad(left: 2em)[
  #set enum(numbering: "a)")
  + $A hat(x) = mat(2(1.1)+1(0.9); 1(1.1)+3(0.9)) = mat(3.1; 3.8)$, so
    $ r = b - A hat(x) = mat(3-3.1; 4-3.8) = mat(-0.1; 0.2). $
  + Forward substitution, $L y = r$:
    $ y_1 = -0.1, quad y_2 = 0.2 - 0.5(-0.1) = 0.25. $
    Back substitution, $U delta = y$:
    $ delta_2 = 0.25 / 2.5 = 0.1, quad delta_1 = (-0.1 - 1(0.1)) / 2 = -0.1. $
    So $delta = (-0.1, 0.1)^T$.
  + $hat(x)_"new" = hat(x) + delta = (1.0, 1.0)^T$, which is the exact solution, so $r_"new" = (0, 0)^T$ and no further refinement is needed. In real floating-point arithmetic the new residual would be tiny but generally nonzero.
  + $A(hat(x) + delta) = A hat(x) + A delta = A hat(x) + r = A hat(x) + b - A hat(x) = b$.
]
#line(length: 100%)

=== Item 2
#pad(left: 2em)[
  #set enum(numbering: "a)")
  + System I: $10^4 times 6 times 10^(-8) approx 6 times 10^(-4)$, so roughly 3 correct digits. System II: $10^9 times 6 times 10^(-8) approx 60$, so essentially no guaranteed accuracy.
  + Refinement works on System I. On System II the bound exceeds $1$, so even a small residual guarantees nothing about the error, and refinement will stagnate or fail to converge.
  + Refinement only removes error caused by the *algorithm's* rounding. Error caused by the *problem's* sensitivity (large $kappa(A)$) sets a floor, roughly $kappa(A) dot u$, that no number of extra steps can go below.
  + Once $hat(x)$ is close to $x$, computing $b - A hat(x)$ subtracts two nearly equal numbers, which is *catastrophic cancellation*. Extended precision protects the residual, which carries the information for the next correction. The correction $delta$ only needs to be approximate, so single precision is enough for the triangular solves.
]

#v(2em)


// ==============================================================================
#pagebreak()
= Group 4 (WFW-4)
#v(1.5em)

// ─────────────────────────────────────────────
== (Dela Cruz)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 1: Shifted Inverse Power Method on a Symmetric Matrix*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, Exercise Set 9.3, Problem 3(a)
  #cite(<burden2010numerical>)

  *Problem Statement:* \
  Find the first three iterations obtained by the Shifted Inverse Power Method applied to the following matrix:
  $ A = mat(2, 1, 1; 1, 2, 1; 1, 1, 2) $
  with initial vector $x^((0)) = vec(-1, 0, 1)$ and shift $sigma = 3.5$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *Setup: Factorization of $(A - 3.5 I)$* \
  Shift the matrix by $sigma = 3.5$:
  $ A - 3.5 I = mat(-1.5, 1, 1; 1, -1.5, 1; 1, 1, -1.5) $

  We compute the Doolittle $L U$ decomposition of $(A - 3.5 I)$ once to reuse across iterations:
  - For column 1: multipliers are $m_21 = 1 / (-1.5) = -2/3$ and $m_31 = 1 / (-1.5) = -2/3$.
  - For column 2: pivot is $u_22 = -1.5 - (-2/3)(1) = -5/6$, multiplier is $m_32 = [1 - (-2/3)(1)] / (-5/6) = (5/3) / (-5/6) = -2$.
  - For column 3: $u_33 = -1.5 - [(-2/3)(1) + (-2)(5/3)] = -1.5 - (-4) = 2.5$.

  This gives:
  $ L = mat(1, 0, 0; -2/3, 1, 0; -2/3, -2, 1), quad U = mat(-1.5, 1, 1; 0, -5/6, 5/3; 0, 0, 2.5) $

  #v(1em)

  *Iterations* \
  Initial vector $x^((0)) = vec(-1, 0, 1)$ has $norm(x^((0)))_infinity = 1$ (with maximal magnitude at entry 3).

  *Iteration 1 ($k = 1$):*
  - Solve $L z = x^((0))$ (forward substitution):
    $ z = vec(-1, -2/3, -1) $
  - Solve $U y^((1)) = z$ (backward substitution):
    $ y^((1)) = vec(0.4, 0, -0.4) $
  - Entry with maximum magnitude: $mu^((1)) = -0.4$ (since $norm(y^((1)))_infinity = 0.4$).
  - Recover eigenvalue estimate:
    $ lambda^((1)) = sigma + 1 / mu^((1)) = 3.5 + 1 / (-0.4) = 3.5 - 2.5 = 1.0000 $
  - Normalize vector:
    $ x^((1)) = y^((1)) / (-0.4) = vec(-1, 0, 1) $

  *Iteration 2 & 3 ($k = 2, 3$):*
  Since $x^((1)) = x^((0))$, the right-hand side is identical to the previous step. Solving $(A - 3.5 I) y^((k)) = x^((k-1))$ produces the exact same vector:
  $ y^((2)) = y^((3)) = vec(0.4, 0, -0.4) $
  $ mu^((2)) = mu^((3)) = -0.4 $
  $ lambda^((2)) = lambda^((3)) = 3.5 + 1 / (-0.4) = 1.0000 $
  $ x^((2)) = x^((3)) = vec(-1, 0, 1) $

  #v(1em)

  *Summary of Iterations*
  #align(center)[
    #table(
      columns: (1fr, 2.5fr, 1.2fr, 1.8fr, 2.5fr),
      align: center,
      table.header([*$k$*], [*$y^((k) T)$*], [*$mu^((k))$*], [*$lambda^((k))$*], [*$x^((k) T)$*]),
      [0], [—], [—], [—], [$[-1.0000, 0.0000, 1.0000]$],
      [1], [$[0.4000, 0.0000, -0.4000]$], [$-0.4000$], [$1.0000$], [$[-1.0000, 0.0000, 1.0000]$],
      [2], [$[0.4000, 0.0000, -0.4000]$], [$-0.4000$], [$1.0000$], [$[-1.0000, 0.0000, 1.0000]$],
      [3], [$[0.4000, 0.0000, -0.4000]$], [$-0.4000$], [$1.0000$], [$[-1.0000, 0.0000, 1.0000]$]
    )
  ]

  *Note:* Since $A x^((0)) = 1 dot x^((0))$, the starting vector is already an exact eigenvector of $A$ for $lambda = 1$. The method therefore gives the exact eigenvalue and eigenvector on the first iteration.
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 2: Shifted Inverse Power Method with Shift Near an Eigenvalue*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, Exercise Set 9.3, Problem 3(b)
  #cite(<burden2010numerical>)

  *Problem Statement:* \
  Find the first three iterations obtained by the Shifted Inverse Power Method applied to:
  $ A = mat(1, 1, 1; 1, 1, 0; 1, 0, 1) $
  with initial vector $x^((0)) = vec(1, -1, 2)$ and target shift $sigma = 2$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *Setup: Inverting $(A - 2 I)$* \
  Subtract the shift $sigma = 2$:
  $ A - 2 I = mat(-1, 1, 1; 1, -1, 0; 1, 0, -1) $

  The determinant is:
  $ det(A - 2 I) = -1(1 - 0) - 1(-1 - 0) + 1(0 - (-1)) = -1 + 1 + 1 = 1 $

  Since $det(A - 2 I) = 1$, $(A - 2 I)^(-1)$ has integer entries:
  $ (A - 2 I)^(-1) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) $

  Normalize $x^((0))$ using the $l_infinity$ norm:
  $ norm(x^((0)))_infinity = 2 arrow.r.double x^((0)) = vec(0.5, -0.5, 1) $

  #v(1em)

  *Iterations* \
  *Iteration 1 ($k = 1$):*
  - Solve $(A - 2 I) y^((1)) = x^((0))$:
    $ y^((1)) = (A - 2 I)^(-1) x^((0)) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) vec(0.5, -0.5, 1) = vec(1, 1.5, 0) $
  - Maximum magnitude is at entry 2: $mu^((1)) = 1.5$.
  - Normalized iterate:
    $ x^((1)) = y^((1)) / 1.5 = vec(2/3, 1, 0) approx vec(0.666667, 1.000000, 0.000000) $
  - Eigenvalue estimate:
    $ lambda^((1)) = sigma + 1 / mu^((1)) = 2 + 1 / 1.5 = 2 + 2/3 = 8/3 approx 2.666667 $

  *Iteration 2 ($k = 2$):*
  - Solve $(A - 2 I) y^((2)) = x^((1))$:
    $ y^((2)) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) vec(2/3, 1, 0) = vec(5/3, 2/3, 5/3) approx vec(1.666667, 0.666667, 1.666667) $
  - Maximum magnitude is $mu^((2)) = 5/3$.
  - Normalized iterate:
    $ x^((2)) = (3/5) y^((2)) = vec(1, 2/5, 1) = vec(1.000000, 0.400000, 1.000000) $
  - Eigenvalue estimate:
    $ lambda^((2)) = 2 + 1 / (5/3) = 2 + 3/5 = 13/5 = 2.600000 $

  *Iteration 3 ($k = 3$):*
  - Solve $(A - 2 I) y^((3)) = x^((2))$:
    $ y^((3)) = mat(1, 1, 1; 1, 0, 1; 1, 1, 0) vec(1, 2/5, 1) = vec(12/5, 2, 7/5) = vec(2.4, 2.0, 1.4) $
  - Maximum magnitude is $mu^((3)) = 2.4$.
  - Normalized iterate:
    $ x^((3)) = y^((3)) / 2.4 = vec(1, 5/6, 7/12) approx vec(1.000000, 0.833333, 0.583333) $
  - Eigenvalue estimate:
    $ lambda^((3)) = 2 + 1 / 2.4 = 2 + 5/12 = 29/12 approx 2.416667 $

  #v(1em)

  *Summary of Iterations*
  #align(center)[
    #table(
      columns: (1fr, 2.5fr, 1.2fr, 1.8fr, 2.5fr),
      align: center,
      table.header([*$k$*], [*$y^((k) T)$*], [*$mu^((k))$*], [*$lambda^((k))$*], [*$x^((k) T)$*]),
      [0], [—], [—], [—], [$[0.5000, -0.5000, 1.0000]$],
      [1], [$[1.0000, 1.5000, 0.0000]$], [$1.5000$], [$2.6667$], [$[0.6667, 1.0000, 0.0000]$],
      [2], [$[1.6667, 0.6667, 1.6667]$], [$1.6667$], [$2.6000$], [$[1.0000, 0.4000, 1.0000]$],
      [3], [$[2.4000, 2.0000, 1.4000]$], [$2.4000$], [$2.4167$], [$[1.0000, 0.8333, 0.5833]$]
    )
  ]

  *Comparison with Exact Eigenvalues:* \
  The characteristic polynomial of $A$ is $(1 - lambda)[(1 - lambda)^2 - 2] = 0$, giving eigenvalues:
  $ lambda_1 = 1 + sqrt(2) approx 2.414214, quad lambda_2 = 1, quad lambda_3 = 1 - sqrt(2) approx -0.414214 $

  With shift $sigma = 2$, the method converges toward $lambda_1 = 1 + sqrt(2)$. By iteration 3, $lambda^((3)) = 29/12 approx 2.416667$, which is within $0.0025$ of the exact value.
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 3: Original Remix — Shared Eigenvectors and One-Step Convergence*
  #line(length: 100%)
  *Problem Statement:* \
  Context: Connecting the matrices from Problems 1 and 2 through their shared eigenvector.
 
  In Problems 1 and 2, we worked with:
  $ A_1 = mat(2, 1, 1; 1, 2, 1; 1, 1, 2) quad "and" quad A_2 = mat(1, 1, 1; 1, 1, 0; 1, 0, 1) $
  Both matrices share a common eigenvalue $lambda = 1$.

  1. Verify that $v = vec(0, 1, -1)$ is a shared eigenvector for both $A_1$ and $A_2$ corresponding to eigenvalue $lambda = 1$.
  2. Let $S = A_1 + A_2$. Show that $v$ is also an eigenvector of $S$, and find its eigenvalue $lambda_S$.
  3. Suppose we apply the Shifted Inverse Power Method to $S$ using $x^((0)) = v$ with any shift $sigma != lambda_S$. Show that the method finds $lambda_S$ in one iteration, regardless of $sigma$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *Part 1: Verifying the Shared Eigenvector* \
  Multiply $v$ by $A_1$:
  $ A_1 v = mat(2, 1, 1; 1, 2, 1; 1, 1, 2) vec(0, 1, -1) = vec(0 + 1 - 1, 0 + 2 - 1, 0 + 1 - 2) = vec(0, 1, -1) = 1 dot v $

  Multiply $v$ by $A_2$:
  $ A_2 v = mat(1, 1, 1; 1, 1, 0; 1, 0, 1) vec(0, 1, -1) = vec(0 + 1 - 1, 0 + 1 + 0, 0 + 0 - 1) = vec(0, 1, -1) = 1 dot v $

  So $v = vec(0, 1, -1)$ is an eigenvector of both $A_1$ and $A_2$ with eigenvalue $lambda = 1$.

  #v(1em)

  *Part 2: Eigenpair of the Sum Matrix $S$* \
  By linearity of matrix-vector multiplication:
  $ S v = (A_1 + A_2) v = A_1 v + A_2 v = 1 v + 1 v = 2 v $
  So $S$ has eigenvalue $lambda_S = 2$ with eigenvector $v$.

  #v(1em)

  *Part 3: One-Step Convergence of Shifted Inverse Power Method* \
  Let $sigma in RR$ be any shift such that $sigma != 2$ (so $S - sigma I$ is invertible).

  1. Multiply $v$ by $(S - sigma I)$:
     $ (S - sigma I) v = S v - sigma v = 2 v - sigma v = (2 - sigma) v $

  2. Multiply both sides by $(S - sigma I)^(-1)$ and divide by $(2 - sigma)$:
     $ (S - sigma I)^(-1) v = 1 / (2 - sigma) v $

  3. With initial vector $x^((0)) = v$ (already normalized since $norm(x^((0)))_infinity = 1$):
     $ y^((1)) = (S - sigma I)^(-1) x^((0)) = 1 / (2 - sigma) v = vec(0, 1 / (2 - sigma), -1 / (2 - sigma)) $

  4. The component with maximum absolute value is:
     $ mu^((1)) = 1 / (2 - sigma) $

  5. Normalize to get $x^((1))$:
     $ x^((1)) = y^((1)) / mu^((1)) = v $

  6. Compute the eigenvalue estimate:
     $ lambda^((1)) = sigma + 1 / mu^((1)) = sigma + (2 - sigma) = 2 $

  *Conclusion:* \
  Since the starting vector $x^((0)) = v$ is already an exact eigenvector, $(S - sigma I)^(-1)$ simply scales $v$ without introducing other components. The Shifted Inverse Power Method therefore finds the exact eigenvalue $lambda_S = 2$ in a single iteration for any shift $sigma != 2$.
]

#line(length: 100%)


// ─────────────────────────────────────────────
== (Baratang)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Eigenvalue Problems Sample Problems*
  #line(length: 100%)
  *Preface:* \
  Let it be known that, aside from cited sources involved in calculation, all arithmetic involved in this paper was calculated via Microsoft Excel. The associated .xslx file has been included in the resources of the compendium.

  *Problem Statement:* \
  Let G be a 3x3 matrix, whose eigenvalues we wish to approximate.
  $ G = mat(1, 6, 7; 6, 42, 6; 7, 6, 69) $
  Let us approximate these eigenvalues using the Shifted Inverse Power Method. But how shall we decide the shift, $sigma$ for each eigenvalue? Let us use the Gershgorin Circle Theorem!

  *1. Gershgorin Circle Theorem*
  *2. Inverse Shifted Power Method*
  *3. QR Iteration*
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1. Problem 1: Gershgorin Circle Theorem* \
  For each row the associated Gershgorin disc takes the following form:
  $ D_i = {z in CC: |z-a_(i i)| <= limits(sum)_(c=1, c!=i)^n |a_(i c)| } $
  Therefore we have
  $ D_1 &= {z in CC: |z-a_(11)| <= limits(sum)_(c=1, c!=1)^n |a_(1 c)| } = {z in CC: |z-1| <= 13 } \
    D_2 &= {z in CC: |z-a_(22)| <= limits(sum)_(c=1, c!=2)^n |a_(2 c)| } = {z in CC: |z-42| <= 12 } \
    D_3 &= {z in CC: |z-a_(33)| <= limits(sum)_(c=1, c!=3)^n |a_(3 c)| } = {z in CC: |z-69| <= 13 } $

  We can see that based on these values, these discs are isolated, and our best guesses would be at $sigma_1 = 1$, $sigma_2 = 42$, and $sigma_3 = 69$. We can confirm this by graphing them on the complex plane. An extension of the Gershgorin Circle Theorem lets us know that because each of these circles is isolated, each one contains exactly one of $G$'s eigenvalues.

  #figure(
    image("resources/images/gershgorin_discs.png"),
    caption: [Gershgorin Discs Graphed #cite(<desmos>)]
  )

  #v(1em)

  *2. Problem 2: Inverse Shifted Power Method* \
  Now we can proceed with several iterations of the Inverse Shifted Power Method, for each $sigma$, with an initial vector of $x^((0)) = vec(1, 1, 1)$.

  $ (G -I) =mat(0,6,7; 6,41,6; 7,6,68), quad (G -42I) =mat(-41,6,7; 6,0,6; 7,6,27), quad (G -69I) =mat(-68,6,7; 6,-27,6; 7,6,0) $

  While the inverse is not typically directly calculated for actual computer implementation, for convenience, confirm that the following are correct. #cite(<lazycalc>)

  $ (G -I)^(-1) &= mat(-2752/2417, 402/2417, 5/2417; 402/2417, 1/2417, -6/2417; 5/2417, -6/2417, 36/2417) \
    (G -42I)^(-1) &= mat(-1/28, -5/42, 1/28; -5/42, -289/252, 2/7; 1/28, 2/7, -1/28) \
    (G -69I)^(-1) &= mat(-4/475, 14/1425, 1/19; 14/1425, -49/4275, 2/19; 1/19, 2/19, 8/19) $

  Now, iterating with $x^((k+1)) = (G-sigma I)^(-1)x^((k))$ for 5 iterations, with each of the 3 values of $sigma$ produces the following eigenvectors:

  #align(center)[
    #text(size: 9.5pt)[
      #table(
        columns: 8,
        align: center + horizon,
        table.header([], $x^((0))$, $x^((1))$, $x^((2))$, $x^((3))$, $x^((4))$, $x^((5))$, $x^((6))$),
        $sigma=1$,
        $vec(1.000000, 1.000000, 1.000000)$,
        $vec(-0.540096, 0.094359, 0.061978)$,
        $vec(0.388676, -0.049495, -0.034732)$,
        $vec(-0.277377, 0.035742, 0.024889)$,
        $vec(0.197994, -0.025503, -0.017765)$,
        $vec(-0.141329, 0.018204, 0.012681)$,
        $vec(0.100881, -0.012994, -0.009052)$,
        $sigma = 42$,
        $vec(1.000000, 1.000000, 1.000000)$,
        $vec(-0.119048, -0.980159, 0.285714)$,
        $vec(0.131141, 1.219876, -0.294501)$,
        $vec(-0.160425, -1.498740, 0.363737)$,
        $vec(0.197142, 1.841816, -0.446931)$,
        $vec(-0.242266, -2.263406, 0.549236)$,
        $vec(0.297721, 2.781497, -0.674955)$,
        $sigma = 69$,
        $vec(1.000000, 1.000000, 1.000000)$,
        $vec(0.054035, 0.103626, 0.578947)$,
        $vec(0.031034, 0.060285, 0.257519)$,
        $vec(0.013885, 0.026721, 0.116408)$,
        $vec(0.006272, 0.012084, 0.052558)$,
        $vec(0.002832, 0.005455, 0.023732)$,
        $vec(0.001279, 0.002463, 0.010716)$
      )
    ]
  ]

  Now you might be wondering why we did a 6th iteration when we only wanted 5. To get the eigenvalues associated with these eigenvectors, we can use the Rayleigh Quotient $lambda = (x^T A x)/(x^T x)$. Notice that, because of how iteration was done, $A x$ can be substituted by for the 6th iteration.

  $ lambda'_i = (x^((5)T)(G-sigma I)x^((5)))/(x^((5)T)x^((5))) = (x^((5)T)x^((6)))/(x^((5)T)x^((5))) $

  This gives us $lambda'_1 = -0.713804, lambda'_2 = -1.228899, lambda'_3 = 0.451532$. These are labelled as $lambda'$ because we shifted then inverted the matrix. Thus we know that $lambda'_i = 1/(lambda_i-sigma)$, and consequently $lambda_i = 1/lambda'_i+sigma$. Calculating for the actual values of lambda we get:
  $ lambda_1 = -0.400946, quad lambda_2 = 41.186263, quad lambda_3 = 71.214682 $

  #v(1em)

  *3. Problem 3: QR Iteration* \
  Now let us double check our work by attempting an approximation with QR iteration. Lest we forget, let us recall that our matrix is as follows:

  $ G = mat(1, 6, 7; 6, 42, 6; 7, 6, 69) $

  Now QR factorization takes $G = Q R$ wherein $Q$ is an orthonormal matrix, and $R$ is an upper triangular matrix that is similar to $G$. 

  $ Q R = mat(dots.v, dots.v, dots.v; q_1, q_2, q_3; dots.v, dots.v, dots.v) mat(r_11, r_12, r_13; 0, r_22, r_23; 0, 0, r_33) = mat(dots.v, dots.v, dots.v; g_1, g_2, g_3; dots.v, dots.v, dots.v) = G $

  To accomplish this we can use the Gram-Schmidt orthonormalization procees to attain $Q$ while also taking note of some key intermediate values which we will use to fill up $R$.

  $ v_1 = g_1 = vec(1, 6, 7), quad r_11 = norm(v_1)_2 =9.273618, quad q_1 = v_1/r_11 = vec(0.107833, 0.646997, 0.754829) $

  $ r_12 = chevron.l q_1, g_2 chevron.r = 32.349832 $

  $ v_2 = g_2 - r_12 q_1 = vec(2.511628, 21.069767, -18.418605), quad r_22 = norm(v_2)_2 = 28.097836, quad q_2 = v_1/r_22 = vec(0.089389, 0.749872, -0.655517) $

  $ r_13 = chevron.l q_1, g_3 chevron.r = 56.720039, quad r_23 = chevron.l q_3, g_3 chevron.r =-40.105712 $

  $ v_3 = g_3 - r_13 q_1 -r_23 q_2 = vec(4.468717, -0.623542, -0.103924), quad r_33 = norm(v_3)_2 = 4.513207, quad q_3 = vec(0.990142, -0.138159, -0.023027) $

  $ Q R = mat(0.107833, 0.089389, 0.990142; 0.646997, 0.749872, -0.138159; 0.754829, -0.655517, -0.023027) mat(9.273618, 32.349832, 56.720039; 0, 28.097836, -40.105712; 0, 0, 4.513207) $

  Now that we've found our $Q R$ we can take these as our $Q^((0))$ and $R^((0))$ then iterate with $A^((k+1)) = R^((k))Q^((k))$. Once we've stopped iterating, we should be able to find our eigenvalues along the diagonal of $A$. Let's do 7 iterations.

  $ A^((1)) &= mat(64.744186, -12.093766, 3.406701; -12.093766, 47.359738, -2.958483; 3.406701, -2.958483, -0.103924) \
    A^((2)) &= mat(68.742231, -8.254123, 0.020756; -8.254123, 43.658703, -0.017104; 0.020756, -0.017104, -0.400934) \
    A^((3)) &= mat(70.339764, -5.050439, 0.000120; -5.050439, 42.061182, -0.000124; 0.000120, -0.000124, -0.400946) \
    A^((4)) &= mat(70.916256, -2.978626, 0.000001; -2.978626, 41.484690, -0.000001; 0.000001, -0.000001, -0.400946) \
    A^((5)) &= mat(71.114201, -1.734127, 0.000000; -1.734127, 41.286745, 0.000000; 0.000000, 0.000000, -0.400946) \
    A^((6)) &= mat(71.180998, -1.005153, 0.000000; -1.005153, 41.219947, 0.000000; 0.000000, 0.000000, -0.400946) \
    A^((7)) &= mat(71.203407, -0.581754, 0.000000; -0.581754, 41.197538, 0.000000; 0.000000, 0.000000, -0.400946) $

  Giving us $lambda_1 = -0.400946, quad lambda_2 = 41.197538, quad lambda_3 = 71.203407$, which is quite close to what we found with the Inverse Shifted Power Method.

  #v(1em)
  *Postscript* \
  Finally, to check our approximation, let us try and solve this analytically:
  $ det(G - lambda I) = det (mat(1-lambda, 6, 7; 6, 42-lambda, 6; 7, 6, 69-lambda) ) = 0 $
  $ (1-lambda)[(42-lambda)(69-lambda)-36] - 6[6(69-lambda)-42] +7[36-7(42-lambda)] &= 0 \
    -lambda^3 + 112 lambda^2 -3009 lambda + 36 lambda + 49 lambda + 2898 - 2232 -1806 &=0 \
    -lambda^3 + 112lambda^2 - 2888 lambda -1176 &= 0 $
]

#line(length: 100%)


// ─────────────────────────────────────────────
== (Tauli)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem: Jacobi Iteration and SDD*
  #line(length: 100%)
  *Reference:* #link("https://www.intmath.com/matrices-determinants/8-applications-eigenvalues-eigenvectors.php")[IntMath: Applications of Eigenvalues and Eigenvectors]
  #cite(<intmath_eigenvalues>)

  *Problem Statement:* \
  Consider the matrix $A$ parameterized by $k$, along with a right-hand side vector $b$ and initial guess $x^((0))$
  $ A = mat(10, 2, 1; 1, 10, k; 2, 1, 10), quad b = vec(13, 13, 13), quad x^((0)) = vec(0, 0, 0) $

  + Find the Jacobi iteration matrix $T_J$ in terms of $k$, and express its infinity norm $norm(T_J)_infinity$ as a function of $k$ (assuming $k >= 0$).
  + Determine the maximum integer value of $k$ for which SDD is preserved across all rows.
  + Using that $k$, calculate the minimum number of iterations $m$ required to guarantee that $norm(x^((m))-x^\*)_infinity <= 10^(-3)$, given that $x^((1)) = vec(1.3, 1.3, 1.3)$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1.* \
  $ A &= L + D + U \
      &= mat(0,0,0;1,0,0;2,1,0) + "diag"(10, 10, 10) + mat(0,2,1;0,0,k;0,0,0) \
    T_J &= -D^(-1)(L + U) \
    T_J &= -"diag"(1/10) mat(0,2,1;1,0,k;2,1,0) \
        &= mat(0, 0.2, 0.1; 0.1, 0, k/10; 0.2, 0.1, 0) \
    norm(T_J)_infinity &= max(0.3, 0.1 + k/10, 0.3) = max(0.3, 0.1 + k/10) $

  #v(1em)

  *2.* \
  $ "Row 1:" quad & 10 > 2 + 1 = 3 quad &("True") \
    "Row 2:" quad & 10 > 1 + k => k < 9 \
    "Row 3:" quad & 10 > 1 + 2 = 3 quad &("True") $
  The maximum integer $k$ is $8$.
  $ norm(T_J)_infinity = max(0.3, 0.1 + 8/10) = 0.9 $

  #v(1em)

  *3.* \
  Using the equation:
  $ (norm(T_J)_infinity^m) / (1 - norm(T_J)_infinity) norm(x^((1)) - x^((0)))_infinity <= 10^(-3) $
  Making the substitutions ($norm(T_J)_infinity = 0.9$, $norm(x^((1)) - x^((0)))_infinity = 1.3$):
  $ (0.9^m) / (1 - 0.9) (1.3) <= 10^(-3) $
  Solving for $m$, we have $m approx 89.907$, so a minimum of 90 iterations is required.
]

#line(length: 100%)


// ─────────────────────────────────────────────
#pagebreak()
#bibliography("resources/bibs/compendium/le1/arc1.bib")
#import "../../../template.typ": project

#show: project.with(
  title: "Exercise 6.2 #1a: Row Interchanges in Gaussian Elimination",
  contributor: "Dean Robin Alcancia",
  date: "September 28, 2026",
)

= Problem @burden2010numerical[p.380]
Find the row interchanges that are required to solve the following linear system using Algorithm 6.1 (standard Gaussian Elimination with backward substitution):
$
  cases(
    x_1 - 5 x_2 + x_3 = 7,
    10 x_1 + 20 x_3 = 6,
    5 x_1 - x_3 = 4
  )
$

= Solution

== Augmented form $[A | b]$:
$
  [A | b] = mat(delim: "[", augment: #(-1),
    1, -5, 1, 7;
    10, 0, 20, 6;
    5, 0, -1, 4
  )
$

== Elimination Phase ($k = 1$)
- The initial pivot entry is $a_(11) = 1$. Since $a_(11) != 0$, a row interchange is not needed
- Multipliers:
  $ m_(21) = frac(a_(21), a_(11)) = frac(10, 1) = 10, quad m_(31) = frac(a_(31), a_(11)) = frac(5, 1) = 5 $
- Row updates:
  - $R_2 <- R_2 - 10 R_1$:
    $ a_(22) = 0 - 10(-5) = 50 $
    $ a_(23) = 20 - 10(1) = 10 $
    $ b_2 = 6 - 10(7) = -64 $
  - $R_3 <- R_3 - 5 R_1$:
    $ a_(32) = 0 - 5(-5) = 25 $
    $ a_(33) = -1 - 5(1) = -6 $
    $ b_3 = 4 - 5(7) = -31 $

Update matrix:
$
  mat(delim: "[", augment: #(-1),
    1, -5,  1, 7;
    0, 50, 10, -64;
    0, 25, -6, -31
  )
$

== Elimination Phase ($k = 2$)
- The pivot entry is $a_(22) = 50$. Since $a_(22) != 0$, a row interchange is not needed.
- Multiplier:
  $ m_(3 2) = frac(a_(32), a_(22)) = frac(25, 50) = 0.5 $
- Row update: \
  - $R_3 <- R_3 - 0.5 R_2$:
  $ a_(3 3) = -6 - 0.5(10) = -11 $
  $ b_3 = -31 - 0.5(-64) = 1 $

Upper triangular matrix:
$
  mat(delim: "[", augment: #(-1),
    1, -5, 1, 7;
    0, 50, 10, -64;
    0, 0, -11, 1
  )
$

== Backward Substitution
- From row 3:
  $ x_3 = frac(1, -11) = -frac(1, 11) $
- From row 2:
  $ x_2 = frac(-64 - 10 x_3, 50) = frac(-64 - 10(-1/11), 50) = -frac(694, 550) = -frac(347, 275) $
- From row 1:
  $ x_1 = 7 + 5 x_2 - x_3 = 7 + 5(-frac(347, 275)) - (-frac(1, 11)) = frac(215, 275) $

== Conclusion
- No row interchanges are needed when executing Algorithm 6.1, because all encountered pivot elements are nonzero ($a_(11) = 1 $ and $a_(22) = 50$).

= AI Contribution Statement

During the preparation of this work, the author(s) utilized Google Gemini solely to aid in typesetting, formatting of mathematical expressions in Typst, syntax verification, and proofreading.

Conversation Link: https://share.gemini.google/Es3lGDSaIlPk

#bibliography("../../resources/bibs/compendium/le1/1.1_book_exercise_burden_6_2_1a.bib", style: "apa")
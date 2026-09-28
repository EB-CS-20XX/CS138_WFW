#import "../../template.typ": project

#show: project.with(
  title: "Exercise 6.1 #6a: Row Interchanges in Gaussian Elimination",
  contributor: "Dean Robin Alcancia",
  date: "September 28, 2026",
)

= Problem @burden2010numerical[p.368]
From Burden & Faires (Exercise Set 6.1, Problem 6a): \
Use the Gaussian Elimination Algorithm to solve the following linear system, if possible, and determine whether row interchanges are necessary:
$
  cases(
    x_2 - 2 x_3 = 4,
    x_1 - x_2 + x_3 = 6,
    x_1 - x_3 = 2
  )
$

= Solution

== Augmented form $[A | b]$:
$
  [A | b] = mat(delim: "[", augment: #(-1),
    0, 1, -2, 4;
    1, -1, 1, 6;
    1, 0, -1, 2
  )
$

== Forward Elimination ($k = 1$)
- The initial pivot entry is $a_(11) = 0$. Since division by zero is undefined, a *row interchange is needed.*
- Search below $a_(11)$ for the first nonzero value and we find $a_(21) = 1 != 0$.
- *Interchange:* $E_1 <-> E_2$:
  $
    mat(delim: "[", augment: #(-1),
      1, -1, 1, 6;
      0, 1, -2, 4;
      1, 0, -1, 2
    )
  $
- Eliminate entry $a_(31)$ in row 3 using pivot row 1:
  $ m_(31) = frac(a_(31), a_(11)) = frac(1, 1) = 1 $
  $ R_3 <- R_3 - (1) R_1 $
  $ a_(32) = 0 - (1)(-1) = 1 $
  $ a_(33) = -1 - (1)(1) = -2 $
  $ b_3 = 2 - (1)(6) = -4 $

The updated matrix is:
$
  mat(delim: "[", augment: #(-1),
    1, -1, 1, 6;
    0, 1, -2, 4;
    0, 1, -2, -4
  )
$

== Forward Elimination ($k = 2$)
- Current pivot entry is $a_(22) = 1 != 0$. No row interchange is needed.
- Eliminate entry $a_(32)$ in row 3 using pivot row 2:
  $ m_(32) = frac(a_(32), a_(22)) = frac(1, 1) = 1 $
  $ R_3 <- R_3 - (1) R_2 $
  $ a_(33) = -2 - (1)(-2) = 0 $
  $ b_3 = -4 - (1)(4) = -8 $

The upper triangular form is:
$
  mat(delim: "[", augment: #(-1),
    1, -1, 1, 6;
    0, 1, -2, 4;
    0, 0, 0, -8
  )
$

== Conclusion
- Exactly one row interchange ($E_1 <-> E_2$) was required.
- The third equation simplifies to $0 x_1 + 0 x_2 + 0 x_3 = -8$, which is impossible. Therefore, the system is inconsistent and no solution exists.

= AI Contribution Statement

During the preparation of this work, the author(s) utilized Google Gemini solely to aid in typesetting, formatting of mathematical expressions in Typst, syntax verification, and proofreading.

Conversation Link: https://share.gemini.google/Es3lGDSaIlPk

#bibliography("../../resources/bibs/compendium/le1/1.1_book_exercise_burden_6_1_6a.bib", style: "apa")
#import "../../template.typ": project

#show: project.with(
  title: "Exercise 6.1 & 6.2 Remixed Problems",
  contributor: "Dean Robin Alcancia",
  date: "September 28, 2026",
)

= Problem

+ *Part 1 (Inspired by 6.1 6a):*
  Consider the system:
  $
    cases(
      x_2 - 2 x_3 = 4,
      x_1 - x_2 + x_3 = 6,
      x_1 - x_3 = b_3
    )
  $
  Find the value of $b_3$ that makes the system consistent, and determine whether this eliminates the need for the row interchange in Algorithm 6.1.

+ *Part 2 (Inspired by 6.2 1a):*
  Consider the system:
  $
    cases(
      x_1 - 5 x_2 + x_3 = 7,
      10 x_1 + 20 x_3 = 6,
      5 x_1 - x_3 = 4
    )
  $
  Apply Scaled Partial Pivoting at step $k = 1$ and identify which row is chosen as the pivot row. Compare its multipliers against Algorithm 6.1.

= Solution: Part 1

== Augmented form $[A | b]$:
$
  [A | b] = mat(delim: "[", augment: #(-1),
    0, 1, -2, 4;
    1, -1, 1, 6;
    1, 0, -1, b_3
  )
$

== Analyze Matrix
- Notice how the rows are connected:
  $ R_1 + R_2 = R_3 $
- For the augmented matrix to be consistent, the constants must satisfy the exact same linear combination:
  $ b_1 + b_2 = b_3 => 4 + 6 = b_3 => b_3 = 10 $

== Elimination Phase ($k = 1$)
- The initial pivot entry is $a_(11) = 0$. Since division by zero is not possible, a row interchange is still required regardless of the value of $b_3$.
- Swap $R_1 <-> R_2$:
  $
    mat(delim: "[", augment: #(-1),
      1, -1, 1, 6;
      0, 1, -2, 4;
      1, 0, -1, 10
    )
  $
- Multiplier:
  $ m_(31) = frac(a_(31), a_(11)) = frac(1, 1) = 1 $
- Row update:
  - $R_3 <- R_3 - 1 R_1$:
    $ a_(32) = 0 - 1(-1) = 1 $
    $ a_(33) = -1 - 1(1) = -2 $
    $ b_3 = 10 - 1(6) = 4 $

Updated matrix:
$
  mat(delim: "[", augment: #(-1),
    1, -1, 1, 6;
    0, 1, -2, 4;
    0, 1, -2, 4
  )
$

== Elimination Phase ($k = 2$)
- The pivot entry is $a_(22) = 1$. Since $a_(22) != 0$, a row interchange is not needed.
- Multiplier:
  $ m_(32) = frac(a_(32), a_(22)) = frac(1, 1) = 1 $
- Row update:
  - $R_3 <- R_3 - 1 R_2$:
    $ a_(33) = -2 - 1(-2) = 0 $
    $ b_3 = 4 - 1(4) = 0 $

Upper triangular matrix:
$
  mat(delim: "[", augment: #(-1),
    1, -1, 1, 6;
    0, 1, -2, 4;
    0, 0, 0, 0
  )
$

== Conclusion: Part 1
- Setting $b_3 = 10$ makes the system consistent, producing infinitely many solutions:
  $ x(t) = mat(delim: "[", 10; 4; 0) + t mat(delim: "[", 1; 2; 1), quad t in RR $
- Restoring consistency *does not* eliminate the need for the row interchange because pivot selection depends only on $A$, where $a_(1 1) = 0$ still forces $R_1 <-> R_2$.



= Solution: Part 2

== Augmented form $[A | b]$:
$
  [A | b] = mat(delim: "[", augment: #(-1),
     1, -5, 1, 7;
    10, 0, 20, 6;
     5, 0, -1, 4
  )
$

== Scale Factors and Initial Row-Order Vector
- Row maximums:
  - Row 1: $s_1 = max(|1|, |-5|, |1|) = 5$
  - Row 2: $s_2 = max(|10|, |0|, |20|) = 20$
  - Row 3: $s_3 = max(|5|, |0|, |-1|) = 5$
  - Scale vector: $s = [5, 20, 5]$
- Initial row-order vector:
  $ ell = [1, 2, 3] $

== Pivot Selection ($k = 1$)
- Evaluate relative ratios for column 1:
  - Row 1: $frac(|a_(1 1)|, s_1) = frac(1, 5) = 0.20$
  - Row 2: $frac(|a_(2 1)|, s_2) = frac(10, 20) = 0.50$
  - Row 3: $frac(|a_(3 1)|, s_3) = frac(5, 5) = 1.00$
- The maximum ratio is at Row 3. Swap $ell_1 <-> ell_3$:
  $ ell = [3, 2, 1] $

== Multiplier Comparison
- Multipliers with Scaled Partial Pivoting (Pivot row = Row 3):
  $ m_(11) = frac(a_(11), a_(31)) = frac(1, 5) = 0.20, quad m_(21) = frac(a_(21), a_(31)) = frac(10, 5) = 2.00 $
- Multipliers from Algorithm 6.1 (Pivot row = Row 1):
  $ m_(21) = frac(10, 1) = 10, quad m_(31) = frac(5, 1) = 5 $

== Conclusion: Part 2
- Scaled Partial Pivoting selects *Row 3* as the pivot row ($ell = [3, 2, 1]$).
- Algorithm 6.1's choice of Row 1 yields large multipliers ($10$ and $5$) because $a_(11) = 1$ is the weakest relative entry ($0.20$ vs $1.00$), making it more prone to round-off errors in later eliminations.

= AI Contribution Statement

During the preparation of this work, the author(s) utilized Google Gemini solely to aid in typesetting, formatting of mathematical expressions in Typst, syntax verification, and proofreading.

Conversation Link: https://share.gemini.google/Es3lGDSaIlPk

#bibliography("../../resources/bibs/compendium/le1/1.1_remix_burden_pivoting_comparison.bib", style: "apa")
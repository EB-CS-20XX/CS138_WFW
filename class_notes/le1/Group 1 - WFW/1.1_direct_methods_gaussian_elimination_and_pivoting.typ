#import "../../template.typ": project

#show: project.with(
  title: "1.1 Direct Methods: Gaussian Elimination and Pivoting",
  contributor: "Dean Robin Alcancia",
  date: "September 23, 2026",
)

= Direct Methods: Gaussian Elimination @ruaya2026direct[Slides 23-26]

Elementary row operations preserve the solution space:
1. Swapping two rows ($R_i <-> R_j$).
2. Multiplying a row by a non-zero scalar ($R_i <- c R_i$).
3. Adding a multiple of one row to another ($R_i <- R_i + c R_j$).

== Naive Gaussian Elimination Algorithm
Transforms $A x = b$ into an upper triangular system $U x = c$:

1. *Elimination Phase (Forward):* \
  $ 
    mat(delim: "[", augment: #(-1),
      a_11, a_12, dots, a_(1k), dots, a_(1j), dots, a_(1n), b_1;
      a_21, a_22, dots, a_(2k), dots, a_(2j), dots, a_(2n), b_2;
      dots.v, dots.v, , dots.v, , dots.v, , dots.v, dots.v;
      0, 0, dots, a_("kk"), dots, a_("kj"), dots, a_("kn"), b_k;
      dots.v, dots.v, , dots.v, , dots.v, , dots.v, dots.v;
      0, 0, dots, a_("ik"), dots, a_("ij"), dots, a_("in"), b_i;
      dots.v, dots.v, , dots.v, , dots.v, , dots.v, dots.v;
      0, 0, dots, a_("nk"), dots, a_("nj"), dots, a_("nn"), b_n;
  )
  $
   For pivot row $k = 1, dots, n-1$: \
   For target row $i = k+1, dots, n$:
   $ gamma = frac(a_(i k), a_(k k)) $
   $ a_(i j) <- a_(i j) - gamma a_(k j), quad j = k, dots, n $
   $ b_i <- b_i - gamma b_k $

2. *Back Substitution Phase:*
   $ x_n = frac(b_n, a_(n n)) $
   $ x_k = frac(1, a_(k k)) [b_k - sum_(j=k+1)^n a_(k j) x_j], quad k = n-1, n-2, dots, 1 $

=== Example: Naive Gaussian Elimination
Solve the following $3 times 3$ system:
$
  cases(
    2x_1 + x_2 - x_3 = 8,
    -3x_1 - x_2 + 2x_3 = -11,
    -2x_1 + x_2 + 2x_3 = -3
  )
$

*Step 1: Augmented Matrix Setup*
$
  [A | b] = mat(delim: "[", augment: #(-1),
    2, 1, -1, 8;
   -3, -1, 2, -11;
   -2, 1, 2, -3
  )
$

*Step 2: Forward Elimination ($k=1$)*
- Pivot $a_(1 1) = 2$.
- Row 2 elimination ($i=2$): multiplier $gamma_(2 1) = frac(-3, 2) = -1.5$.
  $ R_2 <- R_2 - (-1.5) R_1 $
  $ a_(2 2) = -1 - (-1.5)(1) = 0.5 $
  $ a_(2 3) = 2 - (-1.5)(-1) = 0.5 $
  $ b_2 = -11 - (-1.5)(8) = 1 $
- Row 3 elimination ($i=3$): multiplier $gamma_(3 1) = frac(-2, 2) = -1$.
  $ R_3 <- R_3 - (-1) R_1 $
  $ a_(3 2) = 1 - (-1)(1) = 2 $
  $ a_(3 3) = 2 - (-1)(-1) = 1 $
  $ b_3 = -3 - (-1)(8) = 5 $

Matrix after step 1:
$
  mat(delim: "[", augment: #(-1),
    2,1, -1, 8;
    0, 0.5, 0.5, 1;
    0, 2, 1, 5
  )
$

*Step 3: Forward Elimination ($k=2$)*
- Pivot $a_(2 2) = 0.5$.
- Row 3 elimination ($i=3$): multiplier $gamma_(3 2) = frac(2, 0.5) = 4$.
  $ R_3 <- R_3 - 4 R_2 $
  $ a_(3 3) = 1 - (4)(0.5) = -1 $
  $ b_3 = 5 - (4)(1) = 1 $

Upper-triangular system:
$
  mat(delim: "[", augment: #(-1),
    2, 1, -1, 8;
    0, 0.5, 0.5, 1;
    0, 0, -1, 1
  )
$

*Step 4: Backward Substitution*
$ x_3 = frac(1, -1) = -1 $
$ x_2 = frac(1 - (0.5)(-1), 0.5) = frac(1.5, 0.5) = 3 $
$ x_1 = frac(8 - (1)(3) - (-1)(-1), 2) = frac(8 - 3 - 1, 2) = 2 $

Solution vector: $x = mat(delim: "[", 2; 3; -1)$.

== Pivoting Strategies

=== Partial Pivoting @ruaya2026direct[Slides 27-28]
- Search the current column below, including the diagonal to find the maximum entry:
    $ |a_(i_p, k)| = max_(k <= i <= n) |a_(i, k)| $
- Swap row $k$ with row $i_p$. No variable reordering needed.

==== Example:
Consider solving the system below using 3-digit rounding arithmetic:
$
  mat(delim: "[", augment: #(-1),
    0.0002, 3, 9;
    2, 1, 7
  )
$
Solution: $x_1 approx 2.0001$, $x_2 approx 2.9999$

*1. Without Pivoting (Naive Elimination):*
- *Use $a_(1 1) = 0.0002$ as the pivot. Compute multiplier:*
  $ gamma = frac(2, 0.0002) = 10000 = 1.00 times 10^4 $
- *Row 2 update:*
  $ a_(2 2) = 1 - (1.00 times 10^4)(3) = 1 - 30000 = -29999 approx -3.00 times 10^4 $
  $ b_2 = 7 - (1.00 times 10^4)(9) = 7 - 90000 = -89993 approx -9.00 times 10^4 $
- *Back substitution:*
  $ x_2 = frac(-9.00 times 10^4, -3.00 times 10^4) = 3.00 $
  $ x_1 = frac(9 - 3(3.00), 0.0002) = frac(0, 0.0002) = 0 $
  $ x_1 = 0 "is incorrect (true value is "approx 2.00) $

*2. With Partial Pivoting:*
- *Compare column 1 candidates:* $|a_(2 1)| = 2 > |a_(1 1)| = 0.0002$.
- *Swap rows ($R_1 <-> R_2$):*
  $
    mat(delim: "[", augment: #(-1),
      2,      1, 7;
      0.0002, 3, 9
    )
  $
- *The elimination multiplier is now bounded* ($|gamma| <= 1$):
  $ gamma = frac(0.0002, 2) = 0.0001 = 1.00 times 10^(-4) $
- *Row 2 update:*
  $ a_(2 2) = 3 - (1.00 times 10^(-4))(1) = 2.9999 approx 3.00 $
  $ b_2 = 9 - (1.00 times 10^(-4))(7) = 8.9993 approx 9.00 $
- *Back substitution:*
  $ x_2 = frac(9.00, 3.00) = 3.00 $
  $ x_1 = frac(7 - 1(3.00), 2) = frac(4.00, 2) = 2.00 $

With partial pivoting, we get $x = mat(delim: "[", 2.00; 3.00)$.

=== Full Pivoting @ruaya2026direct[Slide 29-31]
- Search the entire remaining active submatrix:
  $ |a_(r, c)| = max_(k <= i, j <= n) |a_(i, j)| $
- Then swap row $k$ with row $r$, and swap column $k$ with column $c$.
- It is the most numerically stable, but very expensive in resources and requires permuting elements of the solution vector.

=== Scaled Partial Pivoting @ruaya2026direct[Slide 32-34]
- Simulates full pivoting without actual column exchanges and without physically copying large row vectors in memory.

- *Compute scale factors (row maximums):*
   $ s_i = max_(1 <= j <= n) |a_(i j)|, quad i = 1, dots, n $
- *Initialize the row-order vector $ell$:*
   $ ell = [1, 2, dots, n] $
- *At pivot column $k$ (for $k = 1, dots, n-1$):*
   - *Choose $j$ that maximizes:*
     $ frac(|a_(ell_j, k)|, s_(ell_j)) = max_(k <= i <= n) frac(|a_(ell_i, k)|, s_(ell_i)) $
   - *Swap $ell_j$ and $ell_k$ in the row-order vector $ell$.*
   - *For $i = k+1, dots, n$, compute:*
     $ m_(i k) = frac(a_(ell_i, k), a_(ell_k, k)) $
   - *Update rows:*
     $ R_(ell_i) <- R_(ell_i) - m_(i k) R_(ell_k) quad "for" k+1 <= i <= n $
- *Back Substitution with Row-Order Vector $ell$:*
   $ x_n = frac(b_(ell_n), a_(ell_n, n)) $
   $ x_k = frac(1, a_(ell_k, k)) [b_(ell_k) - sum_(j=k+1)^n a_(ell_k, j) x_j], quad k = n-1, dots, 1 $

==== Example: Scaled Partial Pivoting
$
  mat(delim: "[", augment: #(-1),
    2, 10, 100, 112;
    1, 1, 1, 3;
    3, 1, 2, 6
  )
$

- *Scale Vector and Initial Row-Order Vector*
  - *Compute row maximums:*
    - Row 1: $s_1 = max(|2|, |10|, |100|) = 100$
    - Row 2: $s_2 = max(|1|, |1|, |1|) = 1$
    - Row 3: $s_3 = max(|3|, |1|, |2|) = 3$
    - Scale vector: $s = [100, 1, 3]$
  - Initial row-order vector: $ell = [1, 2, 3]$

- *Pivot Selection and Elimination ($k=1$)*
  - At column $k = 1$, choose $j$ that maximizes $frac(|a_(ell_i, 1)|, s_(ell_i))$ for $1 <= i <= 3$: \
    $i = 1 (ell_1 = 1): frac(|a_(1 1)|, s_1) = frac(2, 100) = 0.02$ \
    $i = 2 (ell_2 = 2): frac(|a_(2 1)|, s_2) = frac(1, 1) = 1.0$ \
    $i = 3 (ell_3 = 3): frac(|a_(3 1)|, s_3) = frac(3, 3) = 1.0$ \

  The maximum is $1.0$ at $j = 2$ (row 2). Swap $ell_2$ and $ell_1$ in the row-order vector $ell$:
  $ ell = [2, 1, 3] $
- For $i = 2, 3$, compute multipliers and update rows using pivot row $ell_1 = 2$:
  - For $i = 2 (ell_2 = 1)$:
    $ m_(2 1) = frac(a_(ell_2, 1), a_(ell_1, 1)) = frac(a_(1 1), a_(2 1)) = frac(2, 1) = 2 $
    $ R_1 <- R_1 - 2 R_2 $
    $ a_(1 2) <- 10 - 2(1) = 8, quad a_(1 3) <- 100 - 2(1) = 98, quad b_1 <- 112 - 2(3) = 106 $
  - For $i = 3 (ell_3 = 3)$:
    $ m_(3 1) = frac(a_(ell_3, 1), a_(ell_1, 1)) = frac(a_(3 1), a_(2 1)) = frac(3, 1) = 3 $
    $ R_3 <- R_3 - 3 R_2 $
    $ a_(3 2) <- 1 - 3(1) = -2, quad a_(3 3) <- 2 - 3(1) = -1, quad b_3 <- 6 - 3(3) = -3 $

- *Pivot Selection and Elimination ($k=2$)*
  - At column $k = 2$, choose $j$ that maximizes $frac(|a_(ell_i, 2)|, s_(ell_i))$ for $2 <= i <= 3$: \
  - $i = 2 (ell_2 = 1): frac(|a_(1 2)|, s_1) = frac(8, 100) = 0.08$ \
  - $i = 3 (ell_3 = 3): frac(|a_(3 2)|, s_3) = frac(|-2|, 3) approx 0.667$ \

  The maximum is at $j = 3$ (row 3). Swap $ell_3$ and $ell_2$ in the row-order vector $ell$:
  $ ell = [2, 3, 1] $
  - For $i = 3$, compute multiplier and update row using pivot row $ell_2 = 3$:
    $ m_(3 2) = frac(a_(ell_3, 2), a_(ell_2, 2)) = frac(a_(1 2), a_(3 2)) = frac(8, -2) = -4 $
    $ R_1 <- R_1 - (-4) R_3 $
    $ a_(1 3) <- 98 - (-4)(-1) = 94, quad b_1 <- 106 - (-4)(-3) = 94 $

- *Back Substitution with $ell = [2, 3, 1]$*
  - For $x_3$ (from row $ell_3 = 1$):
  $ x_3 = frac(b_(ell_3), a_(ell_3, 3)) = frac(b_1, a_(1 3)) = frac(94, 94) = 1 $
  - For $x_2$ (from row $ell_2 = 3$):
  $ x_2 = frac(b_(ell_2) - a_(ell_2, 3) x_3, a_(ell_2, 2)) = frac(-3 - (-1)(1), -2) = 1 $
  - For $x_1$ (from row $ell_1 = 2$):
  $ x_1 = frac(b_(ell_1) - a_(ell_1, 2) x_2 - a_(ell_1, 3) x_3, a_(ell_1, 1)) = frac(3 - 1(1) - 1(1), 1) = 1 $

Final solution: $x = mat(delim: "[", 1; 1; 1)$.

== Triangular Solvers
- *Forward Substitution ($L y = b$):* For lower triangular matrices. Solve top-to-bottom starting with $y_1$:
  $ y_1 = frac(b_1, l_(1 1)), quad y_i = frac(1, l_(i i)) [b_i - sum_(j=1)^(i-1) l_(i j) y_j] $
- *Backward Substitution ($U x = y$):* For upper triangular matrices. Solve bottom-to-top starting with $x_n$:
  $ x_n = frac(y_n, u_(n n)), quad x_i = frac(1, u_(i i)) [y_i - sum_(j=i+1)^n u_(i j) x_j] $


= AI Contribution Statement

During the preparation of this work, the author(s) utilized Google Gemini solely to aid in typesetting, formatting of mathematical expressions in Typst, syntax verification, and proofreading.

Conversation Link: https://share.gemini.google/wnNm5T5XTrzU

#bibliography("../../resources/bibs/class_notes/le1/1.1_direct_methods_gaussian_elimination_and_pivoting.bib", style: "apa")


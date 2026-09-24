#import "../../template.typ": project

#show: project.with(
  title: "1.3 Shifted Inverse Power Method",
  contributor: "Ryan Dela Cruz",
  date: "September 24, 2026",
)

#show bibliography: set heading(numbering: none)
#set math.mat(delim: "[")

= Motivation

When solving for eigenvalues iteratively, the standard methods have clear limitations:

- *Power Method:* Only converges to the dominant eigenvalue $|lambda_1|$ (largest magnitude).
- *Inverse Power Method:* Runs power iteration on $A^(-1)$, finding the eigenvalue closest to zero ($|lambda_n|$).

Neither method can find an interior or arbitrary eigenvalue between the two extremes. If we need a specific eigenvalue near some target value $sigma$, we need a way to make that target eigenvalue dominant.

The *Shifted Inverse Power Method* does this by subtracting a shift $sigma I$ before inverting @burden2010numerical. Whichever eigenvalue is closest to $sigma$ gets amplified the most, making it the dominant eigenvalue of the shifted inverse matrix @ruaya2026eigenvalues.

#table(
  columns: (1.5fr, 1.2fr, 2fr, 2fr),
  align: (left, center, left, left),
  table.header(
    [*Method*], [*Finds*], [*Iteration Step*], [*Dominant Factor*]
  ),
  [Power Method],
  [Largest $|lambda|$],
  [$x^((k+1)) = (A x^((k))) / norm(A x^((k)))$],
  [$|lambda_1|$],

  [Inverse Power],
  [Smallest $|lambda|$],
  [$A z^((k+1)) = x^((k))$],
  [$1 / |lambda_n|$],

  [*Shifted Inverse Power*],
  [*$lambda$ closest to $sigma$*],
  [$(A - sigma I) z^((k+1)) = x^((k))$],
  [*$1 / |lambda - sigma|$*]
)

= Derivation & Intuition

== Shifted Inverse Eigenvalues

Start with the standard eigenvalue equation for $A in RR^(n times n)$:
$ A v = lambda v $

Subtract $sigma v$ from both sides:
$ (A - sigma I) v = (lambda - sigma) v $

Assuming $sigma != lambda$, multiply both sides by $(A - sigma I)^(-1)$ and divide by $(lambda - sigma)$:
$ (A - sigma I)^(-1) v = 1 / (lambda - sigma) v $

This tells us two important things:
1. The eigenvectors $v$ of $(A - sigma I)^(-1)$ are identical to the eigenvectors of $A$.
2. The eigenvalues are shifted and inverted:
   $ mu = 1 / (lambda - sigma) $

== Why Near Shifts Converge Quickly

As our shift $sigma$ approaches a specific eigenvalue $lambda_j$:
- $|lambda_j - sigma| arrow.r 0$, meaning $|mu_j| = 1 / |lambda_j - sigma| arrow.r infinity$.
- For all other eigenvalues $lambda_k != lambda_j$, $|mu_k|$ stays finite and comparatively small.

*Example:* \
Let $A$ have eigenvalues $1, 2, 3$.
- Standard power method targets $3$.
- Inverse power method targets $1$.
- To find $lambda = 2$, set $sigma = 1.9$:
  $ mu_1 = 1 / (1 - 1.9) = -1.11 \
    mu_2 = 1 / (2 - 1.9) = 10 \
    mu_3 = 1 / (3 - 1.9) approx 0.91 $

$mu_2 = 10$ is much larger than the others. The convergence ratio is $|mu_1 / mu_2| = 1.11 / 10 approx 0.11$, so the iteration converges in just a few steps.

= Algorithm

== LU Solving over Inversion

Computing $(A - sigma I)^(-1)$ directly is slow and prone to roundoff error. Instead of explicitly inverting, we rewrite the step $z^((k+1)) = (A - sigma I)^(-1) x^((k))$ as a linear system:
$ (A - sigma I) z^((k+1)) = x^((k)) $

Since $sigma$ is fixed:
1. Factor $A - sigma I = L U$ *once* at the start.
2. At each iteration, solve:
   - $L y = x^((k))$ (forward solve)
   - $U z^((k+1)) = y$ (back solve)

This keeps each iteration at $cal(O)(n^2)$ instead of $cal(O)(n^3)$.

== Steps

Given matrix $A$, shift $sigma$, initial vector $x^((0))$ with $norm(x^((0)))_infinity = 1$, and tolerance $epsilon$:

1. Factor $(A - sigma I) = L U$.
2. For $k = 0, 1, 2, dots$:
   - Solve $L y = x^((k))$
   - Solve $U z^((k+1)) = y$
   - Let $c_(k+1)$ be the entry in $z^((k+1))$ with largest magnitude: $|c_(k+1)| = norm(z^((k+1)))_infinity$
   - Normalize: $x^((k+1)) = z^((k+1)) / c_(k+1)$
   - Recover eigenvalue: $lambda^((k+1)) = sigma + 1 / c_(k+1)$
   - Stop when $norm(x^((k+1)) - x^((k)))_infinity < epsilon$ or $|lambda^((k+1)) - lambda^((k))| < epsilon$.

= Lecture Examples

Consider the matrix from class:
$ A = mat(1, 3, 8; 3, 1, 3; 8, 3, 1) $

True eigenvalues: $lambda_1 = 5 + sqrt(34) approx 10.83$, $lambda_2 = 5 - sqrt(34) approx -0.83$, and $lambda_3 = -7$.

== Example 1: Finding $lambda = -7$ using $sigma = -6$

We want to find $lambda = -7$, so choose $sigma = -6$.

Shifted matrix:
$ A + 6 I = mat(7, 3, 8; 3, 7, 3; 8, 3, 7) $

LU decomposition via Gaussian elimination:
$ L = mat(1, 0, 0; 3/7, 1, 0; 8/7, -3/40, 1), quad U = mat(7, 3, 8; 0, 40/7, -3/7; 0, 0, -87/40) $

*Iteration 1:* \
Start with $x^((0)) = mat(-1; 0; 1)$.

- Solve $L y = x^((0))$:
  $ y = mat(-1; 3/7; 609/280) $

- Solve $U z^((1)) = y$:
  $ z^((1)) = mat(1; 0; -1) $

- Scaling and recovery:
  $ c_1 = -1 quad (norm(z^((1)))_infinity = 1) \
    x^((1)) = mat(1; 0; -1) \
    lambda^((1)) = -6 + 1 / (-1) = -7 $

Because $sigma = -6$ is already very close to $-7$ and $x^((0))$ aligned well with the eigenspace, it found the exact eigenvalue and eigenvector in a single iteration.

== Example 2: Finding $lambda_2 approx -0.83095$ using $sigma = -1$

To target the interior eigenvalue $lambda_2 = 5 - sqrt(34)$, choose shift $sigma = -1$:
$ A + I = mat(2, 3, 8; 3, 2, 3; 8, 3, 2) $

Factoring $A + I = L U$ and iterating:

#table(
  columns: (1fr, 2fr, 2fr, 2fr),
  align: (center, center, center, center),
  table.header([*Iteration $k$*], [*$norm(z^((k)))_infinity$*], [*$lambda^((k))$*], [*Absolute Error*]),
  [1], [6.000000], [$-0.833333$], [$2.38 times 10^(-3)$],
  [2], [5.913043], [$-0.830882$], [$6.99 times 10^(-5)$],
  [3], [$136/23 approx 5.913043$], [$-113/136 approx -0.830882$], [$6.99 times 10^(-5)$]
)

Within 3 iterations, the estimate already matches $5 - sqrt(34)$ to 4 decimal places.

= Practical Notes

- *Near-Singularity is a Benefit:* \
  When $sigma approx lambda$, $A - sigma I$ is close to singular, which usually means high condition numbers and rounding errors. In this method, however, those numerical errors get amplified directly along the eigenvector of $lambda$, which actually accelerates convergence.
- *Shift Guessing:* \
  The closer $sigma$ is to the eigenvalue, the faster it converges. Initial guesses are usually taken from the diagonal entries or estimated bounds like Gershgorin discs.
- *Flop Count:* \
  $L U$ factorization takes $2/3 n^3$ once. Each iteration only costs $2 n^2$ for the forward and back solves, making total cost roughly $2/3 n^3 + 2 m n^2$ for $m$ iterations.

#bibliography("../../resources/bibs/class_notes/le1/1.3_shifted_inverse_power_method.bib", style: "apa")
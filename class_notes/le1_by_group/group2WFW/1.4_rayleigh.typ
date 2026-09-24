#import "../../../template.typ": project

#show: project.with(
  title: "1.4 Rayleigh Quotient and Rayleigh Inverse Power",
  contributor: "Nathan Kim Chua",
  date: "September 24, 2026",
)

= Rayleigh Quotient

Given a symmetric square matrix $A$ and a non-zero vector $x$, the Rayleigh Quotient is defined as:

$
  R(A, x) = frac(x^T A x, x^T x)
$

where $x^T x != 0$ since $x != 0$.

The Rayleigh Quotient provides a scalar approximation of an eigenvalue of $A$ given an eigenvector approximation $x$.

== Eigenvalue Interpretation

If $x$ is an exact eigenvector of $A$ corresponding to eigenvalue $lambda$, then:

$
  A x = lambda x
$

Substituting into the Rayleigh Quotient:

$
  R(A, x)
  &= frac(x^T A x, x^T x) \
  &= frac(x^T (lambda x), x^T x) \
  &= frac(lambda x^T x, x^T x) \
  &= lambda
$

Therefore, if $x$ is an exact eigenvector, the Rayleigh Quotient returns its corresponding eigenvalue exactly. If $x$ is a "good enough" approximation of an eigenvector, the Rayleigh Quotient achieves cubic convergence toward the eigenvalue.

= Rayleigh Inverse Power Method

The Rayleigh Inverse Power Method combines the shifted inverse power iteration with the Rayleigh Quotient. By dynamically updating the shift parameter $sigma$ using the Rayleigh Quotient at each step, the method achieves extremely fast convergence toward a target eigenvalue.

== Algorithm Steps

1. *Initialization (Iteration 0):*
   Choose an initial non-zero vector $x^{(0)}$ and compute the initial eigenvalue estimate:
   $
     lambda^{(0)} = frac((x^{(0)})^T A x^{(0)}, (x^{(0)})^T x^{(0)})
   $

2. *Iterative Step:*
   For $k = 0, 1, 2, ...$:
   
   - Solve the system of linear equations using the current estimate $\ lambda^{(k)}$ as the shift:
     $
       (A - lambda^{(k)} I) w^{(k)} = x^{(k)}
     $
     
   - Normalize the resulting vector:
     $
       x^{(k+1)} = frac(w^{(k)}, ||w^{(k)}||_infinity)
     $
     
   - Update the eigenvalue approximation using the Rayleigh Quotient:
     $
       lambda^{(k+1)} = frac((x^{(k+1)})^T A x^{(k+1)}, (x^{(k+1)})^T x^{(k+1)})
     $

= Worked Example

Consider the matrix:
$
  A = mat(1, 2, 3; 1, 2, 1; 3, 2, 1)
$

We want to approximate its dominant eigenvalue $lambda_1 = 3 + sqrt(5) approx 5.236068$ using an initial guess vector $x^{(0)} = vec(1, 1, 1)^T$.

== Step 0: Initial Rayleigh Quotient

Compute $A x^{(0)}$:

$

  A x^{(0)} =
  mat(1, 2, 3; 1, 2, 1; 3, 2, 1)
  vec(1, 1, 1)
  = vec(6, 4, 6)

$

Compute the initial eigenvalue approximation $lambda^(0)$:

$

  lambda^(0)
  = frac(
    (x^(0))^T A x^(0),
    (x^(0))^T x^(0)
  )
  = frac(
    vec(1, 1, 1)^T vec(6, 4, 6),
    vec(1, 1, 1)^T vec(1, 1, 1)
  )
  = frac(16, 3)
  approx 5.333333

$

== Step 1: First Rayleigh Inverse Power Iteration

Solve the linear system

$(A - lambda^(0) I) w^(0) = x^(0)$

where $lambda^(0) = 16/3$:

$

  mat(
    -13/3, 2, 3;
    1, -10/3, 1;
    3, 2, -13/3
  )
  w^(0)
  = vec(1, 1, 1)

$

Solving the system gives:

$

  w^(0)
  = vec(-12, -15/2, -12)

$

Normalize using the infinity norm:

$

  ||w^(0)||_infinity = 12

$

Thus,

$

  x^(1)
  = frac(w^(0), ||w^(0)||_infinity)
  = vec(-1, -5/8, -1)

$

Compute $A x^(1)$:

$

  A x^(1)
  =
  mat(1, 2, 3; 1, 2, 1; 3, 2, 1)
  vec(-1, -5/8, -1)
  = vec(-21/4, -13/4, -21/4)

$

Compute the updated Rayleigh Quotient $lambda^(1)$:

$

  lambda^(1)
  = frac(
    (x^(1))^T A x^(1),
    (x^(1))^T x^(1)
  )

$

$

  = frac(
    vec(-1, -5/8, -1)^T
    vec(-21/4, -13/4, -21/4),
    vec(-1, -5/8, -1)^T
    vec(-1, -5/8, -1)
  )

$

$

  = frac(802, 153)
  approx 5.241830

$

Thus,

$

  lambda^(1) approx 5.241830

$

which is closer to the true dominant eigenvalue

$

  lambda_1 = 3 + sqrt(5) approx 5.236068.

$

The Rayleigh Inverse Power Method therefore gives a much more accurate approximation after just one iteration.
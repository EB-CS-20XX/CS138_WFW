#import "../../template.typ": project

#show: project.with(
  title: "1.0 Introduction to System of Linear Algebra Equations",
  contributor: "Dean Robin Alcancia",
  date: "September 23, 2026",
)

= Systems of Linear Algebraic Equations (SLEs) @burden2010numerical[p.362]

A general system of $n$ linear equations with $n$ unknowns is:
$
  cases(
    a_11 x_1 + a_12 x_2 + ... + a_(1n) x_n = b_1,
    a_21 x_1 + a_22 x_2 + ... + a_(2n) x_n = b_2,
    dots.v,
    a_(n 1) x_1 + a_(n 2) x_2 + ... + a_(n n) x_n = b_n
  )
$
In matrix form, this is expressed as $A x = b$, or using the augmented matrix $[A | b]$.

== Existence and Uniqueness of Solutions
- *Nonsingular matrix $A$*: Exactly one unique solution exists ($x = A^(-1) b$).
- *Singular matrix $A$*:
  - If $b in "span"(A)$: *Infinitely many solutions* (system is consistent).
  - If $b limits(cancel(in)) "span"(A)$: *No solution* (system is inconsistent).

= Sensitivity and Error Analysis

== Matrix Norms @burden2010numerical[p.432]
For $A in M_n (RR)$, the induced matrix norm is:
$ ||A|| = max_(x eq.not 0) frac(||A x||, ||x||) $

=== Properties of Norms
#set enum(numbering: "1.a)")
+ $||A|| > 0$ if $A != 0$
+ $||alpha A|| = |a| dot ||A|| forall alpha in RR$
+ $||A+B|| <= ||A||+||B||$
+ $||A B|| <= ||A|| dot ||B||$
+ $||A x|| <= ||A|| dot ||x|| forall x in RR^n$

- *1-norm (maximum absolute column sum):* $||A||_1 = max_j sum_(i=1)^n |a_(i j)|$
- *$oo$-norm (maximum absolute row sum):* $||A||_oo = max_i sum_(j=1)^n |a_(i j)|$
- *2-norm (maximum singular value)*: $||A||_2 = max_(||bold(x)||_2 = 1) ||A bold(x)||_2$

== Condition Number @burden2010numerical[p.470-473]
The condition number measures the sensitivity of the solution to perturbations in $A$ and $b$:
$ "cond"(A) equiv ||A|| ||A^(-1)||, quad 1 <= "cond"(A) <= oo $
- *Well-conditioned:* $"cond"(A) approx 1$ (small perturbations yield small changes in $x$).
- *Ill-conditioned:* $"cond"(A) >> 1$ (small errors or round-offs cause massive changes in $x$).
- *Singular:* $"cond"(A) = oo$.

== Residual Analysis @ruaya2026intro[Slide 18]
Given an approximate computed solution $hat(x)$:
- *True error:* $e = x - hat(x)$ ($x$ is mostly unknown).
- *Residual vector:* $r = b - A hat(x)$.
- *Relation:* $frac(||Delta x||, ||x||) <= "cond"(A) frac(||r||, ||A|| ||hat(x)||)$
  - If $A$ is well-conditioned, a small residual guarantees a small error.
  - If $A$ is ill-conditioned, $hat(x)$ can produce a tiny residual $r$ while still having large error $e$.

=== Note on Precision @ruaya2026intro[Slide 35]
If input data is stored to machine precision $epsilon_m$, the number of trustworthy decimal digits $d$ in the computed solution is:
$ d = |log_10 (epsilon_m)| - log_10 ("cond"(A)) $

=== Example: Norms and Condition Number
Consider the matrix:
$ A = mat(delim: "[", 1, 2; 1.001, 2) $
1. *Compute Matrix Norms:*
  - Maximum column sum ($1$-norm):
    $ ||A||_1 = max(|1| + |1.001|, |2| + |2|) = max(2.001, 4) = 4 $
  - Maximum row sum ($oo$-norm):
    $ ||A||_oo = max(|1| + |2|, |1.001| + |2|) = max(3, 3.001) = 3.001 $
2. *Compute Inverse:*
  $ det(A) = (1)(2) - (2)(1.001) = 2 - 2.002 = -0.002 $
  $ A^(-1) = frac(1, -0.002) mat(delim: "[", 2, -2; -1.001, 1) = mat(delim: "[", -1000, 1000; 500.5, -500) $
3. *Evaluate Condition Number ($oo$-norm):*
  $ ||A^(-1)||_oo = max(|-1000| + |1000|, |500.5| + |-500|) = max(2000, 1000.5) = 2000 $
  $ "cond"_oo (A) = ||A||_oo dot ||A^(-1)||_oo = (3.001)(2000) = 6002 $
  Because $"cond"_oo (A) approx 6 times 10^3 >> 1$, the system is ill-conditioned. A relative error in $b$ could be amplified by up to a factor of $6002$ in the solution $x$, causing a loss of  $log_10(6002) approx 3.78$ digits of precision.

= AI Contribution Statement

During the preparation of this work, the author(s) utilized Google Gemini solely to aid in typesetting, formatting of mathematical expressions in Typst, syntax verification, and proofreading.

Conversation Link: https://share.gemini.google/wnNm5T5XTrzU

#bibliography("../../resources/bibs/class_notes/le1/1.0_system_of_linear_algebra_equations.bib", style: "apa")
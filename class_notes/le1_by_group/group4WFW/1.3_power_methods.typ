#import "../../../template.typ": project

#show: project.with(
  title: "1.3 Power Method, Normalized Power Method, Inverse Power Method",
  contributor: "Enrico U. Baratang",
  date: "September 24, 2026",
)

#show bibliography: set heading(numbering: none)


= Real Eigenvalue Approximations of a Square Matrix
#align(right)[_*1.2. Eigenvalue Approximations of a Square Matrix*_]
== Motivation
Recall that the convergence of iterative methods discussed in Section 1.2 rely on the spectral radius of matrices being less than 1.

Recall further that the spectral radius of a matrix is defined as the magnitude of the largest eigenvalue of that matrix.

For these reasons it is a problem that there is no general formula for computing the eigenvalues for $n$x$n$ matrices when $n>= 5$.

And for these same reasons methods exist for finding/approximating eigenvalues and eigenvectors
== Eigenvalue Approximations: Power Method
=== Power Method:
Let us say we have an $n$x$n$ matrix $A$ with eigenvalues $lambda_1, lambda_2,..., lambda_n$. And let us assume that they are numbered in order of magnitude:

$|lambda_1|>= |lambda_2|>=...>= |lambda_n|$

Any vector, $x$, can be formed using only a linear combination of its eigenvectors. #cite(<ruaya2026eigen>)

$A x = lambda x$

$A x = c_1 lambda_1 v_1+ c_2 lambda_2 v_2 + ... + c_n lambda_n v_n$

Should we decide to repeatedly multiply both sides by $A$ until we reach $A^k$ we should find that

$A [A x] = lambda[c_1 lambda_1 v_1+ c_2 lambda_2 v_2 + ... + c_n lambda_n v_n]$

$A^2 x = c_1 lambda_1^2 v_1+ c_2 lambda_2^2 v_2 + ... + c_n lambda_n^2 v_n$

...

$A^k x = c_1 lambda_1^k v_1+ c_2 lambda_2^k v_2 + ... + c_n lambda_n^k v_n$

$A^k x = lambda_1^k (c_1  v_1+ c_2 (lambda_2 / lambda_1)^k v_2 + ... + c_n (lambda_n / lambda_1)^k v_n)$

If we assume that $|lambda_1|> |lambda_2|$ (STRICTLY GREATER THAN) then as $k → infinity, (lambda_i/lambda_1)^k → 0, forall i, 2<=i<=n$. This leaves us with

$A^k x = c_1 lambda_1^k v_1 $

Which means $A^k x$ approaches some multiple of the dominant eigenvector, $v_1$, as $k→infinity$. #cite(<tudelft>)

With this our iteration is as follows:

$x^(\(k+1\)) = A x^(\(k\)) = lambda_1 x^(\(k\))$

To solve for $lambda_1$ we can multiply $x^(\(k\)T)$ to both sides to get:

$x^(\(k\)T)x^(\(k+1\))= lambda_1 x^(\(k\)T)x^(\(k\)) $

$lambda_1 = (x^(\(k\)T)x^(\(k+1\)))/(x^(\(k\)T)x^(\(k\))) = (x^(\(k\)T)A x^(\(k\)))/(x^(\(k\)T)x^(\(k\)))$

Thus, we have found an approximation for $lambda_1$. Coincidentally, this formula follows the Rayleigh Quotient, which will be discussed further later on. #cite(<pages>)

=== Normalized Power Method

One issue with the Power method is the values of our approximation vector $x^(\(k\))$ as $k → infinity$. They will either approach $infinity$ or $0$, depending on the value of $lambda_1$ #cite(<tudelft>)

$limits(lim)_(k→infinity) ||A^k x|| = cases(infinity "if" lambda_1 > 1, 0 "if" lambda_1 < 1)$

Thus the solution is to normalize the vector after each iteration, giving us:

$x^(\(k+1\)) = (A x^(\(k\)))/(||A x^(\(k\))||_infinity)$

=== Inverse Power Method

But what if you do not want to find the eigenvalue with the largest magnitude? Given an invertible matrix $A$ with eigenvalues $lambda_1, lambda_2,..., lambda_n$, we find that the eigenvalues for $A^(-1)$ are $1/lambda_1, 1/lambda_2,..., 1/lambda_n$. #cite(<ruaya2026eigen>)

If we revisit the assumption that $|lambda_1|>= |lambda_2|>=...>= |lambda_n|$, then it follows that $|1/lambda_1|<= |1/lambda_2|<=...<= |1/lambda_n|$.

Thus, if $|lambda_(n-1)| > |lambda_n|$ (STRICTLY GREATER THAN), then applying the Power method to $A^(-1)$ will yield $1/lambda_n$, from which we can obtain $lambda_n$, the eigvenvalue of $A$ with the smallest magnitude.

#bibliography("/resources/bibs/class_notes/le1/1.3_power_methods.bib", style: "apa")
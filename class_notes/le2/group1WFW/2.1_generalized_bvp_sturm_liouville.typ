#import "../../../template.typ": project

#show: project.with(
  title: "2.1 Generalized BVP and Sturm–Liouville",
  contributor: "Dean Robin A. Alcancia",
  date: "October 28, 2026",
)

== Generalized Eigenvalue Problem

Same idea as $A bold(v) = lambda M bold(v)$ from Arc 1, except the "matrix" is now a differential operator and the "vector" is a function $y(x)$. @ruayavillar2026bvp[Slide 18]
#block(inset: 12pt, fill: rgb("f9f9f9"), radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  *Generalized Eigenvalue Problem*
  $ P_0 (x) y'' + P(x) y' + Q(x) y + lambda R(x) y = 0, quad x in [a, b] $
  $ B_1 (y) = alpha_1 y(a) + beta_1 y'(a) = 0, quad B_2 (y) = alpha_2 y(b) + beta_2 y'(b) = 0 $
]

- *Goal:* find the $lambda$ (eigenvalues) that give a nontrivial $y$ (eigenfunctions). The trivial solution $y = 0$ always works.
- *Separated BCs:* each BC involves one endpoint only. $beta = 0$ gives Dirichlet and $alpha = 0$ gives Neumann.

*Example (Homework):* 

Solve $x^2 y'' + x y' + lambda y = 0$, $y(1) = y(2) = 0$. @ruayavillar2026bvp[Slide 19]
+ Substitute $x = e^t$. This gives $Y'' + lambda Y = 0$ with $Y(0) = Y(ln 2) = 0$, a Dirichlet problem with $L = ln 2$.
+ Check each case of $lambda$:
  - $lambda < 0$: let $mu = sqrt(-lambda)$, so $Y = C_1 e^(-mu t) + C_2 e^(mu t)$. From $Y(0) = 0$ we get $C_1 = -C_2$, so $Y(L) = 2 C_2 sinh(mu L)$. Since $sinh(mu L) != 0$, $C_2 = 0$, which gives nothing.
  - $lambda = 0$: $Y = C_1 + C_2 t$. Both BCs force $C_1 = C_2 = 0$, so again nothing.
  - $lambda > 0$: $Y = C_1 sin(sqrt(lambda) t) + C_2 cos(sqrt(lambda) t)$. $Y(0) = 0$ gives $C_2 = 0$, and $Y(L) = C_1 sin(sqrt(lambda) L) = 0$ with $C_1 != 0$ means $sqrt(lambda) L = n pi$.
+ Result:
$ lambda_n = ((n pi)/(ln 2))^2, quad y_n (x) = C_n sin((n pi)/(ln 2) ln x) $

== Sturm–Liouville Problems

=== Motivation

In Arc 1, $⟨bold(u), A bold(v)⟩ = ⟨A bold(u), bold(v)⟩$ if and only if $A^T = A$. Symmetric matrices have real eigenvalues and orthogonal eigenvectors. We want the same for differential operators. @ruayavillar2026bvp[Slide 20]

From the homework, $u_n (t) = sin((n pi t)/L)$ are orthogonal on $[0, L]$. Changing back with $t = ln x$, $dif t = 1/x dif x$:
$ ⟨y_m, y_n⟩_r = integral_1^2 y_m (x) y_n (x) dot 1/x dif x = 0 quad (m != n) $
The eigenfunctions are still orthogonal, but now with a *weight* $r(x) = 1/x$.

=== Sturm–Liouville Form

#block(inset: 12pt, fill: rgb("f9f9f9"), radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  *SL Form* @ruayavillar2026bvp[Slide 22]
  $ cal(L) y = (p(x) y')' + q(x) y = -lambda r(x) y $
  - It's *regular* if $p, p', q, r$ are continuous on $[a, b]$, $p > 0$ and $r > 0$ there, and the BCs are separated.
  - This is basically $A bold(v) = lambda M bold(v)$: $cal(L)$ acts like $A$ and $r(x)$ acts like $M$.
  - $cal(L)$ is self-adjoint ($cal(L)^* = cal(L)$), meaning the operator can be moved to the other function in the inner product.
]

*Converting $P_0 y'' + P y' + Q y + lambda R y = 0$:*
$ mu = exp(integral P/P_0 dif x), quad p = mu, quad q = (mu Q)/P_0, quad r = (mu R)/P_0 $

*Example (Homework).* $x^2 y'' + x y' + lambda y = 0$. Then $mu = x$, so $(x y')' = -lambda (1/x) y$. This gives $p = x$, $q = 0$, $r = 1/x$, the weight found above.

*Example (Laguerre).* $x y'' + (1 - x) y' + k y = 0$.
- $mu = exp(integral (1/x - 1) dif x) = x e^(-x)$.
- SL form: $(x e^(-x) y')' + k e^(-x) y = 0$.
- So $p = x e^(-x)$, $q = 0$, $r = e^(-x)$, $lambda = k$.
The point of $mu$ is that $mu' = mu dot (1-x)/x$. Checking: $d/(dif x)[x e^(-x)] = e^(-x) - x e^(-x) = (1 - x) e^(-x)$, which is exactly the coefficient of $y'$ after multiplying through. So the first two terms combine into $(x e^(-x) y')'$ @ruayavillar2026bvp[Slide 23].
=== Sturm–Liouville Theorem

#block(inset: 12pt, fill: rgb("f9f9f9"), radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  *SL Theorem* @ruayavillar2026bvp[Slide 24]
  
  For a regular SL problem with separated BCs:
  + *Symmetric (self-adjoint):* $integral_a^b u cal(L) v dif x = integral_a^b v cal(L) u dif x$. The boundary terms vanish because of the BCs.
  + *Real, distinct eigenvalues:* $lambda_0 < lambda_1 < dots$, with $lambda_n -> +infinity$.
  + *Orthogonal eigenfunctions:* orthogonal under the weighted inner product $⟨u, v⟩_r = integral_a^b u r v dif x$, $r > 0$.
  + *Expansion:* piecewise smooth functions have a generalized Fourier series in the eigenfunctions (Arc 3).
  + *Rayleigh quotient:* the eigenvalues satisfy a Rayleigh quotient, below.
]

The Rayleigh quotient here is the function version of $(bold(x)^T A bold(x))/(bold(x)^T bold(x))$:
$ lambda = (-[p phi phi']_a^b + integral_a^b (p (phi')^2 - q phi^2) dif x)/(integral_a^b r phi^2 dif x) $
With Dirichlet BCs, $p > 0$, and $q <= 0$, this gives $lambda >= 0$. That is why only $lambda > 0$ worked in the homework.

=== Special SODEs

Their solutions can be studied with SL theory.

#table(
  columns: 5,
  align: center + horizon,
  table.header([*Name*], [*Equation*], [$p$], [$r$], [$lambda$]),
  [Legendre], [$(1 - x^2) y'' - 2x y' + k(k+1) y = 0$], [$1 - x^2$], [$1$], [$k(k+1)$],
  [Chebyshev], [$(1 - x^2) y'' - x y' + k^2 y = 0$], [$sqrt(1 - x^2)$], [$1/sqrt(1 - x^2)$], [$k^2$],
  [Hermite], [$y'' - 2x y' + 2k y = 0$], [$e^(-x^2)$], [$e^(-x^2)$], [$2k$],
  [Laguerre], [$x y'' + (1 - x) y' + k y = 0$], [$x e^(-x)$], [$e^(-x)$], [$k$],
  [Bessel], [$x^2 y'' + x y' + (x^2 - k^2) y = 0$], [$x$], [$x$], [$1$],
)

All rows have $q = 0$ except Bessel, which has $q = -k^2/x$.

== Power Series Solution

Use this when the coefficients are not constant and no closed form exists. The ODE becomes a recurrence for the coefficients.

=== Reindexing

$ y = sum_(n=0)^infinity a_n x^n, quad y' = sum_(n=0)^infinity (n+1) a_(n+1) x^n, quad y'' = sum_(n=0)^infinity (n+2)(n+1) a_(n+2) x^n $

Shift every sum to $x^n$, then set each coefficient to $0$.

*Useful Maclaurin series:*
- $sin x = x - x^3/(3!) + x^5/(5!) - dots$
- $cos x = 1 - x^2/(2!) + x^4/(4!) - dots$
- $e^x = 1 + x + x^2/(2!) + dots$

*Example:* 

$ y'' + c^2 y = 0, c != 0 $

*Recurrence:*
$ sum_(n=0)^infinity [(n+2)(n+1) a_(n+2) + c^2 a_n] x^n = 0 quad ==> quad a_(n+2) = -(c^2 a_n)/((n+2)(n+1)) $

Writing out the first few terms makes the pattern obvious:
$ a_2 = -(c^2)/(2 dot 1) a_0, quad a_4 = -(c^2)/(4 dot 3) a_2 = (c^4)/(4!) a_0, quad a_3 = -(c^2)/(3 dot 2) a_1, quad a_5 = (c^4)/(5!) a_1 $
The even terms only depend on $a_0$ and the odd terms only on $a_1$ @ruayavillar2026bvp[Slides 28-29].

*Result:*
$ y = a_0 cos(c x) + a_1 sin(c x)/c $
This matches the characteristic-equation answer $r = plus.minus c i$.

=== Eigenvalues as Zeros of a Series

Add the BCs $y(0) = y(L) = 0$.
- $y(0) = 0$ gives $a_0 = 0$.
- $y(L) = 0$ then requires
$ y(L; c) = a_1 sum_(k=0)^infinity ((-1)^k c^(2k) L^(2k+1))/((2k+1)!) = 0 $
The eigenvalues are the zeros $c_n$ of this series. With no closed form, truncate and root-find (bisection or Newton, CS 136).

Keeping only four terms @ruayavillar2026bvp[Slide 31]
$ L - (c^2 L^3)/(3!) + (c^4 L^5)/(5!) - (c^6 L^7)/(7!) = 0 quad ==> quad c_1 approx 3.08/L $
The exact value is $pi/L approx 3.14/L$.

For higher eigenvalues, more terms are needed. The four-term version has only one real root. With more terms, $c_2 approx 6.2725/L$, compared with the exact $2 pi/L$.

== AI Contribution

_Used Claude (Anthropic Claude Opus 5.5) for drafting lecture slides in Typst. I provided the W6 slides, outline of the topics, and edited to be more understandable. Claude suggested wording and outline changes, and fixed Typst compiler errors. I checked and edited the final content._ \

_Prompts and outputs:_ #link("https://drive.google.com/file/d/1NayZujpaidAIAAan-bWKj7J1OVSaX6SD/view?usp=sharing")

#bibliography("../../../resources/bibs/class_notes/le2/2.1_generalized_bvp_sturm_liouville.bib", style: "apa", full: true) 
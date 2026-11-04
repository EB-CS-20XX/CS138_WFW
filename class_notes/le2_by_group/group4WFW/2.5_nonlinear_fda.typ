#import "../../../template.typ": indiv

#show: indiv.with(
  title: "2.5 BVP: Nonlinear Finite Difference Method",
  contributor: "Ryan Luis Dela Cruz",
  date: "November 4, 2026",
)

#set math.vec(delim: "[")
#show bibliography: set heading(numbering: none)


= Motivation

In W8, the finite difference method (FDA) turned a *linear* BVP $y'' = -P(x) y' - Q(x) y + R(x)$ into a tridiagonal system of linear equations, solved once. For a *nonlinear* BVP
$ y'' = f(x, y, y'), quad y(a) = alpha, quad y(b) = beta, $
the same discretization gives a tridiagonal system of *nonlinear* equations $bold(F)(bold(y)) = bold(0)$ @ruayavillar2026nonlinear. We solve it with Newton's method for SNLE from the Prerequisite section: build the Jacobian, then repeatedly solve $J_F Delta bold(y) = -bold(F)$.

#table(
  columns: (1.3fr, 2fr, 2fr),
  align: (left, left, left),
  stroke: 0.5pt + luma(150),
  table.header([*Aspect*], [*Linear FDA (W8)*], [*Nonlinear FDA*]),
  [ODE], [$y'' = -P y' - Q y + R$], [$y'' = f(x, y, y')$],
  [System], [$A bold(y) = bold(b)$ (tridiagonal)], [$bold(F)(bold(y)) = bold(0)$ (tridiagonal $J_F$)],
  [Solve], [One linear solve], [One linear solve *per Newton iteration*],
  [Initial guess], [Not needed], [Needed (line through the BCs)],
)

= Steps

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150), width: 100%)[
  *Nonlinear FDA* @ruayavillar2026nonlinear
  #line(length: 100%)
  + *Grid.* Choose $n$ interior points: $h = (b - a)/(n + 1)$, $x_i = a + i h$ for $i = 0, dots, n + 1$. The unknowns are $y_1, dots, y_n$; the boundary values $y_0 = alpha$ and $y_(n+1) = beta$ are known.
  + *Discretize.* Replace $y'$ and $y''$ with central differences:
    $ y'(x_i) approx (y_(i+1) - y_(i-1))/(2h), quad y''(x_i) approx (y_(i+1) - 2 y_i + y_(i-1))/(h^2) $
  + *Root-finding form.* For $i = 1, dots, n$:
    $ F_i (bold(y)) = (y_(i+1) - 2 y_i + y_(i-1))/(h^2) - f(x_i, y_i, (y_(i+1) - y_(i-1))/(2h)) = 0 $
    Substitute $y_0 = alpha$ into $F_1$ and $y_(n+1) = beta$ into $F_n$.
  + *Jacobian.* Left to right: partials with respect to $y_1, dots, y_n$. Top to bottom: $F_1, dots, F_n$. It is tridiagonal.
  + *Initial guess.* Take the line through the BCs, $y_"line" (x) = alpha + (beta - alpha) (x - a)/(b - a)$, at the interior points.
  + *Iterate.* Solve $J_F (bold(y)^((k))) Delta bold(y)^((k)) = -bold(F)(bold(y)^((k)))$, update $bold(y)^((k+1)) = bold(y)^((k)) + Delta bold(y)^((k))$, and stop when $norm(Delta bold(y)^((k))) < epsilon_"tol"$.
]

= Building the Jacobian

Each $F_i$ only involves $y_(i-1)$, $y_i$, $y_(i+1)$, so row $i$ has at most three nonzero entries. Writing $z_i = (y_(i+1) - y_(i-1))/(2h)$ for the approximate $y'(x_i)$, the chain rule gives general formulas @burden2010numerical:
$ (partial F_i)/(partial y_(i-1)) = 1/(h^2) + 1/(2h) f_(y') (x_i, y_i, z_i), quad
  (partial F_i)/(partial y_i) = -2/(h^2) - f_y (x_i, y_i, z_i), quad
  (partial F_i)/(partial y_(i+1)) = 1/(h^2) - 1/(2h) f_(y') (x_i, y_i, z_i) $

Here $f_y$ and $f_(y')$ are the partial derivatives of $f(x, y, y')$ with respect to its second and third arguments. So for any $f$, you only need to differentiate $f$ twice, then plug in.

- Row 1 has no $partial F_1 \/ partial y_0$ entry, and row $n$ has no $partial F_n \/ partial y_(n+1)$ entry, since $y_0$ and $y_(n+1)$ are constants. The values $alpha$ and $beta$ still appear *inside* the entries of those rows.
- If $f$ is linear, $J_F$ is constant and $bold(F)$ is affine, so Newton converges in *one* step. This recovers the W8 linear FDA.

= Lecture Example

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150), width: 100%)[
  Solve the nonlinear BVP using 3 interior points @ruayavillar2026nonlinear:
  $ y'' = e^y y', quad y(0) = alpha = -ln 2, quad y(1) = beta = 0 $
  The true solution is $y = -ln(2 - x)$.
]

== Setup

With $n = 3$: $h = 0.25$, interior points $x_1, x_2, x_3 = 0.25, 0.5, 0.75$, and $1/h^2 = 16$, $1/(2h) = 2$. Substituting into the central differences:
$ F_i = 16 (y_(i+1) - 2 y_i + y_(i-1)) - 2 e^(y_i) (y_(i+1) - y_(i-1)) = 0, quad i = 1, 2, 3 $

Writing out each equation and substituting the BCs:
$ F_1 (y_1, y_2) &= 16 (y_2 - 2 y_1 + alpha) - 2 e^(y_1) (y_2 - alpha) \
  F_2 (y_1, y_2, y_3) &= 16 (y_3 - 2 y_2 + y_1) - 2 e^(y_2) (y_3 - y_1) \
  F_3 (y_2, y_3) &= 16 (beta - 2 y_3 + y_2) - 2 e^(y_3) (beta - y_2) $

== Jacobian

Here $f = e^y y'$, so $f_y = e^y y'$ and $f_(y') = e^y$. With the general formulas (or by differentiating $F_i$ directly):
$ (partial F_i)/(partial y_(i-1)) = 16 + 2 e^(y_i), quad
  (partial F_i)/(partial y_i) = -32 - 2 e^(y_i) (y_(i+1) - y_(i-1)), quad
  (partial F_i)/(partial y_(i+1)) = 16 - 2 e^(y_i) $

$ J_F (bold(y)) = mat(
  -32 - 2 e^(y_1) (y_2 - alpha), 16 - 2 e^(y_1), 0;
  16 + 2 e^(y_2), -32 - 2 e^(y_2) (y_3 - y_1), 16 - 2 e^(y_2);
  0, 16 + 2 e^(y_3), -32 - 2 e^(y_3) (beta - y_2)
) $

== Initial Guess

The line through $(0, -ln 2)$ and $(1, 0)$ is $y_"line" (x) = -ln 2 (1 - x)$:
$ bold(y)^((0)) = vec(y_"line" (0.25), y_"line" (0.50), y_"line" (0.75)) = vec(-0.75 ln 2, -0.50 ln 2, -0.25 ln 2) = vec(-0.51986039, -0.34657359, -0.17328680) $

== Iteration 1

*Evaluate $bold(F)$.* Since the guess is a line (including the BCs), every second difference $y_(i+1) - 2 y_i + y_(i-1)$ is $0$, and every $y_(i+1) - y_(i-1) = 0.5 ln 2$. So $F_i = -2 e^(y_i) (0.5 ln 2) = -ln 2 dot e^(y_i)$:
$ e^(bold(y)^((0))) = vec(2^(-0.75), 2^(-0.5), 2^(-0.25)) = vec(0.59460356, 0.70710678, 0.84089642), quad
  -bold(F)(bold(y)^((0))) = vec(0.41214778, 0.49012907, 0.58286498) $

*Evaluate $J_F$.* The diagonal is $-32 - ln 2 dot e^(y_i)$ for the same reason:
$ J_F (bold(y)^((0))) = mat(
  -32.41214778, 14.81079288, 0;
  17.41421356, -32.49012907, 14.58578644;
  0, 17.68179283, -32.58286498
) $

*Solve $J_F Delta bold(y) = -bold(F)$ by Gaussian elimination.*
- $R_2 <- R_2 - (-0.53727429) R_1$: new diagonal $-24.53267090$, new right side $0.71156548$.
- $R_3 <- R_3 - (-0.72074471) R_2$: new diagonal $-22.07023653$, new right side $1.09572203$.
- Back substitution:
  $ Delta y_3 &= 1.09572203 \/ (-22.07023653) = -0.04964705 \
    Delta y_2 &= (0.71156548 - 14.58578644 Delta y_3) \/ (-24.53267090) = -0.05852223 \
    Delta y_1 &= (0.41214778 - 14.81079288 Delta y_2) \/ (-32.41214778) = -0.03945769 $

*Update.*
$ bold(y)^((1)) = bold(y)^((0)) + Delta bold(y)^((0)) = vec(-0.55931807, -0.40509582, -0.22293384) $
Compared with $y = -ln(2 - x)$, the error is $(2.98 times 10^(-4), 3.69 times 10^(-4), 2.10 times 10^(-4))$ @ruayavillar2026nonlinear.

== Further Iterations

#table(
  columns: (0.6fr, 1.3fr, 1.3fr, 1.3fr, 1.2fr, 1.2fr),
  align: center,
  stroke: 0.5pt + luma(150),
  table.header([*$k$*], [*$y_1^((k))$*], [*$y_2^((k))$*], [*$y_3^((k))$*], [*$norm(Delta bold(y)^((k)))_infinity$*], [*Max error*]),
  [0], [$-0.51986039$], [$-0.34657359$], [$-0.17328680$], [$5.85 times 10^(-2)$], [$5.89 times 10^(-2)$],
  [1], [$-0.55931807$], [$-0.40509582$], [$-0.22293384$], [$1.33 times 10^(-4)$], [$3.69 times 10^(-4)$],
  [2], [$-0.55945085$], [$-0.40518219$], [$-0.22285603$], [$5.00 times 10^(-10)$], [$2.88 times 10^(-4)$],
  [3], [$-0.55945085$], [$-0.40518219$], [$-0.22285603$], [--], [$2.88 times 10^(-4)$],
  [True], [$-0.55961579$], [$-0.40546511$], [$-0.22314355$], [], [],
)

Newton converges quadratically (step sizes $10^(-2) -> 10^(-4) -> 10^(-10)$), but the error against the true solution *stops* at about $2.9 times 10^(-4)$. Newton solves the *discretized* system exactly; the remaining error is the $cal(O)(h^2)$ discretization error of the central differences. To reduce it, use more interior points (smaller $h$), not more Newton iterations.


= Practical Notes
- *Unknowns are interior only:* \
  $n$ interior points give an $n times n$ system. Don't include $y_0$ or $y_(n+1)$ as unknowns.
- *Boundary rows:* \
  Substitute $alpha$ and $beta$ before differentiating. They drop out of the Jacobian as variables but stay inside entries, e.g., $-32 - 2 e^(y_1) (y_2 - alpha)$.
- *Precompute constants:* \
  Write $1/h^2$ and $1/(2h)$ as numbers first ($16$ and $2$ for $h = 0.25$). Most arithmetic slips happen here.
- *Line guess shortcut:* \
  At $bold(y)^((0)) = y_"line"$, the second-difference term is $0$, so $F_i (bold(y)^((0))) = -f(x_i, y_i, "slope")$, where slope $= (beta - alpha)/(b - a)$.
- *Tridiagonal solve:* \
  Eliminate only the subdiagonal (one multiplier per row), then back substitute. This costs $cal(O)(n)$ per iteration instead of $cal(O)(n^3)$.
- *Newton error vs. discretization error:* \
  $norm(Delta bold(y))$ measures Newton convergence. Error against the true solution is limited by $h$. In the example, one Newton step already reaches the discretization error level.
- *Signs:* \
  The right-hand side is $-bold(F)$ and the update adds $Delta bold(y)$. With $F_i$ defined as "second difference $- f$", the diagonal of $J_F$ is negative.

#bibliography("../../../resources/bibs/class_notes/le2/WFW_Arc2.bib", style: "apa")

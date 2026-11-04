
#set page(paper: "a4", margin: 1in)
#set text(size: 11pt)
#set par(justify: true)
#set heading(numbering: none)

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Linearization of NLSODE and Newton's Method for NLS
  ]
]

= 1. Nonlinear Systems of Equations (NLS)

A nonlinear system of equations consists of two or more equations involving multiple unknowns, where at least one equation contains a nonlinear expression. Unlike a general linear system, a nonlinear system may have multiple roots, a single root, or no real root #cite(<Driscoll2018>) #cite(<Burden2011>).

For $n$ equations in $n$ unknowns, it can be expressed as:

$
  f_1(x_1, x_2, dots, x_n) = 0 \
  f_2(x_1, x_2, dots, x_n) = 0 \
  dots.v \
  f_n(x_1, x_2, dots, x_n) = 0
$

In vector form:

$
  F: RR^n arrow.r RR^n, quad F(bold(x)) = bold(0).
$

where:

$
  bold(x) = mat(
    x_1;
    x_2;
    dots.v;
    x_n
  ),
  quad
  F(bold(x)) = mat(
    f_1(bold(x));
    f_2(bold(x));
    dots.v;
    f_n(bold(x))
  ).
$

$bold(x)$ is the unknown variable and $F(bold(x))$ is the residual vector. Each component of the residual vector indicates how far the corresponding equation is from being satisfied.

The objective is to find a solution vector $bold(x)^*$ such that

$
  F(bold(x)^*) = bold(0).
$

== 1.1 Recall: Linear Systems

A linear system has the familiar form

$
  A bold(x) = bold(b),
$

with coefficient matrix $A$ and right-hand-side vector $bold(b)$. It can also be written in zero form:

$
  A bold(x) - bold(b) = bold(0)
$

$
  F(bold(x)) = A bold(x) - bold(b) = bold(0).
$

Both linear and nonlinear problems can be formulated as $F(bold(x)) = bold(0)$. For the linear problem $F(bold(x)) = A bold(x) - bold(b)$, its Jacobian is the constant matrix $A$. For a nonlinear $F$, the Jacobian generally depends on the current point $bold(x)$ #cite(<Driscoll2018>).

== 1.2 Linearization

Nonlinear systems are generally more difficult to solve directly than linear systems. Newton's Method addresses this by approximating the nonlinear system with a linear system near the current estimate. The resulting linear system is solved to obtain a correction. Repeating this process may bring the approximation closer to a root #cite(<Driscoll2018>) #cite(<Burden2011>).


= 2. Scalar Newton's Method

Begin with a single differentiable equation

$
  f(x) = 0
$

Newton's Method starts with an estimate $x^(k)$ and uses the tangent-line approximation at that point to predict an improved root. The next estimate is the point where the tangent line crosses the horizontal axis #cite(<Burden2011>).

== 2.1 First-Order Taylor Approximation

Let $Delta x^(k)$ denote the correction from the current estimate to the next estimate. The first-order Taylor expansion is

$
  f(x^(k) + Delta x^(k))
  approx
  f(x^(k)) + f'(x^(k)) Delta x^(k).
$

To find a correction whose linear prediction is zero, set the right-hand side to zero:

$
  0 approx f(x^(k)) + f'(x^(k)) Delta x^(k),
$

$
  f'(x^(k)) Delta x^(k) = -f(x^(k)).
$

The function value is the current scalar residual, and the derivative measures the local sensitivity of that residual to a change in $x$ #cite(<Burden2011>).

== 2.2 Newton Correction

If $f'(x^(k)) != 0$, solving for the correction gives

$
  Delta x^(k)
  = -frac(f(x^(k)), f'(x^(k))).
$

The negative sign makes the predicted residual change oppose the current residual. If the derivative is zero, this formula is undefined. If it is very small, the correction may be excessively large #cite(<Burden2011>).

== 2.3 Newton Update

Add the correction to the current estimate:

$
  x^(k+1) = x^(k) + Delta x^(k)
$

$
  x^(k+1)
  = x^(k) - frac(f(x^(k)), f'(x^(k))).
$

Since the tangent line is only a local approximation, the updated estimate may not satisfy the original nonlinear equation exactly. The process is repeated until the desired accuracy is achieved. Under suitable conditions, Newton's Method converges rapidly #cite(<Burden2011>).


= 3. Jacobian Matrix

For a nonlinear system involving multiple functions and variables, a single derivative is insufficient to describe how each function changes with respect to every variable. The Jacobian matrix organizes these first-order partial derivatives and serves as the multivariable counterpart of the ordinary derivative #cite(<Driscoll2018>) #cite(<SorianoLecture>).

Consider a differentiable vector-valued function

$
  F: RR^n arrow.r RR^m
$

where $n$ is the number of input variables and $m$ is the number of output functions.

The Jacobian matrix is defined as:

$
  J_F(bold(x)) = mat(
    frac(partial f_1, partial x_1), dots.h, frac(partial f_1, partial x_n);
    dots.v, dots.down, dots.v;
    frac(partial f_m, partial x_1), dots.h, frac(partial f_m, partial x_n)
  )
$

where $i = 1, dots, m$ and $j = 1, dots, n$.

== 3.1 Dimensions

The Jacobian has dimensions $m times n$, where:

- Each row corresponds to one output function $f_i$.
- Each column corresponds to one input variable $x_j$.

For $n$ equations in $n$ unknowns, the Jacobian is $n times n$. A nonsingular Jacobian permits a unique Newton correction in the associated linear system #cite(<Driscoll2018>) #cite(<SorianoLecture>).

Near a fixed point $bold(x)_0$, the Jacobian provides a local linear approximation:

$
  F(bold(x)_0 + Delta bold(x)) - F(bold(x)_0)
  approx J_F(bold(x)_0) Delta bold(x).
$

$J_F(bold(x)_0) Delta bold(x)$ approximates the change in the output caused by a small displacement $Delta bold(x)$. This approximation becomes more accurate as $Delta bold(x)$ approaches zero #cite(<Driscoll2018>) #cite(<SorianoLecture>).

*Example:*

Consider the two nonlinear functions

$
  f_1(x,y) = x^2 + y - 3,
$

$
  f_2(x,y) = x + y^2 - 3.
$

The Jacobian is:

$
  J_F(x,y) = mat(
    frac(partial f_1, partial x), frac(partial f_1, partial y);
    frac(partial f_2, partial x), frac(partial f_2, partial y)
  ).
$

Compute the four first partial derivatives:

$
  frac(partial f_1, partial x) = 2x
$

$
  frac(partial f_1, partial y) = 1
$

$
  frac(partial f_2, partial x) = 1
$

$
  frac(partial f_2, partial y) = 2y
$

Therefore,

$
  J_F(x,y) = mat(
    2x, 1;
    1, 2y
  ).
$


= 4. Multivariable Linearization

Newton's Method for nonlinear systems extends the scalar Newton formula to vector-valued functions. Instead of using a single derivative, the method uses the Jacobian matrix to construct a linear approximation near the current estimate #cite(<Driscoll2018>) #cite(<SorianoLecture>).

== 4.1 Multivariable First-Order Taylor Approximation

Let $bold(x)^(k)$ be the current estimate and let $Delta bold(x)^(k) = bold(x)^(k+1) - bold(x)^(k)$.

For each component equation $f_i$, first-order Taylor expansion gives

$
  f_i(bold(x)^(k) + Delta bold(x)^(k))
  approx
  f_i(bold(x)^(k))
  + sum_(j=1)^n
  frac(partial f_i, partial x_j)(bold(x)^(k))
  Delta x_j^(k).
$

Combining the approximations in vector form:

$
  F(bold(x)^(k) + Delta bold(x)^(k))
  approx
  F(bold(x)^(k))
  + J_F(bold(x)^(k)) Delta bold(x)^(k).
$

$F(bold(x)^(k))$ is the current residual while $J_F(bold(x)^(k)) Delta bold(x)^(k)$ predicts the change in that residual. The formula omits higher-order terms and is therefore a local approximation #cite(<Driscoll2018>) #cite(<SorianoLecture>).

== 4.2 Newton Correction

Set the linear approximation equal to zero:

$
  F(bold(x)^(k))
  + J_F(bold(x)^(k)) Delta bold(x)^(k)
  = bold(0).
$

$
  J_F(bold(x)^(k)) Delta bold(x)^(k)
  = -F(bold(x)^(k)).
$

This system asks for a change in the unknowns whose predicted residual change cancels the current residual.

When the Jacobian is invertible, the correction can be expressed as

$
  Delta bold(x)^(k)
  = -(J_F(bold(x)^(k)))^(-1) F(bold(x)^(k)).
$

In practice, the correction is obtained by solving the linear system rather than explicitly computing the Jacobian inverse #cite(<Driscoll2018>).

== 4.3 Newton Update

After solving for the correction, the next approximation is obtained using

$
  bold(x)^(k+1)
  = bold(x)^(k) + Delta bold(x)^(k).
$

When the Jacobian is invertible:

$
  bold(x)^(k+1)
  = bold(x)^(k)
  - (J_F(bold(x)^(k)))^(-1) F(bold(x)^(k)).
$

The residual and Jacobian are evaluated again at the updated approximation, and the process continues until the desired stopping condition is satisfied #cite(<Driscoll2018>) #cite(<SorianoLecture>).


= References

#bibliography(
  "../../../resources/bibs/class_notes/le2/2.5_linearization_nlsode_newton_nls.bib",
  style: "apa",
  title: none,
)


= AI Contribution

*(Janelle M. Mendoza)*

I used ChatGPT for concept clarification and section checking. I also asked for assistance with Typst formatting, including references and citations. The notes were reviewed against the referenced learning materials.
[Link:"https://chatgpt.com/share/6aeb2af4-3a14-83ec-bab0-9adfbd74745a"]



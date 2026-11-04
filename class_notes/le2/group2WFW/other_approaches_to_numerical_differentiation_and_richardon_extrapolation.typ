#import "../../../template.typ": project

#show: project.with(
  title: "Other Approaches to Numerical Differentiation and Richardson Extrapolation",
  contributor: "James Jacob Emnace",
  date: "November 3, 2026",
)

= Other Approaches

== Increasing the derivatives

In the previous approach, Taylor series is used, in which the objective is to solve for $f'(x)$. A different way approach to this is increasing the derivatives, where in the Taylor series instead solves for $f^((p)) (x)$.

With this in approach in mind, look back at the Forward and Backward Taylor series:

$
f(x+h) = f(x) + h f'(x) + (h^2)/2 f'' (x) + (h^3)/6 f''' (x) + (h^4)/24 f'''' (xi _+)
$

$
f(x-h) = f(x) - h f'(x) + (h^2)/2 f'' (x) - (h^3)/6 f''' (x) + (h^4)/24 f'''' (xi _-)
$

Then add those two together:

$
f(x+h) + f(x-h) = 2f (x) + h^2 f'' (x) + (h^4)/24 [f^((4))xi_+ + f^((4))(xi_-]
$

Where in $(h^4)/24 [f^((4))xi_+ + f^((4))(xi_-]$ is the error term. Rearrange the equation to solve for $f'' (x)$:

$
f'' (x) = (f(x-h)-2f(x)+f(x+h))/h^2 - h^2/24[f^((4))xi_+ + f^((4))(xi_-]
$

Where $h^2/24[f^((4))xi_+ + f^((4))(xi_-]$ is the $cal(O)(h^2)$ error, scaled down due to being divided by $h^2$

== Increasing the order

The higher the order approximation and/or derivative, the more nodes needed

For example, instead of the standard 2-point forward difference, add a third node to derive a *3-point forward difference* for $f'(x)$

$
f'(x) = (-3f(x) + 4f(x+h) - f(x + 2h))/2h + cal(O)(h^2)
$

Where in $cal(O)(h)$ error turns into $cal(O)(h^2)$ error

Deriving like this using the Taylor series is the "hard way". A better solution is to interpolate, then differentiate
- $((x plus.minus 2),f(x plus.minus h), (x plus.minus 2h), f(x plus.minus 2h)), ...$ (even points)
- $(s_1,f(s_1)),(s_2,f(s_2)), ... $ (uneven points)

== Stencil Creation

This better solution with even or uneven points is *Stencil Creation*

Let $s = [s_1, s_2, ..., s_n]$ be the set of $n$ stencil points $(s_k,f(s_k))_k$ that is accurate to the $p^(t h)$ derivative. Thus,

$
f^((p)) approx sum_(k=1) ^n a_k f(s_k), #h(0.6cm)sum_(k=1) ^n a_k (s_k - x)^j = cases(
  p!comma j = p comma, 0 comma j eq.not p comma
)
#h(0.3cm)j = 0, 1, ..., n-1
$

$
mat((s_1)^0, (s_2)^0, ..., (s_(n-1))^0, (s_n)^0;(s_1)^0, (s_2)^0, ...,  (s_(n-1))^0, (s_n)^0;
dots.v, dots.v, dots.down, dots.v, dots.v;
(s_1)^0, (s_2)^0, ..., (s_(n-1))^0, (s_n)^0;
(s_1)^0, (s_2)^0, ..., (s_(n-1))^0, (s_n)^0 
,delim: "[")
mat(a_1;a_2;dots.v;a_(n-1);a_n,delim: "[") = 
underbrace(p!,"Power rule") #h(0.15cm) mat(0_(0eq.not p);0_(1 eq.not p); dots.v;1_(p=p);0_(n-1eq.not p),delim: "[")
$

Where in the left-most matrix is just a transposed Vandermonde matrix, which is ill-conditioned and the right-most matrix is the p-th derivative

Note that this is interpolation using *monomial basis functions*, also called *monomial interpolation*

Example: Approximate $f'' (x)$ using forward nodes $x_0 = x, x_1 = x+h, x_2 = x+2h,$ where $f_0 = f(x), f_h = f(x+h), f_(2h) = f(x +2h)$ 

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  stroke: (x, y) => (
    right: if x == 0 { 0.5pt } else { none },
    bottom: if y == 0 { 0.5pt } else { none },
  ),
  [offset], [$f[dot]$], [$f[dot, dot]$], [$f[dot, dot, dot]$],
  [$0$],[$f_0$],[],[],
  [],[],[$(f_h - f_0)/h$],[],
  [$h$],[$f_h$],[],[$(f_(2h)-2f_h+f_0)/(2h^2)$],
  [],[],[$(f_(2h)-f_h)/h$],[],
  [$2h$],[$f_(2h)$],[],[]
)

- $p_2(X) = underbrace(f_0,a_0) + (X-x) (f_h-f_0)/h + (X - x)(X - x - h)(f_(2h)-2f_h+f_0)/(2h^2)$
- For fixed $x$: $p'_(#h(0.1cm)2)(X) = (f_h - f_0)/h + (2(X-x)-h)/(2h^2)(f_(2h)-2f_h+f_0)$
- $p''_(#h(0.1cm)2)(X)=(f_(2h)-2f_h+f_0)/(h^2)$

$arrow.double f''(x) approx p''_(#h(0.1cm)2)(X=x)=(f(x)-2f(x+h)+f(x+2h))/(h^2) + cal(O)(h^1)$

The general formula for Stencil Creation is

$
f^((p))(x) approx 1/(h^p) sum_(k=1)^n a_k f(x+s_k h) + cal(O)(h^m)
$

For *Forward stencil*, the nodes are the point x and it points to the right. $s = (0,1,2,dots.c,n-1)$. The amount of nodes can be calculated using $n = m + p$.

For *Backward stencil*, it instead points to the left $s = (-(n-1),dots.c,-2,-1,0)$ and the amount of nodes can be calculated the same way. Reverse forward coefficients and flip signs only for odd derivatives.

For *Central stencil*, there are two cases:
- if $p$ is even, it includes 0 and it points outwards left and right. $s = (-beta, dots.c,-1,0,1,dots.c,beta)$ where $beta = (m+p-2)/2$ and $n = 2 beta + 1$
- If $p$ is odd, 0 is not included. $s = (-beta, dots.c,-1,1,dots.c,beta)$ where $beta = (m+p-1)/2$  and $n = 2 beta$

For example: Central $cal(O)(h^2)$ approximation of $f'(x) [p=1, m=2]$

$beta = (2+1-1)/2=1, #h(0.55cm) n=2, #h(0.55cm) s=(-1,1) arrow.double f'(x) approx (f(x+h)-f(x-h))/(2h)$

== Coefficients

For *Central difference*, increasing $p$ from odd to even creates a new non-zero point for $f(x)$, and when it is from even to odd it adds two new side points (setting $0 dot f(x)$). Order accuracy always increases by 2 by adding two new points on the sides 

#table(
  columns: (auto, auto, auto, auto,auto, auto,auto, auto,auto, auto,auto, auto, auto),
  align: center,

  [Derivative], [Accuracy],
  [$-5$], [$-4$], [$-3$], [$-2$], [$-1$], [$0$], [$1$], [$2$], [$3$], [$4$], [$5$],

  table.cell(rowspan: 4)[$1$],
  [$2$], [], [], [], [], [$-1/2$], [$0$], [$1/2$], [], [], [], [],
  [$4$], [], [], [], [$1/12$], [$-2/3$], [$0$], [$2/3$], [$-1/12$], [], [], [],
  [$6$], [], [], [$-1/60$], [$3/20$], [$-3/4$], [$0$], [$3/4$], [$-3/20$], [$1/60$], [], [],
  [$8$], [], [$1/280$], [$-4/105$], [$1/5$], [$-4/5$], [$0$], [$4/5$], [$-1/5$], [$4/105$], [$-1/280$], [],

  table.cell(rowspan: 4)[$2$],
  [$2$], [], [], [], [], [$1$], [$-2$], [$1$], [], [], [], [],
  [$4$], [], [], [], [$-1/12$], [$4/3$], [$-5/2$], [$4/3$], [$-1/12$], [], [], [],
  [$6$], [], [], [$1/90$], [$-3/20$], [$3/2$], [$-49/18$], [$3/2$], [$-3/20$], [$1/90$], [], [],
  [$8$], [], [$-1/560$], [$8/315$], [$-1/5$], [$8/5$], [$-205/72$], [$8/5$], [$-1/5$], [$8/315$], [$-1/560$], [],

  table.cell(rowspan: 3)[$3$],
  [$2$], [], [], [], [$-1/2$], [$1$], [$0$], [$-1$], [$1/2$], [], [], [],
  [$4$], [], [], [$1/8$], [$-1$], [$13/8$], [$0$], [$-13/8$], [$1$], [$-1/8$], [], [],
  [$6$], [], [$-7/240$], [$3/10$], [$-169/120$], [$61/30$], [$0$], [$-61/30$], [$169/120$], [$-3/10$], [$7/240$], [],
)

For *Backward difference*, it is the same coefficients as the forward coefficient, but the stencil is the other way around. Note that when the derivative is odd, coefficients have flipped signs

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
  align: center,

  [Derivative], [Accuracy],
  [$-8$], [$-7$], [$-6$], [$-5$], [$-4$], [$-3$], [$-2$], [$-1$], [$0$],

  table.cell(rowspan: 3)[$1$],
  [$1$], [], [], [], [], [], [], [], [$-1$], [$1$],
  [$2$], [], [], [], [], [], [], [$1/2$], [$-2$], [$3/2$],
  [$3$], [], [], [], [], [], [$-1/3$], [$3/2$], [$-3$], [$11/6$],

  table.cell(rowspan: 2)[$2$],
  [$1$], [], [], [], [], [], [], [$1$], [$-2$], [$1$],
  [$2$], [], [], [], [], [], [$-1$], [$4$], [$-5$], [$2$],

  table.cell(rowspan: 2)[$3$],
  [$1$], [], [], [], [], [], [$-1$], [$3$], [$-3$], [$1$],
  [$2$], [], [], [], [], [$3/2$], [$-7$], [$12$], [$-9$], [$5/2$],

  table.cell(rowspan: 2)[$4$],
  [$1$], [], [], [], [], [$1$], [$-4$], [$6$], [$-4$], [$1$],
  [$2$], [], [], [], [$-2$], [$11$], [$-24$], [$26$], [$-14$], [$3$],
)

For *Forward difference*, increasing p or m increases the number of points by p and/or m. Note that signs alternate between consecutive terms

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
  align: center,

  [Derivative], [Accuracy],
  [$0$], [$1$], [$2$], [$3$], [$4$], [$5$], [$6$], [$7$], [$8$],

  table.cell(rowspan: 6)[$1$],
  [$1$], [$-1$], [$1$], [], [], [], [], [], [], [],
  [$2$], [$-3/2$], [$2$], [$-1/2$], [], [], [], [], [], [],
  [$3$], [$-11/6$], [$3$], [$-3/2$], [$1/3$], [], [], [], [], [],
  [$4$], [$-25/12$], [$4$], [$-3$], [$4/3$], [$-1/4$], [], [], [], [],
  [$5$], [$-137/60$], [$5$], [$-5$], [$10/3$], [$-5/4$], [$1/5$], [], [], [],
  [$6$], [$-49/20$], [$6$], [$-15/2$], [$20/3$], [$-15/4$], [$6/5$], [$-1/6$], [], [],

  table.cell(rowspan: 6)[$2$],
  [$1$], [$1$], [$-2$], [$1$], [], [], [], [], [], [],
  [$2$], [$2$], [$-5$], [$4$], [$-1$], [], [], [], [], [],
  [$3$], [$35/12$], [$-26/3$], [$19/2$], [$-14/3$], [$11/12$], [], [], [], [],
  [$4$], [$15/4$], [$-77/6$], [$107/6$], [$-13$], [$61/12$], [$-5/6$], [], [], [],
  [$5$], [$203/45$], [$-87/5$], [$117/4$], [$-254/9$], [$33/2$], [$-27/5$], [$137/180$], [], [],
  [$6$], [$469/90$], [$-223/10$], [$879/20$], [$-949/18$], [$41$], [$-201/10$], [$1019/180$], [$-7/10$], [],

  table.cell(rowspan: 6)[$3$],
  [$1$], [$-1$], [$3$], [$-3$], [$1$], [], [], [], [], [],
  [$2$], [$-5/2$], [$9$], [$-12$], [$7$], [$-3/2$], [], [], [], [],
  [$3$], [$-17/4$], [$71/4$], [$-59/2$], [$49/2$], [$-41/4$], [$7/4$], [], [], [],
  [$4$], [$-49/8$], [$29$], [$-461/8$], [$62$], [$-307/8$], [$13$], [$-15/8$], [], [],
  [$5$], [$-967/120$], [$638/15$], [$-3929/40$], [$389/3$], [$-2545/24$], [$268/5$], [$-1849/120$], [$29/15$], [],
  [$6$], [$-801/80$], [$349/6$], [$-18353/120$], [$2391/10$], [$-1457/6$], [$4891/30$], [$-561/8$], [$527/30$], [$-469/240$],
)

== Increasing the order again

There is an easier way to do this, first observe the central difference:

$
phi.alt (h) = (f(x+h)-f(x-h))/(2h) approx f'(x)
$

Substituting this into:

$
f'(x) = (f(x+h)-f(x-h))/(2h) + c_2 h^2 + c_4 h^4 + c_6 h^6 + ...
$

$
arrow.double phi.alt (h) = f'(x) - c_2 h^2 - c_4 h^4 - c_6 h^6 - ...
$

= Richardson Extrapolation

Recall approximation $A_0 (h) = (f(x+h)-f(x-h))/(2h)$. $h/2$ reduces error by $1/2^2$

$
A_0 (h) = f'(x) - c_2 h^2 - c_4 h^4 - c_6 h^6 - ...
$

$
A_0 (h/2) = f'(x) - (c_2 h^2)/2^2 - (c_4 h^4)/2^4 - (c_6 h^6)/2^6 - ...
$

Eliminate: $-gamma 1/2^2+1=0 arrow.double gamma = 2^2$ so

$
A_0 (h) - 2^2 A_0 (h/2) = (1-2^2)f'(x) - 3/4c_4h^4 - 15/16c_6h^6-...
$

$
f'(x) = underbrace(A_0 (h/2) (A_0 (h/2)- A_0 (h))/(2^2-1),A_1(h)) + cal(O) (h^4)
$

Substitute $A_0 (h) = phi.alt (h)$ and rescale $h/2 arrow h$

== Sixth Order

Recall $A_1 (h) = A_0 (h/2) + (A_0 (h/2) - A_0(h))/(2^2-1)$. $h/2$ reduces error by $1/2^4$

$
A_1 (h) = f'(x) + 1/4c_4 h^4 + 5/16c_6 h^6 + ...
$

$
A_1 (h/2) = f'(x) + (c_4 h^4)/(4 dot 2^4) + (c_6 h^6)/(16 dot 2^6) + ...
$

Eliminate $-gamma 1/2^4 + 1 = 0 arrow.double gamma = 2^4$ so

$
A_1(h) - 2^4A_1(h/2) = (1-2^4)f'(x) + 15/64c_6h^6 + ...
$

$
f'(x) = underbrace(A_1(h/2)+(A_1(h/2)-A_1(h))/(2^4-1)+ cal(O)(h^6),A_2(h))
$
$
f'(x)= (64A_0(h/4)-20A_0(h/2)+A_0(h))/45 + cal(O)(h^6)
$

== Generalization

Let $A(h)$ be an approximator of a method ($phi.alt(h), psi (h),$ etc.). 

$cal(O)(h^2) arrow cal(O)(h^4)$ has

$
f'(x) approx psi(h) = phi.alt (h/2) + 1/(2^2-1)[phi.alt(h/20)-phi.alt(h)]
$

Using steps from $cal(O)(h^4) arrow cal(O)(h^6)$ has

$
f'(x) approx psi(h/2) + 1/(2^4-1) [psi(h/2 - psi(h))]
$

Observe that the previous approximator is used to get the next iteration.

Generalizing this, the recursive formula for Richardson is

$
A_(k+1) (h) = A_k (h/2) + 1/(2^m - 1) [A_k (h/2) = A_k (h)]
$

$A_k (h)$ is the approximator for the previous iteration, $m$ is the order of the previous iteration.

- not just on finite difference
- order increases by 1 for forward and backward difference
- order increases by 2 for central difference

For example: Estimate $f'(0.5)$ from $f(x) = 0.1x^4 - 0.15x^3 - 0.5x^2 - 0.25x + 1.2$ using the centered differences $h = 0.5$ and improve the solution using Richardson Extrapolation.

$f'(0.5) approx (f(0.5+0.5)-f(0.5-0.5))/(2(0.5)) = -1$

With $h = 0.25, f'(0.5) approx (f(0.75)-f(0.25))/2(0.25)=-299/320$

From here, apply fourth order Richardson extrapolation,

$f'(0.5) = -299/320 + 1/3 (-299/320 - (-1)) = -73/80$, which is the exact value.
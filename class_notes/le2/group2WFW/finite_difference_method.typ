#import "../../../template.typ": project

#show: project.with(
  title: "Finite Difference Method",
  contributor: "Karl Benedict C. Real",
  date: "November 4, 2026",
)


= Introduction
We know that differential equations are just derivatives, and we already know how to approximate derivatives using function evaluation. Then, to solve for BVPs, we can discretize the ODE, approximate $y', y'', dots$ with finite differences, and derive and solve an SLE to get _interior points_ (or points inside the boundary conditions).

= Finite Difference Method for Dirichlet BCs
Consider a BVP with $y(a) = alpha$ and $y(b) = beta$. We can solve this using FDA by doing the following steps @ruayavillar2026fda:
+ *Discretize the ODE.* Suppose we use a total of $n$ uniformly spaced points. Since this includes 2 boundary points, there are $n-2$ interior points. For each step $h = (b-a)/(n-1)$, define nodes $x_i = x_0 + i h$ where $0 <= i < n$.
+ *Apply finite differences.* Replace _(or rather, approximate)_ $y', y'', dots$ with the finite differences.
+ *Group each $y_(i+k)$ term accordingly*. For example, $A_i y_(i-1) + B_i y_i + C_i y_(i+1) = R(x_i)$ for some functions $A_i, B_i, C_i,$ and $R$.
+ *Form the SLE and solve for all $y_i$.*

== Example
#block(
  fill: rgb("f9f9f9"),
  inset: 12pt,
  radius: 4pt,
  width: 100%,
  stroke: 0.5pt + luma(150),
)[
  Solve the BVP
  $
    y'' - 2y' - y = 0, quad
    y(0)=0, y(1)=1
  $
  using FDA with 3 interior points @ruayavillar2026fda.
]
+ *Discretize the ODE.* 
  Since there are $n-2=3$ interior points, we use a total of $n=5$ points. And the boundary points are $a=0, b=1$, we have $h = (1-0)/(5-1) = 0.25$. 
  Then, we have nodes $x_i = x_0 + i h = 0 + 0.25i = 0.25i$ for $0 <= i < 5$:
  $
    x_0 = 0, quad
    x_1 = 0.25, quad
    x_2 = 0.5, quad
    x_3 = 0.75, quad
    x_4 = 1
  $
+ *Apply finite differences.*
  Note that
  #figure(
    table(
      inset: 1em,
      columns: 4,
      [], [Forward], [Central], [Backward],
      [$y$], [$y_i$], [$y_i$], [$y_i$],
      [$y'$], [$frac(y_(i+1) - y_i, h)$], [$frac(y_(i+1) - y_(i-1), 2h)$], [$frac(y_(i) - y_(i-1), h) $],
      [$y''$], [$frac(y_i-2y_(i+1)+y_(i+2), h^2)$], [$frac(y_(i-1)-2y_(i)+y_(i+1), h^2)$], [$frac(y_(i-2)-2y_(i-1)+y_(i), h^2)$],
    )
  )
  Suppose we use central difference approximation. Then, we substitute
  $
    y = y_i, quad
    y' approx frac(y_(i+1) - y_i, h), quad
    y'' approx frac(y_(i-1)-2y_(i)+y_(i+1), h^2)
  $
  to the ODE:
  $
    frac(y_(i-1)-2y_(i)+y_(i+1), h^2) - 2[frac(y_(i+1) - y_(i-1), 2h)] - y_i = 0
  $
+ *Group each $y_(i+k)$ term accordingly.*
  $
    [1/h^2 + 1/h]y_(i-1) + [-2/h^2-1]y_i + [1/h^2 - 1/h]y_(i+1) = 0 \
    20y_(i-1) - 33y_i + 12y_(i+1) = 0
  $
  (or multiply the equation by $h^2$)
  $
    (1 + h)y_(i-1) + (-2-h^2)y_i + (1 - h)y_(i+1) = 0 \
    5/4 y_(i-1) - 33/16 y_i + 3/4 y_(i+1) = 0
  $
+ *Form the SLE and solve for all $y_i$.*
  
  Substituting $i=1,2,3$:
    $
      20y_0-33y_1+12y_2 &= 0 => -33y_1+12y_2 = 0 \
      20y_1-33y_2+12y_3 &= 0 \
      20y_2-33y_3+12y_4 &= 0 => 20y_2-33y_3 = -12 \
    $

  Thus, the matrix is
  $
    mat(
      -33, 12, 0;
      20, -33, 12;
      0, 20, -33
    ) mat(
      y_1; y_2; y_3
    ) = mat(
      0; 0; -12
    ) \
    => mat(
      y_1; y_2; y_3
    ) = mat(
      0.0859; 0.2364; 0.5069
    )
  $

= Finite Difference Method for Neumann BCs
Recall that Neumann BCs only give $y'(x_0) = y'(a) = alpha$ and $y'(x_n) = y'(b) = beta$. Then, unlike when given DBCs, we can't simply use central approximation on the endpoints because that would give
$
  y'(a) approx frac(y_1 - y_(-1), 2h), quad
  y'(b) approx frac(y_(n+1) - y_(n-1), 2h),
$
but $x_(-1)$ and $x_(n+1)$ are outside of our given interval. Then, we have to find some workaround on how to approximate the endpoints properly. 

There are two ways to solve for BVPs given Neumann BCs: (1) approximate the endpoints using forward and backward differences, and (2) use the method of _fictitious points_ @ruayavillar2026fda.

= Forward and Backward Difference
Recall that the forward and backward difference approximations for a first derivative are
$
  f'(x) approx frac(f(x+h) - f(x), h) "and"
  f'(x) approx frac(f(x) - f(x-h), h)
$
respectively, where both have first-order error. Then, we can use forward difference on $f'(x_0)$ and backward difference on $f'(x_n)$:
$
  f'(x_0 = a) approx frac(y_1 - y_0, h) = alpha, quad
  f'(x_n = b) approx frac(y_n - y_(n-1), h) = beta.
$

The interior points $y_1, y_2, dots, y_(n-1)$ can still be approximated using central difference. 

== Example
#block(
  fill: rgb("f9f9f9"),
  inset: 12pt,
  radius: 4pt,
  width: 100%,
  stroke: 0.5pt + luma(150),
)[
  @ruayavillar2026fda Using FDA with 3 interior points, solve
  $
    y'' - 2y' - y = 0, quad
    y'(0) = 2, y'(1) = 1.
  $
]
_Solution._
Note that $h = frac(b-a, n+1) = frac(1-0, 3+1) = 1"/"4$.
+ Use forward and backward difference on the endpoints:
  $
    y'(x_0 = 0) approx frac(y_1 - y_0, h) = alpha = 2 => 
    -4y_0 + 4y_1 = 2 \
    y'(x_n = 1) approx frac(y_4 - y_3, h) = beta = 1 => 
    -4y_3 + 4y_4 = 1 \
  $

+ Apply central difference to the interior points $y_1, y_2, y_3$:
  
  Recall that
  $
    y'(x_i) approx frac(y_(i+1) - y_(i-1), 2h), quad
    y''(x_i) approx frac(y_(i-1) - 2y_i + y_(i+1), h^2).
  $
  Substituting these to the equation, we get
  $
    frac(y_(i-1) - 2y_i + y_(i+1), h^2) - 2[frac(y_(i+1) - y_(i-1), 2h)] - y_i = 0 \
    16(y_(i-1) - 2y_i + y_(i+1))-4(y_(i+1) - y_(i-1))-y_i = 0 \
    20y_(i-1) - 33y_i + 12y_(i+1) = 0, quad "for" i=1,2,3.
  $

+ Form the SLE and solve:
  $
    mat(
      -4, 4, 0, 0, 0;
      20, -33, 12, 0, 0;
      0, 20, -33, 12, 0;
      0, 0, 20, -33, 12;
      0, 0, 0, -4, 4
    ) mat(
      y_0; y_1; y_2; y_3; y_4
    ) = mat(
      2; 0; 0; 0; 1
    ) \
    mat(
      y_0; y_1; y_2; y_3; y_4
    ) = mat(
      -5.327; -4.827; -4.396; -4.044; -3.764
    )
  $
  
== Generalization
#block(
  fill: rgb("f9f9f9"),
  inset: 12pt,
  radius: 4pt,
  width: 100%,
  stroke: 0.5pt + luma(150),
)[
  Solve the BVP
  $
    y'' + P(x) y' + Q(x) y = R(x), quad
    a <= x <= b, quad
    y'(a) = alpha, y'(b) = beta
  $
  with $(n-1)$ interior points and uniform spacing $h$.
]

_Solution._
Note that $h=frac(b-a, (n-1)+1) = frac(b-a, n)$. Approximating the endpoints with forward and backward difference,
$
  y'(x_0 = a) approx frac(y_1 - y_0, h) = alpha => -1/h y_0 + 1/h y_1 = alpha \
  y'(x_n = b) approx frac(y_n - y_(n-1), h) = alpha => -1/h y_(n-1) + 1/h y_n = beta \
$
Using central difference on the interior points $y_1, y_2, dots, y_(n-1)$,
$
  y'(x_i) approx frac(y_(i+1) - y_(i-1), 2h), quad
  y''(x_i) approx frac(y_(i-1) - 2y_i + y_(i+1), h^2)
$
Substituting these to the equation,
$
  [frac(y_(i-1) - 2y_i + y_(i+1), h^2)] + P(x_i) [frac(y_(i+1) - y_(i-1), 2h)] + Q(x_i) y_i = R(x_i) \
  [1/h^2 - P(x_i)/(2h)] y_(i-1) + [-2/h^2 + Q(x_i)] y_i + [1/h^2 + P(x_i)/(2h)] y_(i+1) = R(x_i)
$
for $i = 1, 2, dots, n-1$.

Therefore, we get the following SLE:
$
  mat(
    -1/h, 1/h, 0, dots, 0;
    A_1, B_1, C_1, dots.down, 0;
    dots.v, dots.down, dots.down, dots.down, dots.v;
    0, dots.down, A_(n-1), B_(n-1), C_(n-1);
    0, dots, 0, -1/h, 1/h
  ) mat(
    y_0; y_1; dots.v; y_(n-1); y_n
  ) = mat(
    alpha; R(x_1); dots.v; R(x_(n-1)); beta 
  )
$
where
$
  A_i = 1/h^2 - P(x_i)/(2h), quad
  B_i = -2/h^2 + Q(x_i), quad
  C_i = 1/h^2 + P(x_i)/(2h).
$

Note that this method loses accuracy on the endpoints because we only used forward and backward approximations; these has an error of $O(h)$ whereas central approximation has an error of $O(h^2)$.

= Method of Fictitious Points
Earlier, we mentioned that we cannot perform central approximation on the endpoints because we need the points $y_(-1)$ and $y_(n+1)$ which are outside of the interval. But what if we use central approximation on the endpoints anyway? Then, for a general BVP, the SLE becomes
$
  [1/h^2 - P(x_i)/(2h)] y_(i-1) + [-2/h^2 + Q(x_i)] y_i + [1/h^2 + P(x_i)/(2h)] y_(i+1) = R(x_i)
$
for all $i = 0, 1, dots, n-1, n$.

== What happens at the endpoints?
The central approximation of the endpoints are
$
  y'(a) approx frac(y_1 - y_(-1), 2h) = alpha, quad
  y'(b) approx frac(y_(n+1) - y_(n-1), 2h) = beta.
$
Since we know that $y'(a) = alpha$ and $y'(b) = beta$, we can find equations for $y_(-1)$ and $y_(n+1)$ such that it uses points within our interval. That is,
$
  frac(y_1 - y_(-1), 2h) = alpha => y_(-1) = y_1 - 2h alpha \
  frac(y_(n+1) - y_(n-1), 2h) = beta => y_(n+1) = y_(n-1) + 2h beta \
$

== Deriving the new SLE
Substituting the equations for $y_(-1)$ and $y_(n+1)$, we get the following:
- At $i=0$:
  $
    [1/h^2 - P(x_0)/(2h)] y_(-1) + [-2/h^2 + Q(x_0)] y_0 + [1/h^2 + P(x_0)/(2h)] y_(1) = R(x_0) \
    [1/h^2 - P(x_0)/(2h)] (y_1 - 2h alpha) + [-2/h^2 + Q(x_0)] y_0 + [1/h^2 + P(x_0)/(2h)] y_(1) = R(x_0) \
    [-2/h^2 + Q(x_0)] y_0 + [(1/h^2 - P(x_0)/(2h)) + (1/h^2 + P(x_0)/(2h))] y_1 = R(x_0) + [1/h^2 - P(x_0)/(2h)] 2h alpha \
    [-2/h^2 + Q(x_0)] y_0 + 2/h^2 y_1 = R(x_0) + [2/h - P(x_0)]alpha \
  $
- At $i=n$:
  $
    [1/h^2 - P(x_n)/(2h)] y_(n-1) + [-2/h^2 + Q(x_n)] y_n + [1/h^2 + P(x_n)/(2h)] y_(n+1) = R(x_n) \
    [1/h^2 - P(x_n)/(2h)] y_(n-1) + [-2/h^2 + Q(x_n)] y_n + [1/h^2 + P(x_n)/(2h)] (y_(n-1) + 2h beta) = R(x_n) \
    [(1/h^2 - P(x_n)/(2h)) + (1/h^2 + P(x_n)/(2h))] y_(n-1) + [-2/h^2 + Q(x_n)] y_n = R(x_n) - [1/h^2 + P(x_n)/(2h)] 2h beta \
    2/h^2 y_(n-1) + [-2/h^2 + Q(x_n)] y_n = R(x_n) - [2/h + P(x_n)] beta \
  $
- And the equation for the interior points $i=1,2,dots,n-1$ stays the same:
  $
    [1/h^2 - P(x_i)/(2h)] y_(i-1) + [-2/h^2 + Q(x_i)] y_i + [1/h^2 + P(x_i)/(2h)] y_(i+1) = R(x_i)
  $
Therefore, we have the following SLE:
$
  mat(
    -2/h^2 + Q(x_0), 2/h^2, 0, dots, 0;
    A_1, B_1, C_1, dots.down, 0;
    dots.v, dots.down, dots.down, dots.down, dots.v;
    0, dots.down, A_(n-1), B_(n-1), C_(n-1);
    0, dots, 0, 2/h^2, -2/h^2 + Q(x_i)
  ) mat(
    y_0; y_1; dots.v; y_(n-1); y_n
  ) = mat(
    R(x_0) + [2/h - P(x_0)]alpha; 
    R(x_1); 
    dots.v; 
    R(x_(n-1)); 
    R(x_n) - [2/h + P(x_n)] beta 
  )
$
where
$
  A_i = 1/h^2 - P(x_i)/(2h), quad
  B_i = -2/h^2 + Q(x_i), quad
  C_i = 1/h^2 + P(x_i)/(2h).
$
Note that this method keeps the $O(h^2)$ approximation because we used central approximation on all points.

== Example (Revisited)

#block(
  fill: rgb("f9f9f9"),
  inset: 12pt,
  radius: 4pt,
  width: 100%,
  stroke: 0.5pt + luma(150),
)[
  Find an $O(h^2)$ solution with 3 interior points of the BVP
  $
    y'' - 2y' - y = 0, quad
    y'(0) = 2, y'(1) = 1.
  $
]

_Solution._
Note that $h = 1"/"4, P(x) = -2, Q(x) = -1, R(x) = 0$. Then,
$
  A_i &= 1/h^2 - P(x_i)/(2h) = 16 - (-2)2 = 20, \
  B_i &= -2/h^2 + Q(x_i) = -2(16) - 1 = -33, \
  C_i &= 1/h^2 + P(x_i)/(2h) = 16 + (-2)2 = 12
$
for $i=1,2,dots,n-1$.

Thus, the SLE is
$
  mat(
    -33, 32, 0, 0, 0;
    20, -33, 12, 0, 0;
    0, 20, -33, 12, 0;
    0, 0, 20, -33, 12;
    0, 0, 0, 32, -33
  ) mat(
    y_0; y_1; y_2; y_3; y_4
  ) = mat(
    20; 0; 0; 0; -6
  ) \ 
  mat(
    y_0; y_1; y_2; y_3; y_4
  ) = mat(
    -4.9084;
    -4.4368;
    -4.0205;
    -3.6617;
    -3.3690
  )
$

= Summary
To solve for the BVP
$
  y'' + P(x) y' + Q(x) y = R(x), quad
  a <= x <= b, quad
  y'(a) = alpha, y'(b) = beta
$
with $(n-1)$ interior points and uniform spacing $h$, we can either:
- Use forward and backward difference approximation on the endpoints:
  $
    mat(
      -1/h, 1/h, 0, dots, 0;
      A_1, B_1, C_1, dots.down, 0;
      dots.v, dots.down, dots.down, dots.down, dots.v;
      0, dots.down, A_(n-1), B_(n-1), C_(n-1);
      0, dots, 0, -1/h, 1/h
    ) mat(
      y_0; y_1; dots.v; y_(n-1); y_n
    ) = mat(
      alpha; R(x_1); dots.v; R(x_(n-1)); beta 
    )
  $
  with the order of approximation around the boundary points reduced by 1,
- or use central difference approximation on all points with fictitious points:
  $
    mat(
      -2/h^2 + Q(x_0), 2/h^2, 0, dots, 0;
      A_1, B_1, C_1, dots.down, 0;
      dots.v, dots.down, dots.down, dots.down, dots.v;
      0, dots.down, A_(n-1), B_(n-1), C_(n-1);
      0, dots, 0, 2/h^2, -2/h^2 + Q(x_i)
    ) mat(
      y_0; y_1; dots.v; y_(n-1); y_n
    ) = mat(
      R(x_0) + [2/h - P(x_0)]alpha; 
      R(x_1); 
      dots.v; 
      R(x_(n-1)); 
      R(x_n) - [2/h + P(x_n)] beta 
    )
  $
  with an $O(h^2)$ solution,

where both formulas use
$
  A_i = 1/h^2 - P(x_i)/(2h), quad
  B_i = -2/h^2 + Q(x_i), quad
  C_i = 1/h^2 + P(x_i)/(2h).
$

#bibliography("../../../resources/bibs/class_notes/le2/3_finite_difference_method.bib", style: "apa", full: true) 

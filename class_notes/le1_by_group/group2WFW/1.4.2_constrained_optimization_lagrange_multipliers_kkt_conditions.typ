#import "../../../template.typ": project

#show: project.with(
  title: "Async; Bonus Reading: Constrained Optimization: Lagrange Multipliers, KKT Conditions",
  contributor: "James Jacob Emnace",
  date: "September 24, 2026",
)

=== [Arc 1] Async; Bonus Reading: Constrained Optimization: Lagrange Multipliers, KKT Conditions

As discussed earlier, nonlinear least squares have different algorithms for solutions:

- Newton's method
- Gauss-Newton method
- Levenberg-Marquard method

But can these algorithms still work if we add $p$ equality constraints?

$
g_1(x) = 0,  g_2(x) = 0, ..., g_p(x) = 0
$

#text(12pt)[*Constrained nonlinear least squares*]

#align(center)[
Minimize $f_1(x)^2 + ... + f_m(x)^2$

subject to the constraints $g_1(x) = 0,  g_2(x) = 0, ..., g_p(x) = 0$
]

Note that variable is $n$-vector $x$, $f_i(x)$ is $i$th (scalar) _residual_, and $g_i(x) = 0$ is $i$th (scalar) equality constraint.

$x$ is feasible if it satisfies the constraints:
$
g(x) = mat(delim: "[", g_1(x); dots.v; g_p(x)) = 0
$

feasible $hat(x)$ is _optimal_/_minimum_ if $h(hat(x)) <= h(x)$ for all feasible $x$

feasible $hat(x)$ is _locally optimal_ (a _local minimum_) if there exists an $R > 0$ such that

#align(center)[
$h(hat(x)) <= h(x)$ for all feasible $x$ with $norm(x - hat(x)) <= R$
]

In Vector notation, this would be:

#align(center)[
Minimize $norm(f(x))^2$

subject to $g(x) = 0$
]

Where $f : R^n -> R^m$ is vector function $f(x) = (f_1(x),...,f_m(x))$ and $g : R^n -> R^p$ is vector function $g(x) = (g_1(x),...,g_p(x))$

How do we go about solving this?

#text(12pt)[*Lagrange multipliers*]

*Lagrangian*
$
L(x,z) = h(x) + z^T g(x) \
#h(3.9cm) = h(x) + z_1g_1(x) + ... + z_p g_p (x)
$

the $p$-vector $z = (z_1,...,z_p)$ is the vector of _Lagrange multipliers_ $z_1,...,z_p$

*Gradient of Lagrangian*
$
nabla L(tilde(x),tilde(z)) = mat(delim: "[", nabla_x L(tilde(x),tilde(z));
nabla_z L(tilde(x),tilde(z)))
$

where

$
nabla_x L(tilde(x),tilde(z)) = nabla h(tilde(x)) + tilde(z)_1 nabla g_1 (tilde(x)) + ... + tilde(z)_p nabla g_p (tilde(x)) \
= nabla h(tilde(x)) + D g(tilde(x))^T tilde(z) #h(1.1cm) \
nabla_z L(tilde(x),tilde(z))) = g(tilde(x)) #h(5.3cm)
$

#text(12pt)[*First-order optimality conditions*]

#align(center)[
  minimize $h(x) #h(0.75cm)$

  subject to $g(x) = 0$
]

where $h$ is a function from $R^n$ to $R^m$ and g is a function from $R^n$ to $R^p$

#text(12pt)[*First-order necessary optimality conditions*]

if $hat(x)$ is locally optimal and rank $D g(hat(x)) = p$, then there exist multipliers $hat(z)$ with

$
nabla_x L(tilde(x),tilde(z)) = nabla h(tilde(x)) + D g(tilde(x))^T tilde(z)
$

This will then form a set of $n + p$ equations in $n + p$ variables $hat(x), hat(z)$ with $g(hat(x)) = 0$

Note that gradient $nabla h(hat(x))$ is a linear combination of gradients $nabla g_1(hat(x)), ..., nabla g_p (hat(x))$

*Regular feasible point*

If rank$(D g (x)) = p$, a feasible x is called a _regular_ feasible point, and at this point, $nabla g_1(hat(x)), ..., nabla g_p (hat(x))$ are linearly independent

#align(center)[
  \ \
We can then apply the method of _lagrange multiplier_ to optimize constrained nonlinear least squares
 \
]

#text(12pt)[*First-order necessary optimality condition*]

*Lagrangian*

$
L(x,z) = f_1(x)^2 + ... + f_m (x)^2 + z_1 g_1 (x) + ... + z_p g_p (x)
\
= norm(f(x))^2 + z^T g(x) #h(3.65cm)
$

*Gradients of Lagrangian*

$
nabla_z L(hat(x), hat(z)) = g(hat(x)) 
\
nabla_x L(hat(x), hat(x)) = 2D f(hat(x))^T f(hat(x)) + D g(hat(x))^T hat(z)
\
= 2mat(delim: "[", nabla f_1 (hat(x)), ..., nabla f_m (hat(x))) mat(delim: "[", f_1 (hat(x)); dots.v; f_m (hat(x))) + mat(delim: "[", nabla g_1 (hat(x)), ..., nabla g_p (hat(x))) mat(delim: "[", hat(z)_1; dots.v; hat(z)_p)
$

*Optimality condition*

if $hat(x)$ is locally optimal, then there exists $hat(z)$ such that

$
2D f(hat(x))^T f(hat(x)) + D g(hat(x))^T hat(z) = 0, #h(1cm) g(hat(x)) = 0
$

Note that the rows of $D g(hat(x))$ need to be linearly independent

\
What happens if it was linear instead of nonlinear?
\

#text(12pt)[*Constrained linear least squares*]

#align(center)[
  minimize $norm(A x - b)^2$
  \
  subject to $C x = d$
]

This is a special case of the earlier problem with

$
f(x) = A x - b, #h(0.8cm)g(x) = C x - d
$

If we apply the general optimality condition to this problem, we will get:

$
2D f(hat(x))^T f(hat(x)) + D g(hat(x))^T hat(z) = 2A^T (A hat(x) - b) + C^T hat(z) = 0, #h(0.4cm) g(hat(x)) = C hat(x) - d = 0
$

From here, we can get through matrix form the *Karush-Kuhn-Tucker (KKT) equations*

$
mat(delim: "[", 2A^T A, C^T; C, 0) mat(delim: "[", hat(x); hat(z)) = mat(delim: "[",2A^T b; d)
$
#set heading(numbering: "1.1")
#set par(justify: true)

#align(center)[
  #text(size: 18pt, weight: "bold")[CS138-Typst Notes] \
  #v(1em)
  #text(size: 14pt)[CS138 WFW] \
  #v(0.5em)
  S.Y. 2026 -- 2027
]
#v(2em)

#outline(title: "Contents", indent: true)
#v(2em)
#line(length: 100%)
#v(2em)

= Applied Linear Algebra

== Notes

=== Direct Methods for solving SLEs

=== Iterative Methods for solving SLEs, Iterative Refinement

==== System of Linear Algebraic Equations
#align(center)[
  Introduction, Direct Methods: LU Decomposition Methods
]

==== Matrix Inverse
Solving $A x = b_i$ for $i=1,2,...,n$ is redundant.

TRY: Solve for $A^(-1)$

The Math 40 way of inverting a matrix is similar to applying GJR on the augment system $A e_i$ where $I$.

==== Doolittle's Decomposition: Illustration
Recall from GE that we transform a matrix $A -> U$ using EROS.

If $R = E_n ... E_2 E_1$ transforms $A -> U$, then $R^(-1)$

Slide 4/30

$ (E_1 E_2 E_3) = U + gamma $

$ (E_1^(-1) E_2^(-1) E_3^(-1)) = L - gamma $

$ (E_1 E_2 E_3)(E_1^(-1) E_2^(-1) E_3^(-1)) = A $

$ L = mat(
  1, 0, 0;
  gamma_-, 1, 0;
  gamma_-, gamma_-, 1
) $
\
$ U = mat(
  1, 1, 1;
  0, 1, 1;
  0, 0, 1
) $

slide 7/35 (board pic 2)

==== Decomposition Phase: The Algorithm
+ Calculate the first row of $U: u_{1 j} = a_{1 j}, forall j = 1,...,n$
+ Substitute 1s in diagonal of $L: l_{i i} = 1, forall i = 1,...,n$

==== LU Decomposition Methods
- $->$ Consider the matrix equation
  $ A x = b $
- $->$ If $A$ can be factored into two triangular matrices $L$ and $U$

==== Doolittle's Decomposition: Solution Phase

==== Example:
Given the system

$ mat(
  1, 4, 1, 7;
  1, 6, -1, 13;
  2, -1, 2, "" 
) $

solve for $x$ using the Doolittle's decomposition method.

Slides (ques) board pic 3

- *Recall:* Is $A = L U$ unique for a nonsingular matrix $A$? *NO!*

- Suppose that $A$ is nonsingular and transforming $A -> U$ do not require row interchanges:
  $ mat("") $
  
- $->$ $A = L_D U_D = (L_D D)(D^(-1) U_D) = L_C U_C$, where $D$ is a "factored" diagonal matrix.
- $->$ From *Doolittle $->$ Crout*: (row normalization)

==== Decomposition Method

==== Augmented Matrix = $[A | I]$

=== Real Eigenvalue Approximations of a Square Matrix

== Homework

=== Direct Methods for solving SLEs

Prove that $A$ is well-conditioned, then a small relative residual implies a small relative vector in $hat(x)$:

- $=>$ From $hat(x) = x + Delta x$ and $A hat(x) = b + Delta b$, show that $A Delta x = Delta b$.
- $=>$ Apply properties of norms to get $norm(Delta x) <= norm(A^(-1)) dot norm(Delta b)$.
- $=>$ Take another $b = A x$ and play around with it. Using both equations, show that:
  $ norm(x - hat(x)) / norm(x) <= kappa(A) (norm(r)) / (norm(A) dot norm(hat(x))) $
- $=>$ Using the expression, explain why well-conditioning of $A$ gives the correct conclusion.

=== Iterative Methods for solving SLEs, Iterative Refinement

=== Real Eigenvalue Approximations of a Square Matrix

== Cheatsheet
#import "../../../template.typ": project

#show: project.with(
  contributor: "Real, Karl Benedict",
  date: "September 24, 2026",
  title: "Linear Least Squares" 
)

#set math.mat(delim: "[")

_Citation:_ All information in this section came from #cite(<kloeckner2026numerical>, form: "prose", supplement: none).

= Motivation: Data Fitting
Have data: $(x_i, y_i)$ and model:
$
  y(x) = a + b x + c x^2
$
Find data that (best) fit the model.

We get the following system:
$
  a + b x_1 + c x_1^2 = y_1 \
  dots.v \
  a + b x_n + c x_n^2 = y_n \
$
This is not going to happen for $n > 3$. A quadratic model only has three unknowns $(a, b, c)$, so it generally cannot pass all $n$ data points (i.e. satisfy all equations). Instead we can choose $a, b, c$ such that the sum of the squares of residuals is minimized:
$
  abs(a + b x_1 + c x_1^2 - y_1)^2 
  + dots +
  abs(a + b x_n + c x_n^2 - y_n)^2  -> min!
$
This is called *linear least squares* specifically because the coefficients $x$ enter linearly into the residual.

We rewrite this in matrix form.
$
  norm(A x - b)^2_2 -> min!
$
with
$
  A = mat(
    1, x_1, x_1^2;
    dots.v, dots.v, dots.v;
    1, x_n, x_n^2
  ), quad 
  x = mat(a; b; c), quad
  b = mat(y_1; dots.v; y_n)
$
Matrices such as $A$ are called *Vandermonde matrices*. These are easy to generalize to higher polynomial degrees.

Define new notation:
$
  norm(A x - b)^2_2 -> min! <=> A x tilde.equiv b.
$

Note that data fitting is only one example where least squares (LSQ) problems arise. There are many other applications that lead to $A x tilde.equiv b$, with different matrices.

= Properties of Least-Squares
Consider LSQ problem $A x tilde.equiv b$ and its associated objective function $phi(x) = norm(b - A x)^2_2$. Assume $A$ has full rank. Then, the problem:
- Always has a solution. As $norm(x) -> infinity$, $phi -> infinity$. Then, if $phi$ is continuous, there must be a minimum.
- Always unique (because we are assuming full rank)
  - If $A$ does not have full rank, there's a null space, i.e. $n$ with $A n = 0$. Then, if $x$ is a solution, $norm(b - A(x + n))_2 = norm(b - A x)$.

= Least-Squares: Finding a Solution by Minimization
Examine the objective function, find its minimum.
$
  phi(x) &= (b - A x)^top (b - A x) \
  &= b^top b - 2x^top A^top b + x^top A^top A x
$
Getting its gradient,
$
  gradient phi(x) = -2 A^top b + 2 A^top A x
$

$gradient phi(x) = 0$ yields $A^top A x = A^top b$. These are called *normal equations*.

= Orthogonal Projection
A *projector* is a matrix satisfying $P^2 = P$. An *orthogonal projector* is a symmetric projector.

To create an orthogonal projector projecting onto $"span"{bold(q_1), bold(q_2), dots, bold(q_k)}$ for orthonormal $bold(q_i)$, we can define $Q = mat(bold(q_1), bold(q_2), dots, bold(q_k))$. Then,
$Q Q^top$ will project and is obviously symmetric.

*Example.* Show that $P = A(A^top A)^(-1) A^top$ is an orthogonal projector onto $"colspan"(A)$.
$
  P^2 = P P &= [A(A^top A)^(-1) A^top] [A(A^top A)^(-1) A^top] \
  &= A(A^top A)^(-1) [A^top A(A^top A)^(-1)] A^top \
  &= A(A^top A)^(-1) I A^top \
  &= A(A^top A)^(-1) A^top = P \
$
Since $P^2 = P$, $P$ is a projector. Since $A = A^top$,
$
  P^T &= (A(A^top A)^(-1) A^top)^top \
  &= (A^top)^top ((A^top A)^(-1))^top A^top \
  &= A ((A^top A)^(-1))^top A^top = P\
$
Thus, $P$ is symmetric. Lastly, take any vector $x$. Then,
$
  P x &= A(A^top A)^(-1) A^top x \
  &= A[(A^top A)^(-1) A^top x] \
  &= A c  quad "(some vector" c)
$
Since all vectors of $A c$ is in $"colspan"(A)$, $P x in "colspan"(A)$ for all $x$. $square.filled$

Then, to define $P$, we need to assume that $A^top A$ has full rank (i.e. is invertible).

= Pseudoinverse
A nonsquare $m times n$ matrix $A$ (where m > n) has no inverse in a usual sense. 

If $"rank"(A) = n$, the *pseudoinverse* is 
$
  A^+ = (A^top A)^(-1) A^top.
$

Define the condition number of a tall-and-skinny matrix:
$
  "cond"_2(A) = norm(A)_2 norm(A^+)_2
$
If not full rank, $"cond"(A) = infinity$ by convention.

This is important because we now have another of solving LSQ that is analogous to $A x = b => x = A^(-1) b$:
$
  A x tilde.equiv b => x = A^+ b
$

= Sensitivity and Conditioning of Least-Squares
We can relate $norm(A x)$ and $b$ using trigonometry:
$
  cos(theta) = norm(A x)_2/norm(b)_2
$

Recall $x = A^+ b$. Also, $Delta x = A^+ Delta b$. Then,
$
  Delta x &= A^+ Delta b \
  norm(Delta x)_2 &= norm(A^+ Delta b)_2 \
  norm(Delta x)_2 &<= norm(A^+)_2 norm(Delta b)_2 \
  norm(Delta x)_2/norm(x)_2 &<= frac(norm(A^+)_2 norm(Delta b)_2, norm(x)_2) \
  &= frac(kappa(A), norm(A)_2 norm(A^+)_2) norm(A^+)_2 norm(b)_2/norm(b)_2 norm(Delta b)_2/norm(x)_2 \
  &= kappa(A) frac(norm(b)_2, norm(A)_2 norm(x)_2) norm(Delta b)_2/norm(b)_2 \
  &<= kappa(A) norm(b)_2/norm(A x)_2 norm(Delta b)_2/norm(b)_2 \
  &= kappa(A) 1/cos(theta) norm(Delta b)_2/norm(b)_2 
$
Since $b perp "colspan"(A)$ (i.e. $theta = pi"/"2$) gives $cos(theta) = 0$, then any $theta approx pi"/"2$ is bad. This means that the sensivity of LSQ solutions depend on both $A$ and $b$.

What about changes in the matrix?
$
  norm(Delta x)_2/norm(x)_2 <= ["cond"(A)^2 tan(theta) + "cond"(A)] dot norm(Delta A)_2/norm(A)_2
$
This leads to two behaviors:
+ If $tan(theta) approx 0$, the condition number is $"cond"(A)$.
+ Otherwise, $"cond"(A)^2 tan(theta)$.

= Transforming Least Squares to Upper Triangular
Suppose we have $A = Q R$, with $Q$ square and orthogonal, and $R$ upper triangular (QR factorization). We can transform a least sqaures problem $A x tilde.equiv b$ to one with an upper triangular matrix:
$
  norm(A x - b)_2 &= norm(Q^top (Q R x - b))_2 \
  &= norm(R x - Q^top b)_2
$

Then, we transformed $A x tilde.equiv b => R x tilde.equiv Q^top b$.

To minimize the residual norm of some residual vector $r$,
$
  norm(r)^2_2 = norm((Q^top b)_"top" - R_"top" x)^2_2 + norm((Q^top b)_"bottom")^2_2.
$
Since $R_"top"$ is invertible, we can find $x$ such that
$
  (Q^top b)_"top" - R_"top" x = 0 => R_"top" x = (Q^top b).
$
This leaves
$
  norm(r)^2_2 = norm((Q^top b)_"bottom")^2_2.
$

Note on $X_"top/bottom"$ notation:
Let $A_(m times n)$ with $m > n$. Then, $Q$ is $m times m$ and $R = mat(R_"top"; 0)$ where $R_"top"$ is $n times n$ and upper triangular. Also, $Q^top b$ has $m$ entries. Then
$
  Q^top b = mat((Q^top b)_"top"; (Q^top b)_"bottom")
$ 
where 
- $(Q^top b)_"top"$ is the first $n$ entries
- $(Q^top b)_"bottom"$ is the last $m - n$ entries



#bibliography("../../../resources/bibs/class_notes/le1/Group_2_WFW.bib", style: "apa")


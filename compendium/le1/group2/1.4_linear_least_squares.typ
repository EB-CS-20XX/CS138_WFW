#import "../../../template.typ": project
#show: project.with(
  title: "Linear Least Squares: Solved Problems",
  contributor: "Real, Karl Benedict C.",
  date: "September 28 2026",
)

#show bibliography: set heading(numbering: none)

#set heading(numbering: none)
#set math.mat(delim: "[")

= Problem 1
Consider the data points $(lambda_i, y_i) in RR, (1, 1), (2, 0), (-1, 2), "and" (0, -1)$. We wish to determine a real polynomial of degree $2$ that best fits this data. A general polynomial of degree 2 has the form $p(lambda) = x_0 + x_1 lambda + x_2 lambda^2$, where $x = (x_0, x_1, x_2)^T in RR^3$. Note that there are more data points that there are unknown coefficients $x_0, x_1, "and" x_2$ and so it is unlikely that there exists a second degree polynomial that fits this data precisely.#super([@burke2014math408])

#set enum(numbering: "(a)")
+ Write the problem of determining the quadratic polynomial that "best" fits this data as a linear least squares problem by specificying the matrix $A$ and the vector $b$.

  *Solution.* Here, we are trying to satisfy $y_i = x_0 + x_1 lambda_i + x_2 lambda_i^2$ for the given data $(lambda_i, y_i)$. The associated linear least squares problem is to minimize the sum of the squares of the misfits:
  $
    (x_0 + x_1 + x_2 - 1)^2 + (x_0 + 2x_1 + 4x_2)^2 + (x_0 - x_1 + x_2 - 2)^2 + (x_0 + 1)^2.
  $
  Then, in matrix form:
  $
    A = mat(
      1, 1, 1;
      1, 2, 4;
      1, -1, 1;
      1, 0, 0
    ), quad 
    b = mat(
      1; 0; 2; -1
    )
  $

+ Solve this linear least squares problem.

  *Solution.* We first find the associated normal equations: $A^top A x = A^top b$.
  $
    A^top A = mat(
      1, 1, 1, 1;
      1, 2, -1, 0;
      1, 4, 1, 0
    ) mat(
      1, 1, 1;
      1, 2, 4;
      1, -1, 1;
      1, 0, 0
    ) = mat(
      4, 2, 6;
      2, 6, 8;
      6, 8, 18
    ) \
    A^top b = mat(
      1, 1, 1;
      1, 2, 4;
      1, -1, 1;
      1, 0, 0
    ) mat(
      1; 0; 2; -1
    ) = mat(
      2; -1; 3
    )
  $
  Solving for $x$,
  $
    A^top A x = A^top b \
    mat(
      4, 2, 6;
      2, 6, 8;
      6, 8, 18
    ) mat(
      x_1; x_2; x_3
    ) = mat(
      2; -1; 3
    ) => x = mat(
      1"/"5; -9"/"10; 1"/"2
    ).
  $
  Therefore, the polynomial of degree two that best fits this data in the least squares sense is
  $
    p(lambda) = lambda^2/2 - (9lambda)/10 + 1/5.
  $

= Problem 2
We want to find the least squares solution for a $3 times 2$ system using $Q R$ decomposition. Use the factorization $A = Q R$ to find the least-squares solution of $A x = b$, with
$
  A = mat(
    2, 3;
    2, 4;
    1, 1
  ) = mat(
    2/3, -1/3;
    2/3, 2/3;
    1/3, -2/3
  ) mat(
    3, 5;
    0, 1
  ), quad
  b = mat(
    7; 3; 1
  )
$

+ Given any $A in M_(m times n)$ with $A = Q R$ where $Q$ has orthonormal columns, show that the normal equations $A^top A x = A^ top b$ reduces to $R x = Q^top b$. #super([@tudelft-least-squares])
  
  *Proof.*
  $
    A^top A 
    &= (Q R)^top (Q R) \
    &= R^top Q^top Q R \
    &= R^top (Q^top Q) R \
    &= R^top I R \
    &= R^top R \
  $
  Then, 
  $
    A^top A x = A^ top b => R^top R x = R^top Q^top b.
  $ 
  Since $R$ is invertible, $R^top$ is invertible too. Therefore,
  $
    R^top R x &= R^top Q^top b \
    (R^top)^(-1) R^top R x &= (R^top)^(-1) R^top Q^top b \
    ((R^top)^(-1) R^top) R x &= ((R^top)^(-1) R^top) Q^top b \
    R x &=  Q^top b quad square.filled
  $

+ Solve the least-squares solution to the linear system $A x = b$ using the equation: $R x = Q^top b$. #super([@tudelft-least-squares])
  $
    R x &= Q^top b \
    mat(
      3, 5;
      0, 1
    ) mat(x_0; x_1) &= mat(
      2/3, 2/3, 1/3;
      -1/3, 2/3, -2/3
    ) mat(7; 3; 1) \
    &= mat(
      7; -1
    )
  $
  Using back substitution,
  $
    x_1 &= -1 \
    3x_0 + 5x_1 &= 7 => x_0 = (7-5x_1)/3 = 4
  $
  Therefore,
  $
    x = mat(
      4; -1
    )
  $


= Problem 3 (Remix)
Consider the following data points $(lambda_i, y_i) in RR$: $(-1, 13), (0, 8), (1, 79), (2, 206)$. Find a real polynomial of degree 2: $p(lambda) = x_0 + x_1 lambda + x_2 lambda^2$ where $x = (x_0, x_1, x_2)^top in RR^3$ that best fit the given data points.

+ Construct the LLS problem in matrix form: $A x tilde.equiv b$ and solve for the $Q R$ factorization $A = Q R$ using Gram-Schmidt.

  *Solution.* We want to minimize
  $
    (x_0 - x_1 + x_2 - 13)^2 +
    (x_0 - 8)^2 +
    (x_0 + x_1 + x_2 - 79)^2 +
    (x_0 + 2x_1 + 4x_2 - 206)^2. \
  $
  Then,
  $
    A x &= b \
    mat(
      1, -1, 1;
      1, 0, 0;
      1, 1, 1;
      1, 2, 4
    ) mat(
      x_0; x_1; x_2
    ) &= mat(
      13; 8; 79; 206
    )
  $
  Solving for $A = Q R$:
  $
    a_1 = mat(1; 1; 1; 1), quad
    a_2 = mat(-1; 0; 1; 2), quad
    a_3 = mat(1; 0; 1; 4), quad
  $
  $
    v_1 = a_1 = mat(1; 1; 1; 1) => q_1 = 1/2 mat(1; 1; 1; 1) \
    r_(11) = chevron.l q_1, a_1 chevron.r = 1/2 + 1/2 + 1/2 + 1/2 = 2
  $
  $
    r_(12) = chevron.l q_1, a_2 chevron.r = -1/2+0+1/2+1=1\
    v_2 = a_2 - r_(12) q_1 = mat(-1; 0; 1; 2) -  mat(1"/"2; 1"/"2; 1"/"2; 1"/"2) = mat(-3"/"2; -1"/"2; 1"/"2; 3"/"2) =>
    q_2 = 1/sqrt(9/4+1/4+1/4+9/4) mat(-3"/"2; -1"/"2; 1"/"2; 3"/"2) = 1/(2sqrt(5)) mat(-3; -1; 1; 3)
  $
  $
    r_(13) = chevron.l q_1, a_3 chevron.r = 1/2(1+1+4)=3 \
    r_(22) = chevron.l q_2, a_2 chevron.r = 1/(2sqrt(5))(3+1+6) = sqrt(5)\
    r_(23) = chevron.l q_2, a_3 chevron.r = 1/(2sqrt(5))(-3+1+12)=sqrt(5) \
  $
  $
    v_3 = a_3 - r_(13)q_1 - r_(23)q_2 = mat(1; 0; 1; 4) - 3/2 mat(1; 1; 1; 1) - 1/2 mat(-3; -1; 1; 3) = mat(1; -1; -1; 1) =>
    q_3 = 1/2 mat(1; -1; -1; 1) \
    r_(33) = chevron.l q_3, a_3 chevron.r = 1/2(1-1+4)=2
  $
  Therefore,
  $
    A = Q R = mat(
      1/2, -3/(2sqrt(5)), 1/2;
      1/2, -1/(2sqrt(5)), -1/2;
      1/2, 1/(2sqrt(5)), -1/2;
      1/2, 3/(2sqrt(5)), 1/2;
    ) mat(
      2, 1, 3;
      0, sqrt(5), sqrt(5);
      0, 0, 2
    ).
  $

+ Use the equation from Problem 2a to solve for $x$, then find the 2nd degree polynomial $p(lambda)$. 

  *Solution.* Substituting to $R x = Q^top b$:
  $
    mat(
      2, 1, 3;
      0, sqrt(5), sqrt(5);
      0, 0, 2
    ) mat(x_0; x_1; x_2) &= mat(
      1/2, 1/2, 1/2, 1/2;
      -3/(2sqrt(5)), -1/(2sqrt(5)), 1/(2sqrt(5)), 3/(2sqrt(5));
      1/2, -1/2, -1/2, 1/2
    ) mat(
      13; 8; 79; 206
    ) \ 
    &= mat(
      153; 325/sqrt(5); 66
    )
  $
  Then,
  $
    2x_2 = 66 => x_2 = 33 \
    sqrt(5) x_1 = 325/sqrt(5) - sqrt(5) x_2 => x_1 = 32 \
    2x_0 = 153 - x_1 - 3x_2 => x_0 = 11  
  $
  Therefore, the polynomial that best estimate the given data points is 
  $
    p(lambda) = 11 + 32 lambda + 33 lambda^2.
  $

#bibliography("../../../resources/bibs/compendium/le1/1.4_linear_least_squares.bib", style: "apa")
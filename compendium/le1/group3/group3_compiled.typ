#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)



== (Buenaventura)



#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
*Jacobi and Gauss-Seidel Exercises*
#line(length: 100%) 
+ Find the first two iterations of the Jacobi method for the following linear systems, using $bold(x)^((0)) = [0, 0, 0]$ (Burden & Faires, 2010, p. 459, Item 1.a):


$ 3 x_1 - x_2 + x_3 &= 1, \
      3 x_1 + 6 x_2 + 2 x_3 &= 0, \
      3 x_1 + 3 x_2 + 7 x_3 &= 4. $

+ Find the first two iterations of the Gauss-Seidel method for the following linear systems, using $bold(x)^((0)) = [0, 0, 0]$ (Burden & Faires, 2010, p. 460, Item 3):

$     3 x_1 - x_2 + x_3 &= 1, \
      3 x_1 + 6 x_2 + 2 x_3 &= 0, \
      3 x_1 + 3 x_2 + 7 x_3 &= 4. $


+ *[Item 01 Remix]* Find the Jacobi iteration matrix of item 01 and, without checking the SDD, determine if the algorithm converges.


+ *[Item 02 Remix]* Find the Gauss-Seidel iteration matrix of item 02 and, without checking the SDD, determine if the algorithm converges.]

=== Solutions
#line(length: 50%)

+ 
  From the system, we get this matrix,
    $ mat(
      3, -1, 1,| 1;
      3, 6, 2, | 0;
      3, 3, 7, | 4
    ) $

  Isolating x, we get the following equations:
    $ x_1 = (x_2 - x_3 + 1) / 3 $

    $ x_2 = (-3 x_1 - 2 x_3) / 6 $

    $ x_3 = (-3 x_1 - 3 x_2 + 4) / 7 $

    #v(1em)
  We then use the initial guess $x^((0))$ to determine the values of $x_1^((1)), x_2^((1)), "and" x_1^((1))$ 
    $ x_1^((1)) = (0 - 0 + 1) / 3 = 1/3 $

    $ x_2^((1)) = (0 - 0) / 6 = 0 $

    $ x_3^((1)) = (0 - 0 + 4) / 7 = 4/7 $

    #v(1.5em)

  We repeat the process and use $x^((1))$ to determine the values of $x_1^((2)), x_2^((2)), "and" x_1^((2))$ 
    $ x_1^((2)) = (0 - 4/7 + 1) / 3 = 1/7 $

    $ x_2^((2)) = (-3(1/3) - 2(4/7)) / 6 = -5/14 $

    $ x_3^((2)) = (-3(1/3) - 3(0) + 4) / 7 = 3/7 $

    #v(1.5em)

    #underline[Iteration Summary Table]

    #v(0.5em)

    #align(center)[
      #table(
        columns: (auto, 1cm, 1.2cm, 1.5cm),
        align: center + horizon,
        [], [*0*], [*1*], [*2*],
        [$x_1$], [$0$], [$1/3$], [$1/7$],
        [$x_2$], [$0$], [$0$], [$-5/14$],
        [$x_3$], [$0$], [$4/7$], [$3/7$],
      )
    ]

+ 
  Using the same x equations from item 01, we get the following values after applying Gauss-Seidel

  Iteration 1:
    $ x_1^((1)) = (0 - 0 + 1) / 3 = 1/3 $

    $ x_2^((1)) = (-3(1/3)-2(0)) / 6 = -1/6 $

    $ x_3^((1)) = (-3(1/3)-3(-1/6)+4) / 7 = 1/2 $

    #v(1.5em)

  Iteration 2:
    $ x_1^((2)) = (-1/6 - 1/2 + 1) / 3 = 1/9 $

    $ x_2^((2)) = (-3(1/9) - 2(1/2)) / 6 = -2/9 $

    $ x_3^((2)) = (-3(1/9) - 3(-2/9) + 4) / 7 = 13/21 $

    #v(1.5em)

    #underline[Iteration Summary Table]

    #v(0.5em)

    #align(center)[
      #table(
        columns: (auto, 1cm, 1.2cm, 1.5cm),
        align: center + horizon,
        [], [*0*], [*1*], [*2*],
        [$x_1$], [$0$], [$1/3$], [$1/9$],
        [$x_2$], [$0$], [$-1/6$], [$-2/9$],
        [$x_3$], [$0$], [$1/2$], [$13/21$],
      )
    ]


+ #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[

    Note that: $T_J = -D^(-1)(L + U) "and" A=D+L+U$
  ]

  $
  L = mat(
    0, 0, 0;
    3, 0, 0;
    3, 3, 0
  )
  #h(2em)
  U = mat(
    0, -1, 1;
    0, 0, 2;
    0, 0, 0
  )
  $

  $
  L + U = mat(
    0, -1, 1;
    3, 0, 2;
    3, 3, 0
  )
  $

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  D = mat(
    3, 0, 0;
    0, 6, 0;
    0, 0, 7
  )
  #h(2em)
  -D^(-1) = mat(
    -1/3, 0, 0;
    0, -1/6, 0;
    0, 0, -1/7
  )
  $

  $
  T_j = mat(
    -1/3, 0, 0;
    0, -1/6, 0;
    0, 0, -1/7
  )
  mat(
    0, -1, 1;
    3, 0, 2;
    3, 3, 0
  )
  $

  $
  T_j = #rect(inset: 6pt)[$
    mat(
      0, 1/3, -1/3;
      -1/2, 0, -1/3;
      -3/7, -3/7, 0
    )
  $]
  $

  #v(1em)
  * We now find $rho(T_j)$*

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  det(T_j - lambda I) = mat(
    delim: "|",
    -lambda, 1/3, -1/3;
    -1/2, -lambda, -1/3;
    -3/7, -3/7, -lambda
  ) = 0
  $

  $
  => (-lambda)(lambda^2 - 1/7) - (1/3)(1/2 lambda - 1/7) + (-1/3)(3/14 - 3/7 lambda) = 0
  $

  $
  => -lambda^3 + 1/7 lambda - 1/6 lambda + 1/21 - 1/14 + 1/7 lambda = 0
  $

  $
  => -lambda^3 + 5/42 lambda - 1/42 = 0
  $

  $
  => lambda_1 = -0.4193 => |lambda_1| = 0.4193
  $

  $
  lambda_(2,3) = 0.20966 +- 0.1132 i
  $

  $
  => |lambda_(2,3)| = sqrt((1/42) / (|lambda_1|)) approx 0.23829
  $

  #v(0.5em)
  $
  therefore rho(T_j) = |lambda_1| = 0.4193 < 1
  $

  $therefore$ *The Jacobi method will converge.*





+
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[

    Note that: $T_"GS" = -(D+L)^(-1)U "and" A=D+L+U$
  ]

  $
  D = mat(
    3, 0, 0;
    0, 6, 0;
    0, 0, 7
  )
  #h(2em)
  L = mat(
    0, 0, 0;
    3, 0, 0;
    3, 3, 0
  )
  $

  $
  D+L = mat(
    3, 0, 0;
    3, 6, 0;
    3, 3, 7
  )
  $

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  (D+L)^(-1) = mat(
    1/3, 0, 0;
    -1/6, 1/6, 0;
    -1/14, -1/14, 1/7
  )

  #h(2em)
-(D+L)^(-1) = mat(
    -1/3, 0, 0;
    1/6, -1/6, 0;
    1/14, 1/14, -1/7
  )
  $

  $
  T_"GS" = mat(
    -1/3, 0, 0;
    1/6, -1/6, 0;
    1/14, 1/14, -1/7
  )
  mat(
    0, -1, 1;
    0, 0, 2;
    0, 0, 0
  )
  $

  $
  T_"GS" = #rect(inset: 6pt)[$
    mat(
      0, 1/3, -1/3;
      0, -1/6, -1/6;
      0, -1/14, 3/14
    )
  $]
  $

  #v(1em)
  * We now find $rho(T_"GS")$*

  #line(length: 100%, stroke: 0.5pt + gray)

  $
  det(T_"GS" - lambda I) = mat(
    delim: "|",
    -lambda, 1/3, -1/3;
    0, -1/6-lambda, -1/6;
    0, -1/14, 3/14-lambda
  ) = 0
  $

  $
  => (-lambda)((-1/6 - lambda)(3/14 - lambda) - (-1/6)(-1/14)) = 0
  $

  $
  => -lambda((-1/28 + 1/6 lambda - 3/14lambda + lambda^2) - (1/84)) = 0
  $

  $
  => -lambda(lambda^2 - 1/21lambda - 1/21) = 0
  $

  $
  => lambda_1 = |(1+sqrt(85))/42| => |lambda_1| = 0.2433
  $

  $
  => lambda_2 = |(1-sqrt(85))/42| => |lambda_2| = 0.1957
  $

  $
  => |lambda_3| = 0
  $

  #v(0.5em)
  $
  therefore rho(T_"GS") = |lambda_1| = 0.2433 < 1
  $

  $therefore$ *The Gauss-Seidel method will converge.*

#line(length:100%)

== (Pagaduan)
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[ 
*Successive Over-Relaxation Exercises*
#line(length:100%)
1. Find the first two iterations of the SOR method with $omega=1.1$ for the following linear system, using $bold(x)^((0)) = [0, 0, 0]$ (Burden & Faires, 2010, p. 485, Item 1.b):

$ 10 x_1 - x_2 #h(34pt) &= 9, \
      - x_1 + 10 x_2 - 2 x_3 &= 7, \
      #h(34pt) - 2 x_2 + 10 x_3 &= 6. $
      
2. Determine if the matrix in item $1$ is both tridiagonal and positive definite. If so, find the optimal choice for $omega$. (Burden & Faires, 2010, p. 486, Item 7):

3. *[Item 1 and 2 Remix]* Given a tridiagonal and positive definite matrix, suppose we try to approximate $omega_"opt"$ by repeatedly taking the midpoint of a given search interval, starting at $(1, 2)$. In how many iterations would this method approximate $omega_"opt"$ to within an accuracy $epsilon$?  
]

=== Solutions
#line(length: 100%)
1. The system is equivalent to the coefficient matrix
  $
    mat(
      10, -1, 0;
      -1, 10, -2;
      0, -2, 10;
    )
  $
  The SOR method updates the $k^("th")$ approximation for $x_i$ using the following formula:
  $ x_i^((k))=(1-omega)x_i^((k-1))+omega/a_(i i)[b_i - sum_(j=1)^(i-1)a_(i j)x_j^((k)) - sum_(j=i+1)^n a_(i j)x_j^((k-1))] $
  Thus, with $omega=1.1$ and $x^((0)) = [0 #h(5pt) 0 #h(5pt) 0]^T$, the first iteration of the SOR method gives us
  $
  x_1^((1)) &= -0.1(0) + 0.11(9 + 0) = bold(0.99) \
  x_2^((1)) &= -0.1(0) + 0.11(7 + 0.99 + 0) = 0.11(7.99) = bold(0.8789) \
  x_3^((1)) &= -0.1(0) + 0.11(6 + 2(0.8789)) = 0.11(7.7578) = bold(0.853358)
  $
  The second iteration then gives us
  $
  x_1^((2)) &= -0.1(0.99) + 0.11(9 + 0.8789) = -0.099 + 1.086679 = bold(0.987679) \
  x_2^((2)) &= -0.1(0.8789) + 0.11(7 + 0.987679 + 2(0.853358)) = bold(0.978493) \
  x_3^((2)) &= -0.1(0.853358) + 0.11(6 + 2(0.97849345)) = bold(0.789933)
  $
  Thus, $x^((1)) = [0.99 #h(5pt) 0.8789 #h(5pt) 0.853358]^T$ and $x^((2)) = [0.987679 #h(5pt) 0.978493 #h(5pt) 0.789933]^T$.
#v(5pt)
2. First, we note that since we can observe that the the only nonzero entries of the matrix are found on its diagonal, subdiagonal, and superdiagonal, the matrix is tridiagonal. Furthermore, since the matrix is symmetric and strictly diagonally dominant, its eigenvalues are guaranteed to be greater than $0$. Thus, the matrix is positive definite as well.

  To find $omega_("opt")$, we utilize the following formula:\
  
  $
    omega_"opt"=(2)/(1+sqrt(1-[rho(T_J)]^2))
  $
  with $rho(T_J)$ as the spectral radius of the Jacobi iteration matrix, given by $T_J = -D^(-1)(L + U)$. Thus, we have
  $
    T_J = mat(1/10, 0, 0; 0, 1/10, 0; 0, 0, 1/10)mat(0, 1, 0; 1, 0, 2; 0, 2, 0) = mat(0, 1/10, 0; 1/10, 0, 1/5; 0, 1/5, 0)
  $
  Getting the eigenvalues of $T_J$, we have
  $
    det(T_J - lambda I) = mat(-lambda, 1/10, 0; 1/10, -lambda, 1/5; 0, 1/5, -lambda) = 0\
    -lambda(lambda^2-0.04) - 0.1(-0.1lambda) = 0\
    -lambda^3+0.04lambda+0.01lambda = 0\
    -lambda(lambda^2-0.05) = 0
  $
  Thus, $lambda_1=0$, $lambda_2=-(sqrt(5))/10$, and $lambda_3=sqrt(5)/10=rho(T_J)$.
  Plugging values into the formula yields us
  $
    omega_("opt") = 2/(1+sqrt(1-(sqrt(5)/10)^2))=2/(1+sqrt(1-1/20))=2/(1+sqrt(19/20))=2/((10+sqrt(95))/10)=1.0128
  $
  $therefore omega_"opt"=1.0128$.\
  
3. First, we must decide in which direction we search for $omega_"opt"$. Given the midpoint of the current interval, say $m$, we find $T_omega$ at $omega=m$. Then, we pick a test value for $omega$ that is close to $m$, but is either less than $m$ or greater than $m$. Let $T_(omega)$ be the SOR iteration matrix for $omega=m$, and $T_omega^*$ be the SOR iteration matrix for the test value. We then compare the value of their spectral radius:
  - If $rho(T_omega^*) < rho(T_omega)$, then picking a lesser value for $omega$ improves convergence. Thus, the next search interval we evaluate is $(1, omega^*]$.
  - If $rho(T_omega^*) > rho(T_omega)$, then picking a greater value for $omega$ improves convergence. Thus, the next search interval must be $[omega^*, 2)$.
  - If $omega_"opt"=m$, then picking test values in either direction results in a larger value for their spectral radius.
  Thus, eventually, this method will find $omega_"opt"$, albeit _very, very slowly_.\
  However, in how many iterations will it take?
  Given a search interval $[a, b]$ with length \
  $L=b-a$, after $n$ iterations, its length will eventually shrink to $(b-a)/2^n$. Keeping our approximation within a certain accuracy $epsilon$, we get the inequality \
  $
    (b-a)/2^n<=epsilon->2^n>=(b-a)/epsilon->n>=log_2((b-a)/epsilon)->n=ceil(log_2((b-a)/epsilon))
  $. \
  Thus, for example, if we want an accuracy of $epsilon=plus.minus 0.001$, the method will terminate in \
  $ n = ceil(log_2(1/0.001)) = ceil(9.9658) = 10$ iterations.
  

== (Aguilar)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[

*Iterative Refinement Exercises*
#line(length: 100%) 
  + *(i)* Use Gaussian elimination and three-digit rounding arithmetic to approximate the solutions to the following linear systems. *(ii)* Then use one iteration of iterative refinement to improve the approximation, and compare the approximations to the actual solutions

    $ 0.03x_1 + 58.9x_2 = 59.2, $
    $ 5.31x_1 - 6.10x_2 = 47.0, $
    
    Actual solution: $(10,1)^t$.
    
  + The linear system $ mat(1,2;1.0001,2) mat(x_1;x_2) = mat(3;3.0001) $ has solution $(1,1)^t$.
    
    Change $A$ slightly to $ mat(1,2;0.9999,2), $ and consider the linear system  $ mat(1,2;0.9999,2) mat(x_1;x_2) = mat(3;3.0001). $

    Compute the new solution using five-digit rounding arithmetic, and compare the actual error to the estimate $(7.25)$. Is $A$ ill-conditioned?
  
  + *[Item 01 Remix]* Use Gaussian elimination and three-digit rounding arithmetic to approximate the solutions to the following linear system. Then use one iteration of iterative refinement to improve the approximation, and compare the approximations to the actual solution.

    $ 0.04x_1 + 61.5x_2 = 123.4, $
    $ 4.21x_1 - 5.30x_2 = 31.5, $

    Actual solution: $(10,2)^t$.
    
  + *[Item 02 Remix]* The linear system $ mat(2,3;2.0001,3) mat(x_1;x_2) = mat(5;5.0001) $ has solution $(1,1)^t$.

    Change $A$ slightly to $ mat(2,3;1.9999,3), $ and consider the linear system $ mat(2,3;1.9999,3) mat(x_1;x_2) = mat(5;5.0001). $

    Compute the new solution using five-digit rounding arithmetic, compute the condition number $kappa(A)$, and use it to estimate the relative error bound. Compare this estimate to the actual relative error. Is $A$ ill-conditioned?
]

== Solutions
#line(length: 50%)

=== Item 1
#pad(left: 2em)[

  We get the following linear system:
  $ mat(0.03, 58.9; 5.31, -6.10) mat(x_1; x_2) = mat(59.2; 47.0) $
  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 5.31/0.03 = 177.$
  #pad(left: 2em)[
    $R_21 <- 5.31 - 177(0.03) = 0$
  
    $R_22 <- -6.10 - 177(58.9) approx -6.10 - 10400 approx -10400$
  
    $b_2 <- 47.0 - 177(59.2) approx 47.0 - 10500 approx -10500$
  
    We obtain
  
    $ mat(0.03, 58.9; 0, -10400) mat(x_1; x_2) = mat(59.2; -10500). $
    Using back substitution:
    $ x_2 = (-10500)/(-10400) = 1.009 approx 1.01 $
    $ 0.03 x_1 + 58.9(1.01) = 59.2 $
    $ 0.03x_1 + 59.5 = 59.2 $
    $ 0.03x_1 = 59.2-59.5 $
    $ 0.03x_1 = -0.3 $
    $ x_1 = -10 $
  
    We get the approximate solution $hat(x) = [-10, 1.01]^T$
]
  *ii.* Next, we apply iterative refinement and compare the approximations to the actual solution.
  #pad(left: 2em)[
    Get the residual $r = b - A hat(x)$.
    $ r = mat(59.2; 47) - mat(0.03,58.9;5.31,-6.10) mat(-10;1.01) $

    $ (0.03)(-10)+(58.9)(1.01) = 59.189 $
    $ (5.31)(-10)+(-6.10)(1.01) = -59.261 $
    $ r = mat(59.2 - 59.189; 47+59.261) = mat(0.011; 106.261) $

    Solve for $A delta = r$ where $delta = A^(-1)r.$

    First we solve for $A x = [1, 0]^T$

    $ L = mat(1,0;177,1), space U = mat(0.03,58.9;0,-10431.4) $
    Solve for $L y = mat(1;0)$
    $ mat(1,0;177,1) mat(y_1; y_2) = mat(1;0), space y = mat(1;-177) $
    Solve for $U x = y$
    $ mat(0.03,58.9;0,-10431.4) mat(x_1; x_2) = mat(1;-177) $
    $ x_2 = 177/10431.4 = 0.016968 $
    $ 0.03x_1 + 58.9(0.016968) = 1 $
    $ x_1 = 0.019493 $
    Which forms the first column of $ A^(-1) = mat(0.019493, ?; 0.016968, ?) $

    Next we solve for $A x = [0, 1]^T$

    Solve for $L y = mat(0;1)$
    $ mat(1,0;177,1) mat(y_1; y_2) = mat(0;1), space y = mat(0;1) $
    Solve for $U x = y$
    $ mat(0.03,58.9;0,-10431.4) mat(x_1; x_2) = mat(0;1) $
    $ x_2 = -0.0000959 $
    $ 0.03x_1 + 58.9(-0.0000959) = 0 $
    $ x_1 = 0.188283 $
    Which forms the second column of $ A^(-1) = mat(0.019493, 0.188283; 0.016968, -0.0000959) $

    Solve for $delta = A^(-1)r.$
    $ delta = mat(0.019493,0.188283;0.016968,-0.0000959) mat(0.011;106.261) $
    $ (0.019493)(0.011) + (0.188283)(106.261) = 20.007359 approx 20.007 $
    $ (0.016968)(0.011) + (-0.0000959)(106.261) = -0.0100037819 approx -0.01 $

    We get
    $ hat(x)_"new" = hat(x) + delta = mat(-10;1.01) + mat(20.007;-0.01) = mat(10.007;1) $
    $ r_"new" = b - A hat(x)_"new" = mat(59.2;47) - mat(0.03,58.9;5.31,-6.10) mat(10.007;1) $
    $ = mat(59.2;47) - mat(59.20021;47.03717) = mat(-0.00021;-0.03717) $

    Which is significantly smaller than our initial $r$.
  ]
]
#line(length: 100%)

=== Item 2
#pad(left: 2em)[

  The original system
  $ mat(1,2;1.0001,2) mat(x_1;x_2) = mat(3;3.0001) $
  has exact solution $hat(x) = (1,1)^T$. We now perturb $A$ slightly to
  $ mat(1,2;0.9999,2) mat(x_1;x_2) = mat(3;3.0001) $
  and solve using five-digit rounding arithmetic.

  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 0.9999/1 = 0.9999$.
  #pad(left: 2em)[
    $R_21 <- 0.9999 - 0.9999(1) = 0$

    $R_22 <- 2 - 0.9999(2) = 2 - 1.9998 = 0.0002$

    $b_2 <- 3.0001 - 0.9999(3) = 3.0001 - 2.9997 = 0.0004$

    We obtain

    $ mat(1,2;0,0.0002) mat(x_1;x_2) = mat(3;0.0004). $
    Using back substitution:
    $ x_2 = 0.0004/0.0002 = 2.0000 $
    $ x_1 + 2(2.0000) = 3 $
    $ x_1 = 3 - 4 $
    $ x_1 = -1.0000 $

    We get the approximate solution $hat(x) = [-1.0000, 2.0000]^T$
  ]

  *ii.* Next, we compute the actual error and compare it to the estimate given by (7.25).
  #pad(left: 2em)[
    Comparing to the exact solution of the original system, $x = (1,1)^T$:
    $ norm(x - hat(x))_infinity = norm(mat(1-(-1);1-2))_infinity = norm(mat(2;-1))_infinity = 2 $

    So $A$ changing by only $0.0002$ in one entry moved the solution by $2$ — a change of $200%$.

    We compute the perturbation $delta A = A' - A$:
    $ delta A = mat(1,2;0.9999,2) - mat(1,2;1.0001,2) = mat(0,0;-0.0002,0) $
    $ norm(delta A)_infinity = max(0, 0.0002) = 0.0002 $

    We compute $norm(A)_infinity$:
    $ norm(A)_infinity = max(1+2, 1.0001+2) = 3.0001 $

    So the relative perturbation is
    $ norm(delta A)_infinity/norm(A)_infinity = 0.0002/3.0001 approx 6.67 times 10^(-5) $

    Next we compute $K_infinity (A) = norm(A)_infinity norm(A^(-1))_infinity$.
    $ det A = 1(2) - 2(1.0001) = -0.0002 $
    $ A^(-1) = 1/(-0.0002) mat(2,-2;-1.0001,1) = mat(-10000,10000;5000.5,-5000) $
    $ norm(A^(-1))_infinity = max(10000+10000, 5000.5+5000) = 20000 $
    $ K_infinity (A) = (3.0001)(20000) approx 6.0 times 10^4 $

    Using estimate (7.25):
    $ (norm(x-hat(x)))/(norm(hat(x))) <= K_infinity (A) dot (norm(delta A)_infinity)/(norm(A)_infinity) approx (6.0 times 10^4)(6.67 times 10^(-5)) approx 4.0 $

    The actual relative error is
    $ (norm(x-hat(x))_infinity)/(norm(hat(x))_infinity) = 2/2 = 1 $

    which is well within the bound of $approx 4.0$ given by (7.25), confirming the estimate is consistent with the observed behavior.

    Since $K_infinity (A) approx 6.0 times 10^4$ is very large, a tiny relative change in $A$ (about $0.0067%$) produced a large relative change in the solution ($100%$, with the solution's sign effectively flipping). Therefore, *$A$ is ill-conditioned*.
  ]
]

#line(length: 100%)

=== Item 1 - Remix
#pad(left: 2em)[

  We get the following linear system:
  $ mat(0.04, 61.5; 4.21, -5.30) mat(x_1; x_2) = mat(123.4; 31.5) $
  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 4.21/0.04 = 105.25 approx 105.$
  #pad(left: 2em)[
    $R_21 <- 4.21 - 105(0.04) = 0.01 approx 0$

    $R_22 <- -5.30 - 105(61.5) approx -5.30 - 6460 approx -6470$

    $b_2 <- 31.5 - 105(123.4) approx 31.5 - 13000 approx -13000$

    We obtain

    $ mat(0.04, 61.5; 0, -6470) mat(x_1; x_2) = mat(123.4; -13000). $
    Using back substitution:
    $ x_2 = (-13000)/(-6470) = 2.0093 approx 2.01 $
    $ 0.04 x_1 + 61.5(2.01) = 123.4 $
    $ 0.04x_1 + 124 = 123.4 $
    $ 0.04x_1 = 123.4-124 $
    $ 0.04x_1 = -0.600 $
    $ x_1 = -15.0 $

    We get the approximate solution $hat(x) = [-15.0, 2.01]^T$
]
  *ii.* Next, we apply iterative refinement and compare the approximations to the actual solution.
  #pad(left: 2em)[
    Get the residual $r = b - A hat(x)$.
    $ r = mat(123.4; 31.5) - mat(0.04,61.5;4.21,-5.30) mat(-15.0;2.01) $

    $ (0.04)(-15.0)+(61.5)(2.01) = 123.015 $
    $ (4.21)(-15.0)+(-5.30)(2.01) = -73.803 $
    $ r = mat(123.4 - 123.015; 31.5-(-73.803)) = mat(0.385; 105.303) $

    Solve for $A delta = r$ where $delta = A^(-1)r.$

    First we solve for $A x = [1, 0]^T$

    $ L = mat(1,0;105,1), space U = mat(0.04,61.5;0,-6470) $
    Solve for $L y = mat(1;0)$
    $ mat(1,0;105,1) mat(y_1; y_2) = mat(1;0), space y = mat(1;-105) $
    Solve for $U x = y$
    $ mat(0.04,61.5;0,-6470) mat(x_1; x_2) = mat(1;-105) $
    $ x_2 = 105/6470 = 0.016229 $
    $ 0.04x_1 + 61.5(0.016229) = 1 $
    $ x_1 = 0.0479125 $
    Which forms the first column of $ A^(-1) = mat(0.0479125, ?; 0.016229, ?) $

    Next we solve for $A x = [0, 1]^T$

    Solve for $L y = mat(0;1)$
    $ mat(1,0;105,1) mat(y_1; y_2) = mat(0;1), space y = mat(0;1) $
    Solve for $U x = y$
    $ mat(0.04,61.5;0,-6470) mat(x_1; x_2) = mat(0;1) $
    $ x_2 = -0.0001546 $
    $ 0.04x_1 + 61.5(-0.0001546) = 0 $
    $ x_1 = 0.237698 $
    Which forms the second column of $ A^(-1) = mat(0.0479125, 0.237698; 0.016229, -0.0001546) $

    Solve for $delta = A^(-1)r.$
    $ delta = mat(0.0479125,0.237698;0.016229,-0.0001546) mat(0.385;105.303) $
    $ (0.0479125)(0.385) + (0.237698)(105.303) = 25.049 $
    $ (0.016229)(0.385) + (-0.0001546)(105.303) = -0.010032 $

    We get
    $ hat(x)_"new" = hat(x) + delta = mat(-15.0;2.01) + mat(25.049;-0.010032) = mat(10.049;2.00) $
    $ r_"new" = b - A hat(x)_"new" = mat(123.4;31.5) - mat(0.04,61.5;4.21,-5.30) mat(10.049;2.00) $
    $ = mat(123.4;31.5) - mat(123.402;31.706) = mat(-0.002;-0.206) $

    Which is significantly smaller than our initial $r$, and much closer to the actual solution $(10,2)^T$.
  ]
]
#line(length: 100%)

=== Item 2 - Remix
#pad(left: 2em)[

  The original system
  $ mat(2,3;2.0001,3) mat(x_1;x_2) = mat(5;5.0001) $
  has exact solution $hat(x) = (1,1)^T$. We now perturb $A$ slightly to
  $ mat(2,3;1.9999,3) mat(x_1;x_2) = mat(5;5.0001) $
  and solve using five-digit rounding arithmetic.

  *i.* Using Gaussian Elimination, we calculate the multiplier $m = 1.9999/2 = 0.99995$.
  #pad(left: 2em)[
    $R_21 <- 1.9999 - 0.99995(2) = 1.9999 - 1.9999 = 0$

    $R_22 <- 3 - 0.99995(3) = 3 - 2.99985 = 0.00015$

    $b_2 <- 5.0001 - 0.99995(5) = 5.0001 - 4.99975 = 0.00035$

    We obtain

    $ mat(2,3;0,0.00015) mat(x_1;x_2) = mat(5;0.00035). $
    Using back substitution:
    $ x_2 = 0.00035/0.00015 = 2.3333 $
    $ 2x_1 + 3(2.3333) = 5 $
    $ 2x_1 + 6.9999 = 5 $
    $ 2x_1 = 5 - 6.9999 $
    $ 2x_1 = -1.9999 $
    $ x_1 = -0.99995 approx -1.0000 $

    We get the approximate solution $hat(x) = [-1.0000, 2.3333]^T$
  ]

  *ii.* Next, we compute the condition number $kappa(A)$ and use it to estimate the relative error bound, then compare it to the actual relative error.
  #pad(left: 2em)[
    We compute $norm(A)_infinity$:
    $ norm(A)_infinity = max(2+3, 2.0001+3) = 5.0001 $

    We compute $A^(-1)$:
    $ det A = 2(3) - 3(2.0001) = 6 - 6.0003 = -0.0003 $
    $ A^(-1) = 1/(-0.0003) mat(3,-3;-2.0001,2) = mat(-10000,10000;6667.0,-6666.7) $
    $ norm(A^(-1))_infinity = max(10000+10000, 6667.0+6666.7) = max(20000,13333.7) = 20000 $

    So the condition number is
    $ kappa_infinity (A) = norm(A)_infinity dot norm(A^(-1))_infinity = (5.0001)(20000) approx 1.0 times 10^5 $

    We compute the perturbation $delta A = A' - A$:
    $ delta A = mat(2,3;1.9999,3) - mat(2,3;2.0001,3) = mat(0,0;-0.0002,0) $
    $ norm(delta A)_infinity = max(0, 0.0002) = 0.0002 $

    So the relative perturbation is
    $ norm(delta A)_infinity/norm(A)_infinity = 0.0002/5.0001 approx 4.0 times 10^(-5) $

    Using estimate (7.25), the relative error bound is
    $ (norm(x-hat(x)))/(norm(hat(x))) <= kappa_infinity (A) dot (norm(delta A)_infinity)/(norm(A)_infinity) approx (1.0 times 10^5)(4.0 times 10^(-5)) approx 4.0 $

    Comparing to the exact solution of the original system, $x = (1,1)^T$:
    $ norm(x - hat(x))_infinity = norm(mat(1-(-1.0000);1-2.3333))_infinity = norm(mat(2.0000;-1.3333))_infinity = 2.0000 $

    The actual relative error is
    $ (norm(x-hat(x))_infinity)/(norm(hat(x))_infinity) = 2.0000/2.3333 approx 0.8571 $

    which is well within the bound of $approx 4.0$ given by (7.25), confirming the estimate is consistent with the observed behavior.

    Since $kappa_infinity (A) approx 1.0 times 10^5$ is very large, a tiny relative change in $A$ (about $0.004%$) produced a large relative change in the solution ($approx 85.7%$). Therefore, *$A$ is ill-conditioned*.
  ]
]

#line(length: 100%)

== (Camacho)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
*Iterative Refinement Practice Problems*
#line(length: 100%)
  + *Problem 1: One Step of Refinement with a Reused LU.* Let
    $ A = mat(2,1;1,3), quad b = mat(3;4), quad L = mat(1,0;0.5,1), quad U = mat(2,1;0,2.5), $
    where $A = L U$. A previous solve in limited precision produced $hat(x) = (1.1, 0.9)^T$.

    #[
      #set enum(numbering: "a)")
      + Compute the residual $r = b - A hat(x)$.
      + Using the given $L$ and $U$ (*not* by re-eliminating $A$), solve $L y = r$ by forward substitution, then $U delta = y$ by back substitution.
      + Update $hat(x)$ and compute the new residual. What does it tell you?
      + Verify by substitution that $A(hat(x) + delta) = b$.
    ]

  + *Problem 2: Mixed Precision and Conditioning.* You solve two systems in single precision (unit roundoff $u approx 6 times 10^(-8)$) using LU factorization, then apply iterative refinement. System I has $kappa(A) = 10^4$. System II has $kappa(A) = 10^9$.

    #[
      #set enum(numbering: "a)")
      + In fixed-precision refinement, roughly what is the best relative forward error you can hope for in each system? (Use the estimate $kappa(A) dot u$.)
      + For which system do you expect refinement to succeed, and for which to stagnate or fail? Explain using
        $ norm(hat(x) - x) / norm(x) <= kappa(A) norm(r) / norm(b). $
      + A classmate says: "Just run more refinement steps on System II and it will eventually fix itself." Explain why this is wrong.
      + Explain why computing $r = b - A hat(x)$ in extended (double) precision helps, while the two triangular solves can stay in single precision. Name the numerical phenomenon involved.
    ]

  + *Remix Question.* Take $n = 1000$ and use these flop counts: LU factorization $approx 2/3 n^3$; residual computation $approx 2 n^2$; each triangular solve $approx n^2$.

    #[
      #set enum(numbering: "a)")
      + Estimate the flops for the initial factorization and for *one* refinement step. What percentage of the factorization cost do 3 refinement steps add?
      + Compare this with re-factorizing $A$ from scratch at each of 3 correction steps. Roughly how many times more expensive is that?
      + Successive corrections satisfy $norm(delta^((0))) = 2 times 10^(-2)$, $norm(delta^((1))) = 4 times 10^(-4)$, $norm(delta^((2))) = 8 times 10^(-6)$, and $norm(hat(x)) approx 2$ throughout. With the stopping test $norm(delta) \/ norm(hat(x)) < 10^(-5)$, after which step does the algorithm stop?
      + Estimate the per-step error reduction factor from the $delta$ sequence. Is this behavior closer to linear or quadratic convergence?
      + State two differences between iterative refinement and Gauss-Seidel.
    ]
]

=== Solutions
#line(length: 50%)

=== Item 1
#pad(left: 2em)[
  #set enum(numbering: "a)")
  + $A hat(x) = mat(2(1.1)+1(0.9); 1(1.1)+3(0.9)) = mat(3.1; 3.8)$, so
    $ r = b - A hat(x) = mat(3-3.1; 4-3.8) = mat(-0.1; 0.2). $
  + Forward substitution, $L y = r$:
    $ y_1 = -0.1, quad y_2 = 0.2 - 0.5(-0.1) = 0.25. $
    Back substitution, $U delta = y$:
    $ delta_2 = 0.25 / 2.5 = 0.1, quad delta_1 = (-0.1 - 1(0.1)) / 2 = -0.1. $
    So $delta = (-0.1, 0.1)^T$.
  + $hat(x)_"new" = hat(x) + delta = (1.0, 1.0)^T$, which is the exact solution, so $r_"new" = (0, 0)^T$ and no further refinement is needed. In real floating-point arithmetic the new residual would be tiny but generally nonzero.
  + $A(hat(x) + delta) = A hat(x) + A delta = A hat(x) + r = A hat(x) + b - A hat(x) = b$.
]
#line(length: 100%)

=== Item 2
#pad(left: 2em)[
  #set enum(numbering: "a)")
  + System I: $10^4 times 6 times 10^(-8) approx 6 times 10^(-4)$, so roughly 3 correct digits. System II: $10^9 times 6 times 10^(-8) approx 60$, so essentially no guaranteed accuracy.
  + Refinement works on System I. On System II the bound exceeds $1$, so even a small residual guarantees nothing about the error, and refinement will stagnate or fail to converge.
  + Refinement only removes error caused by the *algorithm's* rounding. Error caused by the *problem's* sensitivity (large $kappa(A)$) sets a floor, roughly $kappa(A) dot u$, that no number of extra steps can go below.
  + Once $hat(x)$ is close to $x$, computing $b - A hat(x)$ subtracts two nearly equal numbers, which is *catastrophic cancellation*. Extended precision protects the residual, which carries the information for the next correction. The correction $delta$ only needs to be approximate, so single precision is enough for the triangular solves.
]
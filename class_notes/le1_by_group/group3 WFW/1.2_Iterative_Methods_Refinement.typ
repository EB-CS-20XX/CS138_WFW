#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)

= Section 1: Iterative Methods for Solving Linear Systems
#line(length: 100%)

== 1.1 What are Iterative Methods?
#pad(left: 2em)[
  === 1.1.1 Definition
  *Iterative methods* are algorithms used to solve systems of linear equations. Compared to direct methods, iterative methods are much more efficient at processing sparse matrices (i.e., large systems with a high percentage of zero entries).
  
  === 1.1.2 General Algorithm  
  Iterative methods generally start with some linear system _Ax=b_ and an initial guess $x^((0))$, which is used to generate a sequence of vectors $lr(\{ bold(x)^((k)) \})_(k=0)^oo$ that converge to x. More explicitly, we get this equation: $x^((k)) = T x^((k-1)) + c$, where _T_ is the iteration matrix.

  *Note:* $x^((k)) = T x^((k-1)) + c$ converges to the exact solution $x$ for any $x^((0))$ if and only if $rho(T)<1$. 

  === 1.1.3 Initial Guess *$x^((0))$* 
  The initial guess $x^((0))$ is often just the zero vector. However, in cases when additional information is available, a better guess may be used, which significantly reduces the number of iterations required to produce a result below a given error tolerance.

  *Note:* In well-behaved systems (e.g., SDD matrices), convergence to the exact solution is guaranteed mathematically.
]

== 1.2 Concepts to Recall
#pad(left: 2em)[
  === 1.2.1 Matrix Norms 
    #pad(left: 1em)[
      - Two Norm $||A||_2 = sqrt(lambda_("max")(A^T A))$
      - Infinity Norm $||A||_oo = max_(1 <= i <= n) sum_(j=1)^n |a_(i j)|$
    ]
  === 1.2.2 Norm Properties
  #pad(left: 1em)[
    + Non-negativity: $||A|| >= 0;$
    + Definiteness: $||A|| = 0$, iff $A$ is a matrix with all 0 entries;
    + Homogeneity $||alpha A|| = |alpha| ||A||$, for any scalar $alpha;$
    + Triangle Inequality: $||A + B|| <= ||A|| + ||B||;$
    + Submultiplicativity: $||A B|| <= ||A|| ||B||.$]
  
  === 1.2.3 Convergent Matrices
  
  A square matrix A is convergent if: 
$ lim_(k -> oo) (A^k)_(i j) = 0, quad "for each" i = 1, 2, ..., n "and" j = 1, 2, ..., n. $
  
  *Remark:* This only occurs when $rho(A)<1$

  === 1.2.4 Spectral Radius ($rho$)
  The spectral radius is the magnitude of the largest possible eigenvalue of matrix A: $rho(A) = max_(1 <= i <= n) |lambda_i|$. It is especially relevant for determining if a given iterative method converges for any arbitrary initial vector $x^((0))$. Specifically, given an iteration matrix $T$, it can be said that the iterative method is convergent when $rho(T) < 1$. 

  === 1.2.5 *Strictly Diagonally Dominant Matrix (SDD)*
  A square matrix is strictly diagonally dominant (SDD) when the magnitude of the diagonal entry in each row is greater than the sum of the magnitude of the non-diagonal entries on the same row.

  $ |a_(i i)| > sum_(j=1, j != i)^n |a_(i j)|, quad "for" i = 1, 2, ..., n $

  *Note:* When a matrix $A$ is SDD, then it is guaranteed to be non-singular and that the associated iteration matrices are convergent (i.e., $rho(T) < 1$).
]

== 1.3 List of Iterative Methods
#pad(left: 2em)[

  
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  === 1.3.1 Jacobi Method
  #line(length: 100%)

  ==== Algorithm
  In essence, the Jacobi method solves for new x-values, then uses the x-value gained from the previous iteration to solve the x-values of the next iteration.

  ==== *Requirements:* 
  (i) Square Matrix, (ii) Linear, (iii) Non-Zero Diagonal Entries, (iv) Ideally SDD to Ensure Convergence

  ==== Matrix Form (A = D+L+U)
  // #line(length: 40%)
  $ x^((k)) = -D^(-1)(L + U)x^(k-1) + D^(-1)b $
  $ T_J = -D^(-1)(L + U), " " c_J = D^(-1)b $

  ==== Component Form
  $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1, j != i)^n a_(i j) x_j^(k-1) ) $
  
]


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  === 1.3.2 Gauss-Seidel Method
  #line(length: 100%)

  ==== Algorithm
  In essence, the Gauss-Seidel method solves for new x-values, then immediately uses the new x-value to solve for the succeeding x-value.

  ==== *Requirements:* 
  (i) Square Matrix, (ii) Linear, (iii) Non-Zero Diagonal Entries, (iv) Ideally SDD to Ensure Convergence
  
  ==== Matrix Form (A = D+L+U)
  // #line(length: 40%)
  $ x^((k)) = -(D + L)^(-1) U x^(k-1) + (D + L)^(-1) b $
  $ T_"GS" = -(D + L)^(-1) U, " " c_"GS" = (D + L)^(-1) b $

  ==== Component Form
  $ x_i^((k)) = 1/a_(i i) ( b_i - sum_(j=1)^(i-1) a_(i j) x_j^(k) - sum_(j=i+1)^n a_(i j) x_j^(k-1) ) $
]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  === 1.3.3 Successive Over-Relaxation
  #line(length: 100%)
  
  ==== Algorithm
  The successive relaxation method (or the SOR method, for short) produces a new estimate for an x-value by calculating the weighted average of the previous x-value and the Gauss-Seidel estimate.
  
  ==== Requirements:
  (i) Square Matrix, (ii) Linear, (iii) Ideally SDD as well to ensure convergence, (iv) Ideally Tridiagonal, (v) Valid Relaxation Factor $omega$
    - For the relaxation factor $omega$ to be valid, it must fall in the interval $0<omega<2$.
      - If $0<omega<1$, then the new estimate is found between the previous estimate and the Gauss-Seidel estimate. Thus, the algorithm is called "under-relaxation".
      - If $omega=1$, then the method for finding the new estimate simply becomes the Gauss-Seidel method.
      - If $1<omega<2$, then the new estimate is found beyond the Gauss-Seidel estimate. This algorithm is called "over-relaxation."
      
  ==== Matrix-Form (A = D+L+U)
  $ x^((k)) = (D-omega L)^(-1)[(1-omega)D+omega U]x^((k -1))+omega(D-omega L)^(-1)b $
  $ T_omega = (D-omega L)^(-1)[(1-omega)D+omega U], c_omega = omega(D-omega L)^(-1) $
  ==== Component Form
  $ x_i^((k))=(1-omega)x_i^((k-1))+omega/a_(i i)[b_i - sum_(j=1)^(i-1)a_(i j)x_j^((k)) - sum_(j=i+1)^n a_(i j)x_j^((k-1))] $
    ]
  ]
\
== 1.4 Theorems Relevant to Iterative Methods
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  #set heading(hanging-indent: 78pt)
  ==== Theorem 1.4.1 #h(5pt) #text(weight: "regular")[For any $x^((0)) in RR$, the sequence ${x^((k))}^infinity_(k=0)$ defined by $x^((k))=T x^((k-1))+c$, for #v(0pt) each $k>=1$, converges to the unique solution of $x = T x+c$ if and only if $rho(T) < 1$.]
  #set heading(hanging-indent: 0pt)
  #v(10pt)
  #set heading(hanging-indent: 39pt)
  ==== Proof: #h(5pt) #text(weight: "regular")[First, we show that if $rho(T)<1$, then the sequence as described converges to the unique solution $x = T x+c$.\ 
  #v(5pt)
  Assume that $rho(T)<1$. Then, it follows that\
  $x^((k))=T x^((k-1)) + c$\
  #h(20pt) $=T(T x^((k-2))+c)+c$\
  #h(20pt) $=T^2x^((k-2))+(T + I)c$\
  #h(20pt) $dots.v$\
  #h(20pt) $=T^k x^((0))+(T^(k-1) + dots + T + I)c$\
  #v(5pt)
  Since $rho(T)<1$, T is therefore convergent, and $lim_(k->infinity) T^k x^((0))=0$. Additionally, there exists $(I-T)^(-1)$ such that $(I-T)^(-1)=I+T+T^2+dots+sum_(j=0)^(n)T^j$.\
  Thus, $lim_(k->infinity)x^((k))=lim_(k->infinity) T^k x^((0))+(sum_(j=0)^(n)T^j)c=(I-T)^(-1)c$.\
  Multiplying both sides by $(I-T)$, we get $x(I-T)=c$. Distributing $x$ yields the equation $x-T x=c$, or $x=T x +c$ Thus, the sequence converges to the vector $x=T x+c$.\
  #v(5pt)
  Next, we show that if the sequence converges to the unique solution $x = T x+c$, then $rho(T) < 1$.
  #v(5pt)
  Let $z in RR^n$ be an arbitrary vector. and $x$ be the unique solution to $x=T x+c$. We define $x^((0))=x-z$, and, for $k >= 1$, $x^((k))=T x^((k-1))+c$. Then, ${x^((k))}$ converges to $x$. Note that \
  $x-x^((k))=(T x+c)-(T x^((k-1))+c)$\
  #h(40pt) $=T(x-x^((k-1)))$\
  #h(40pt) $=T^2(x-x^((k-2)))$\
  #h(40pt) $dots.v$\
  #h(40pt) $=T^k (x-x^((0)))$\
  #h(40pt) $=T^k z$\
  #v(5pt)
  Thus, $lim_(k->infinity) T^k z=lim_(k->infinity) T^k (x-x^((0)))=lim_(k->infinity)(x-x^((k)))=0$.\ 
  Since $z in RR^n$ is arbitrary, it follows that T is convergent, and that $rho(T)<1$.
]
  #set heading(hanging-indent: 0pt)
]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  #set heading(hanging-indent: 78pt)
  ==== Theorem 1.4.2 #h(5pt) #text(weight: "regular")[If a matrix $A$ is SDD, then for any choice $x^((0))$, both the Jacobi and the Gauss-Seidel methods give sequences ${x^((k))}^infinity_(k=0)$ that converge to the unique solution of $A x=b$.]
  #set heading(hanging-indent: 0pt)
]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  #set heading(hanging-indent: 78pt)
  ==== Theorem 1.4.3 #h(5pt) #text(weight: "regular")[_Also known as the *Stein-Rosenberg Theorem*._ If $a_(i j) <= 0$, for each $i != j$ and $a_(i i) > 0$, for each $i=1,2,3,dots, n$, then one and only one of the following statements hold:\
  #v(5pt)
  1) $0<=rho(T_(G S))<=rho(T_J)<1$\
  2) $1<rho(T_J)<rho(T_(G S))$\
  3) $rho(T_J)=rho(T_(G S))=0$\
  4) $rho(T_J)=rho(T_(G S))=1$
]
]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  #set heading(hanging-indent: 78pt)
  ==== Theorem 1.4.4 #h(5pt) #text(weight: "regular")[_Also known as *Kahan's Theorem*._ If $a_(i i) != 0$, for each $i=1,2,3,dots, n$, then $rho(T_omega)>=abs(omega - 1)$. This implies that the SOR method only converges when \
  $0<omega<2$.]
  #set heading(hanging-indent: 0pt)
  #set heading(hanging-indent: 39pt)
  ==== Proof: #h(5pt) #text(weight: "regular")[The iteration matrix for SOR is given by $T_omega=(D-omega L)^(-1)[(1-omega)D+omega U]$. Getting the determinant of $T_omega$, we get $det(T_w)=det((D-omega L)^(-1))dot det((1-omega)D+omega U)$. Since $D-omega L$ is simply a lower triangular matrix, $det(D-omega L)$ is the product of its diagonal entries, giving us $product_(i=1)^(n) a_(i i)$. Thus, $det((D-omega L)^(-1))=1/(product_(i=1)^(n) a_(i i))$.\
  
  Since $(1-omega)D+omega U$ is an upper triangular matrix, $det((1-omega)D+omega U)$ is the product of its diagonal entries as well, giving us $det((1-omega)D+omega U)=$\
  $product_(i=1)^(n) (1-omega)a_(i i)=(1-omega)^n product_(i=1)^(n) a_(i i)$. Combining these two terms, we get $det(T_omega)=$\
  
  $1/(product_(i=1)^(n) a_(i i))dot (1-omega)^n product_(i=1)^(n) a_(i i)=(1-omega)^n$. Since the determinant for a square matrix is\
  
  the product of its eigenvalues, we have $det(T_w)=product_(i=1)^n lambda_i = (1-omega)^n$. Taking \
  
  their absolute values, we get $product_(i=1)^n abs(lambda_i)=abs(1-omega)^n=abs(omega-1)^n$. We then take the\
  
  geometric mean of the product of its eigenvalues, $product_(i=1)^n abs(lambda_i)^(1/n)$, and compare it to the spectral radius of $T_omega$. Since the spectral radius of a given square matrix is equal to its largest possible eigenvalue, it is greater than or equal to the geometric mean of the\
  
  product of all of its eigenvalues. Thus, we have $product_(i=1)^n abs(lambda_i)^(1/n)<=rho(T_omega)$, or \
  
  $product_(i=1)^n abs(lambda_i)<=rho(T_omega)^n$. We substitute  $product_(i=1)^n abs(lambda_i)=abs(omega-1)^n$ for the left hand side and take\
  
  their $n^(t h)$ root, giving us $rho(T_w)>=abs(omega-1)$. Since $rho(T_omega)<1$ for the SOR method to converge, we have the inequality $abs(omega-1)<=rho(T_omega)<1$. We then solve the absolute inequality $abs(omega-1)$, which yields $-1<omega-1<1$, or $0<omega<2$.\
  
  Thus, for the SOR method to converge, $0<omega<2$.]
  #set heading(hanging-indent: 0pt)
]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  #set heading(hanging-indent: 78pt)
  ==== Theorem 1.4.5 #h(5pt) #text(weight: "regular")[_Also known as the *Ostrowski-Reich Theorem*_. If a matrix $A$ is positive definite and $0<omega<2$, then the SOR method converges for any choice of initial approximate vector $x^((0))$.]
  #set heading(hanging-indent: 0pt)
]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
  #set heading(hanging-indent: 78pt)
  ==== Theorem 1.4.6 #h(5pt) #text(weight: "regular")[If a matrix $A$ is positive definite and tridiagonal, then $rho(T_(G S))=[rho(T_J)]^2<1$, and the optimal choice for $omega$ for the SOR method is given by \
  #v(2pt)
  $omega=(2)/(1+sqrt(1-[rho(T_J)]^2))$. With this $omega$, we have $rho(T_omega) = omega - 1$.]
  #set heading(hanging-indent: 0pt)
]

= Section 2: Iterative Refinement
#line(length: 100%)

== 2.1 What is Iterative Refinement?
#pad(left: 2em)[
  === 2.1.1 Definition
  *Iterative refinement* is a method for improving the quality of an approximate solution _$hat(x)$_ to a linear system of equations $A x = b$ where $A$ is a nonsingular $n times n$ nonsingular matrix. #sub[(Higham, 2023)]

  It is also called as _iterative improvement_ and consists of performing iterations on the system whose right-hand side is the _residual vector_ for successive operations until satisfactory accuracy results. #sub[(Burden & Faires, 2010)]
]

== 2.2 Concepts to Recall
#pad(left: 2em)[
  === 2.2.1 LU Decomposition

  Recall that *LU Decomposition*, also known as _LU Factorization_, solves the linear system $A x = b$ by splitting the coefficient matrix $A$ into a lower triangular matrix $L$ and an upper triangular matrix $U$ and using _forward and backward substitution_ to obtain the solution vector $x$. 
  
  === 2.2.2 Residual

  The *residual vector* of an approximate solution _$hat(x)$_ is defined as
  $r = b - A hat(x) $ and measures how well _$hat(x)$_ satisfies the original system. Note that $r = 0$ if and only if _$hat(x)$_ is the exact solution. #sub[(Higham, 2023)]

  This is distinct from the *error*, $e = x - hat(x)$, which cannot be computed directly since $x$ is unknown but the residual _can_ be computed directly from $A$, $b$, and _$hat(x)$_, which is exactly why refinement uses it, not the error, as the right-hand side of each correction step. #sub[(Burden & Faires, 2010)]

  
  === 2.2.3 Norms

  To quantify the "size" of a vector's error or residual, a *vector norm* $parallel dot parallel$ is used, most commonly the $ell_2$ _Euclidean norm_ or the $ell_infinity$ _max norm_, depending on the application.

  In the context of refinement, norms are what give the method a concrete and checkable stopping criterion. The iteration continues until the norm of the residual falls below some chosen tolerance, at which point _$hat(x)$_ is accepted as sufficiently accurate. #sub[(Heath, 2018)]
  
  === 2.2.4 Conditioning

  The *condition number* of a nonsingular matrix $A$, denoted $kappa(A) = parallel A parallel dot parallel A^(-1) parallel$, measures how sensitive the solution of $A x = b$ is to small perturbations in the input data $A$ or $b$, with a large $kappa(A)$ meaning $A$ is *ill-conditioned*.

  Conditioning matters directly for refinement because a small residual $parallel r parallel$ does not guarantee a small error $parallel x - hat(x) parallel$ when $A$ is ill-conditioned since the two are related by roughly $(parallel x - hat(x) parallel) / (parallel x parallel) <= kappa(A) dot (parallel r parallel) / (parallel b parallel)$ which is the central motivation for refinement.
]

== 2.3 Motivation
#pad(left: 2em)[
  === 2.3.1 Sources of Error

  Even a numerically stable method like Gaussian elimination does not produce an exact solution in floating point arithmetic since the rounding error accumulated during the elimination and substitution steps means the computed _$hat(x)$_ differs from the true $x$. #sub[(Burden & Faires, 2010)]
  
  === 2.3.2 Refine not Resolve

  One option upon detecting a large residual is to solve $A x = b$ again from scratch, using more careful arithmetic but this costs a full $O(n^3)$ re-elimination. #sub[(Higham, 2023)]

  Since the $L U$ factorization of $A$ was already computed while finding _$hat(x)$_, it can be reused: solving the correction system $A z = r$ for $z$ via forward and backward substitution costs only $O(n^2)$, making refinement far cheaper than re-solving. #sub[(Burden & Faires, 2010)]

  This is why iterative refinement is preferred in practice because it improves accuracy at a fraction of the cost of computing a fresh solution. #sub[(Higham, 2023)]
]

== 2.4 Procedure
#pad(left: 2em)[
  Suppose the problem is to solve $A x = b$ for $x$. Using any previously discussed matrix method $M$, we obtain $A x = b limits(->)^M hat(x) approx x$, along with the residual $r = b - A hat(x)$ as a byproduct of $M$.

  We then solve $A delta = r$, i.e. $delta = A^(-1) r$, where $delta$ is the _ideal_ refinement for _$hat(x)$_ as can be verified by substitution:
  $ A(hat(x) + delta) = A hat(x) + A delta = A hat(x) + r = A hat(x) + b - A hat(x) = b $

  showing that _$hat(x) + delta$_ would recover $b$ exactly, if $delta$ could be found exactly.

  However, since the correction system $A delta = r$ is itself solved using the same method $M$, we don't actually obtain $delta$ exactly, we only obtain an approximation $hat(delta) approx delta$, which brings us only closer to $b$. We therefore update _$hat(x)$_ as
  $ hat(x) <- hat(x) + hat(delta) $
  and repeat the process until $Delta hat(x) = parallel hat(delta) parallel < "tol"$.

  This is the essence of iterative refinement: whatever accuracy is lost to the matrix method $M$ used initially has to be recovered gradually, through succeeding refinements, rather than all at once.

  *Remark.* LU factorization is especially desirable for this process because the refinement equation $A delta = r$ has a constant $A$ and a variable $r$, so $A = L U$ only needs to be computed once, and each subsequent correction $delta_i$ for a new residual $r_i$ requires only forward and backward substitution, avoiding repeated, expensive elementary row operations.
]

// ============================================================
// ADDITIONS TO SECTION 2: ITERATIVE REFINEMENT
// Insert these after "== 2.4 Procedure" and before "= References"
// Written to match the existing #pad / #block(fill: rgb("f9f9f9"), ...) style
// ============================================================

== 2.5 Algorithms for Iterative Refinement
#pad(left: 2em)[
  === 2.5.1 Fixed-Precision Iterative Refinement
  This is the standard version of the procedure from Section 2.4, written out as an algorithm. It assumes $hat(x)$ was obtained by solving $A x = b$ via $L U$ (or $P A = L U$) factorization in the first place, so the *same* factors are reused for every correction — no re-factorization of $A$ is ever needed.

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
    ==== Algorithm: Iterative Refinement (Reusing an Existing LU Factorization)
    #line(length: 100%)

    *Input:* $A$, $b$, precomputed factorization $P A = L U$, initial approximate solution $hat(x)$, tolerance $epsilon$, maximum refinement steps $N$.

    + Set $k <- 0$.
    + *Repeat:*
      + Compute the residual: $r <- b - A hat(x)$
      + Solve $L y = P r$ #h(1fr) (forward substitution, reuses existing $L$)
      + Solve $U delta = y$ #h(1fr) (back substitution, reuses existing $U$)
      + Update: $hat(x) <- hat(x) + delta$
      + *If* $||delta|| \/ ||hat(x)|| < epsilon$: stop, return $hat(x)$
      + $k <- k+1$
    + *Until* $k = N$: report failure to converge in $N$ steps.

    *Output:* refined approximate solution $hat(x)$, or a failure flag.
  ]

  *Note:* every step after the initial factorization costs only $O(n^2)$ (one residual, one forward solve, one back solve) — compare to the $O(n^3)$ cost of the original factorization. This is the entire reason refinement is worth doing (Section 2.3.2).

  === 2.5.2 Mixed-Precision (Extended-Precision) Iterative Refinement
  A common refinement of the algorithm itself: compute the residual $r = b - A hat(x)$ in *higher precision* than the rest of the computation (e.g. double precision even if $A$, $b$, and the $L U$ factors are stored in single precision), then round $r$ back down before solving $L y = P r$ and $U delta = y$ as usual.

  *Why this matters:* once $hat(x)$ is already close to $x$, the subtraction $b - A hat(x)$ is a subtraction of two nearly-equal quantities — exactly the setup for catastrophic cancellation. If $r$ is computed at the *same* limited precision as everything else, this cancellation can wipe out the very information the next correction needs, and refinement stalls after one or two steps. Computing $r$ in extended precision avoids this and lets refinement continue improving $hat(x)$ closer to the limit set by $kappa(A)$ (Section 2.2.4).

  *Note:* only the residual computation needs the extra precision — the triangular solves for $delta$ can stay in the original (cheaper) precision, so this costs little extra.
]

== 2.6 When Refinement Helps, and When It Doesn't
#pad(left: 2em)[
  === 2.6.1 Mechanism
  Each refinement step does not magically erase error — it is governed by the same residual/conditioning relationship as any other approximate solve (Section 2.2.4):
  $ (||hat(x) - x||)/(||x||) <= kappa(A) (||r||)/(||b||) $
  Because the correction $delta$ is only as good as $A$'s reused $L U$ factors allow, refinement does not recover the *exact* solution in one step — but each pass typically shrinks the residual (and, correspondingly, tightens the bound on forward error) by roughly the same relative factor, giving geometrically decreasing error much like the stationary methods of Section 1.3, until the limit imposed by $kappa(A)$ is reached.

  === 2.6.2 Limitation: Refinement is Not a Cure for Ill-Conditioning
  If $kappa(A)$ is large, the inequality above still holds at *every* refinement step. Even if $r$ is driven down to the smallest value floating-point arithmetic allows, the forward error is still bounded below by roughly $kappa(A)$ times that. Refinement can only recover accuracy that was lost to the *algorithm's* rounding — it cannot recover accuracy lost to the *problem's* own sensitivity. For a severely ill-conditioned $A$, refinement may show little improvement or stagnate after the first correction.
]

== 2.7 Worked Example
#pad(left: 2em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
    ==== One Step of Iterative Refinement
    #line(length: 100%)

    Solve $A x = b$ where
    $ A = mat(3,2;4,3), quad b = mat(7;10) $
    The exact solution is $x = (1,2)$, but suppose a prior (limited-precision) solve produced
    $ hat(x) = mat(1.05; 1.90) $

    *Residual:*
    $ r = b - A hat(x) = mat(7;10) - mat(3(1.05)+2(1.90);4(1.05)+3(1.90)) = mat(7-6.95;10-9.90) = mat(0.05;0.10) $

    *Correction equation* $A delta = r$:
    $ mat(3,2;4,3) delta = mat(0.05;0.10) quad ==> quad delta = mat(-0.05;0.10) $

    *Update:*
    $ hat(x)_"new" = hat(x) + delta = mat(1.05-0.05;1.90+0.10) = mat(1.00;2.00) $
    which matches the exact solution — so the new residual is $r_"new" = mat(0;0)$ and no further refinement is needed. In genuine floating-point practice, the correction equation is itself only solved *approximately*, so a single step rarely zeroes out the residual exactly; this example uses exact arithmetic to keep each quantity (residual, correction, update) easy to follow by hand.
  ]
]

== 2.8 Iterative Refinement vs. Iterative Solvers
#pad(left: 2em)[
  It is easy to mistake iterative refinement for "Jacobi/Gauss-Seidel applied to the residual." They are related (both reduce error over repeated passes) but are structurally different methods.

  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + luma(150),
    fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { white },
    align: left,
    table.header([*Property*], [*Iterative Solver* (Jacobi / GS / SOR)], [*Iterative Refinement*]),
    [Starting point], [Arbitrary guess $x^((0))$, often $0$], [An already-computed, usually fairly accurate $hat(x)$],
    [Solves], [$A x = b$ itself, from scratch each pass], [The correction equation $A delta = r$],
    [Needs a factorization?], [No — never forms or reuses $L U$], [Yes — reuse is the entire point (Section 2.5.1)],
    [Typical origin], [Standalone method, esp. for large sparse systems], [Post-processing step after a direct solve],
  )
]


= References
#line(length: 100%)
#let ref-item(body) = block(
  inset: (left: 2em),
  outset: (left: -2em),
  below: 1.25em,
  body
)

#ref-item([Burden, R. L., & Faires, J. D. (2010). _Numerical analysis_. Cengage Learning.])

#ref-item([Edwards, Penney and Calvis (2015). Differential Equations and Boundary Value Problems: Computing and Modeling. 5th Edition.])

#ref-item([Heath, M. T. (2018). _Scientific Computing: An Introductory Survey_])

#ref-item([Higham, N. (2023). _What is Iterative Refinement?_ [Article]. #link("https://nhigham.com/2023/03/13/what-is-iterative-refinement/")])

#ref-item([SkanCity Academy. (2023, November 8). _07 - Gauss-seidel iteration method: Example 1_ [Video]. YouTube. #link("https://www.youtube.com/watch?v=Yg_y9CC8FbE")])

#ref-item([StudySession. (2020a, August 25). _Iterative methods for linear systems | numerical methods_ [Video]. YouTube. #link("https://www.youtube.com/watch?v=8D2d3MQtWTw")])

#ref-item([StudySession. (2020b, August 26). _Diagonally dominant matrices | numerical methods_ [Video]. YouTube. #link("https://www.youtube.com/watch?v=0rEScJH8bSE")])

#ref-item([StudySession. (2020c, December 1). _Jacobi iteration method | numerical methods_ [Video]. YouTube. #link("https://www.youtube.com/watch?v=s_XFSeH7xG0")])

#ref-item([StudySession. (2020d, December 11). _Jacobi iteration method example | numerical methods_ [Video]. YouTube. #link("https://www.youtube.com/watch?v=UA7bzwCwHMI")])

#ref-item([StudySession. (2021, January 29). _Gauss-seidel method | numerical methods_ [Video]. YouTube. #link("https://www.youtube.com/watch?v=pQVqaiFBvoU")])

#ref-item([Westover, L. (2020). _Chapter 5: Linear Systems of Equations - Part 8 (SOR)_ [Video]. YouTube. #link("https://www.youtube.com/watch?v=cNClRielhGU")])
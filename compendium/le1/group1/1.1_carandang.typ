#import "../../../template.typ": project

#show: project.with(
  title: "Positive Definite Matrices and Cholesky Factorization",
  contributor: "Carandang",
  date: "September 23 2026",
)

#show bibliography: set heading(numbering: none)
#set math.mat(delim: "[")

#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)

== (Carandang)

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Problem 6.3.26*
  #line(length: 100%)
  *Reference:* _Introduction to Linear Algebra_ (6th ed.), Gilbert Strang
  #cite(<strang2023>)

  *Problem Statement:* \
  For which numbers $b$ and $c$ is each matrix positive definite? Factor each matrix $S$ into $L D L^T$:
  $ S_1 = mat(1, b; b, 9), quad S_2 = mat(2, 4; 4, c), quad S_3 = mat(c, b; b, c) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1. First Matrix: $S_1 = mat(1, b; b, 9)$*
  - *Positive Definiteness:* \
    - first leading minors:
      - $det(S_(1,1)) = 1 > 0$  
    - second leading minor:
      - $det(S_1) = 9 - b^2$.
    $det(S_1) > 0 => 9 - b^2 > 0 ==> $* $ -3 < b < 3$ *
  
  - *Elimination & Factorization:* 
    - First Pivot: $d_1 = a_(11)= 1$. 
    - Multiplier: $ell_(21)=(a_(21)/d_1)=b/1=b$
    - Row operation $R_2 arrow.l R_2 - b R_1$ to second pivot: $d_2 = 9-b(b)=9 - b^2$.
    $ 
    L = mat(1, 0; ell_(21), 1)= mat(1, 0; b, 1), quad 
    D = mat(d_1, 0; 0, d_2) = mat(1, 0; 0, 9-b^2), quad
    L^T = mat(1,b; 0, 1) $
    $ L D L^T = mat(1, 0; b, 1) mat(1, 0; 0, 9 - b^2) mat(1, b; 0, 1) = mat(1, 0; b, 9 - b^2) mat(1, b; 0, 1) = mat(1, b; b, 9) = S_1 $
  
  #align(center)[#block(
    inset: 10pt,
    stroke: rgb("000000"),
  )[
    $ L D L^T = mat(1, 0; b, 1) mat(1, 0; 0, 9 - b^2) mat(1, b; 0, 1) $
  ]]

  #v(1em)

  *2. Second Matrix: $S_2 = mat(2, 4; 4, c)$*
  - *Positive Definiteness:* \
    - first leading minors:
      - $det(S_(2,1)) = 2 > 0$  
    - second leading minor:
      - $det(S_2) = 2c - 16$.
    $ det(S_2) > 0 => 2c - 16 > 0 ==>$* $c > 8 $*
  
  - *Elimination & Factorization:* 
    - First Pivot: $d_1 = a_(11) = 2$. 
    - Multiplier: $ell_(21)=(a_(21)/d_1)= 4/2 = 2$
    - Row operation $R_2 arrow.l R_2 - 2 R_1$ to second pivot: $d_2 = c-2(4)=c - 8$.
    $ 
    L = mat(1, 0; ell_(21), 1)= mat(1, 0; 2, 1), quad 
    D = mat(d_1, 0; 0, d_2) = mat(2, 0; 0, c-8), quad
    L^T = mat(1,2; 0, 1) $
    $ L D L^T = mat(1, 0; 2, 1) mat(2, 0; 0, c - 8) mat(1, 2; 0, 1) = mat(2, 0; 4, c - 8) mat(1, 2; 0, 1) = mat(2, 4; 4, c) = S_2 $
  
  #align(center)[#block(
    inset: 10pt,
    stroke: rgb("000000"),
  )[
    $ L D L^T =mat(1, 0; 2, 1) mat(2, 0; 0, c - 8) mat(1, 2; 0, 1) $
  ]]

  #v(1em)

  *3. Third Matrix: $S_3 = mat(c, b; b, c)$*
  - *Positive Definiteness:* \
    - first leading minors:
      - $det(S_(3,1)) = c > 0$  
    - second leading minor:
      - $det(S_3) = c^2 - b^2$.
    $ det(S_3) > 0 => c^2 - b^2 > 0 => c^2 > b^2==>$* $c > |b| $*
  
  - *Elimination & Factorization:* 
    - First Pivot: $d_1 = a_(11) = c$. 
    - Multiplier: $ell_(21)=(a_(21)/d_1)= b/c$
    - Row operation $R_2 arrow.l R_2 - (b/c) R_1$ to second pivot: $d_2 = c-b/c (b)=c - b^2/c=(c^2-b^2)/c$.
    $ 
    L = mat(1, 0; ell_(21), 1)= mat(1, 0; b/c, 1), quad 
    D = mat(d_1, 0; 0, d_2) = mat(c, 0; 0, c-b^2/c), quad
    L^T = mat(1,b/c; 0, 1) $
    $ L D L^T = mat(1, 0; b/c, 1) mat(c, 0; 0, c - b^2/c) mat(1, b/c; 0, 1) = mat(c, 0; b, c - b^2/c) mat(1, b/c; 0, 1) = mat(c, b; b, c) = S_3 $
  
  #align(center)[#block(
    inset: 10pt,
    stroke: rgb("000000"),
  )[
    $ L D L^T = mat(1, 0; b/c, 1) mat(c, 0; 0, c - b^2/c) mat(1, b/c; 0, 1) $
  ]]
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Exercise 4.11*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_, Urbain Vaes
  #cite(<vaes2023>)

  *Problem Statement:* \
  Let $A in RR^(n times n)$ be a symmetric positive definite matrix. Show that the functional
  $ norm(dot)_A : x |-> sqrt(x^T A x) $
  defines a norm on $RR^n$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  The mapping of $norm(dot)_A : RR^n -> RR$ is valid norm iff it satisfies these three axioms: \ 

  + *Positivity:*\
    Because $A$ is SPD, by definition $x^T A x > 0$ for every non-zero vector $x in RR^n without {(0)}$.
    Taking the squareroot of both sides preserves the inequality:
    $ norm(x)_A = sqrt(x^T A x) > 0 quad s.t. quad forall x != 0 $
    For $x = 0$, we have $norm(0)_A = sqrt(0^T A (0)) = 0$. Hence, $norm(x)_A = 0 <==> x = 0$.

  + *Homogeneity:*\
    It is clear that by the transpose rule for scalar products:
    $ norm(c x)_A = sqrt((c x)^T A (c x)) = sqrt(c^2 (x^T A x)) = sqrt(c^2) sqrt(x^T A x) = |c| norm(x)_A $

  + *Triangle Inequality:*\
    Expanding the squared functional of the sum $x + y$:
    $ norm(x + y)_A^2 &= (x + y)^T A (x + y) \
                      &= x^T A x + x^T A y + y^T A x + y^T A y $
  
    Since $A$ is symmetric ($y^T A x = x^T A y$):
    $ norm(x + y)_A^2 = norm(x)_A^2 + 2 x^T A y + norm(y)_A^2 $
  
    By Cauchy-Schwarz inequality for inner products ($x^T A y <= norm(x)_A norm(y)_A$):
    $ norm(x + y)_A^2 &<= norm(x)_A^2 + 2 norm(x)_A norm(y)_A + norm(y)_A^2 \
                      &= (norm(x)_A + norm(y)_A)^2 $
  
    Square root both sides:
    #align(center)[#block(
      inset: 10pt,
      stroke: rgb("000000"),
    )[
      $ norm(x + y)_A <= norm(x)_A + norm(y)_A $
    ]]

  #align(right)[*QED.*]
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix of Problem 1*
  #line(length: 100%)
  *Problem Statement:* \
  For which numbers $b$ and $c$ is each matrix positive definite? Factor each matrix $S$ into Cholesky $L_("Chol")  L^T_("Chol")$:
  $ S_1 = mat(1, b; b, 9), quad S_2 = mat(2, 4; 4, c), quad S_3 = mat(c, b; b, c) $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  *1. First Matrix: $S_1 = mat(1, b; b, 9)$*
  - *Domain:* 
    - $det(S_1) > 0 => 9 - b^2 > 0 ==> $* $ -3 < b < 3$ *
  - *Cholesky Decomposition:*
    Using $S_1 = L D L^T = (L D^(1/2))(D^(1/2) L^T)$:
    $ L &= mat(1, 0; b, 1)\ 
      D &= mat(d_1, 0; 0, d_2) = mat(1, 0; 0, 9-b^2), quad "it follows:" \
      D^(1/2) &= mat(1, 0; 0, sqrt(9 - b^2)) \
      L_("chol") = L D^(1/2) &= mat(1, 0; b, 1) mat(1, 0; 0, sqrt(9 - b^2)) 
                = mat(1, 0; b, sqrt(9 - b^2)) \
      L_("chol") L_("chol")^T &= mat(1, 0; b, sqrt(9 - b^2)) mat(1, b; 0, sqrt(9 - b^2)) \
                            &= mat(1, b; b, b^2 + (9-b^2))   
                              = mat(1, b; b, 9) \
                            &= S_1 $

  #v(1em)

  *2. Second Matrix: $S_2 = mat(2, 4; 4, c)$*
  - *Domain:* \
    - $ det(S_2) > 0 => 2c - 16 > 0 ==>$* $c > 8 $*
  - *Cholesky Decomposition:* \
    $ L &= mat(1, 0; 2, 1) \
      D &= mat(2, 0; 0, c - 8), quad "it follows:" \
      D^(1/2) &= mat(sqrt(2), 0; 0, sqrt(c - 8)) \
      L_("chol") = L D^(1/2) &= mat(1, 0; 2, 1) mat(sqrt(2), 0; 0, sqrt(c - 8)) = mat(sqrt(2), 0; 2sqrt(2), sqrt(c - 8)) \
      L_("chol") L_("chol")^T &= mat(sqrt(2), 0; 2sqrt(2), sqrt(c - 8)) mat(sqrt(2), 2sqrt(2); 0, sqrt(c - 8)) \
                              &= mat(2, 4; 4, 8+(c-8)) 
                              = mat(2 , 4; 4 ,c) \
                              &= S_2 $

  #v(1em)

  *3. Third Matrix: $S_3 = mat(c, b; b, c)$*
  - *Domain:* $ det(S_3) > 0 => c^2 - b^2 > 0 => c^2 > b^2==>$* $c > |b| $*
  - *Cholesky Decomposition:*
    $ L &= mat(1, 0; b/c, 1) \
      D &= mat(c, 0; 0, (c^2 - b^2)/c), quad "it follows:" \
      D^(1/2) &= mat(sqrt(c), 0; 0, sqrt((c^2 - b^2)/c)) \
      L_("chol") = L D^(1/2) &= mat(1, 0; b/c, 1) mat(sqrt(c), 0; 0, sqrt((c^2 - b^2)/c)) = mat(sqrt(c), 0; b/sqrt(c), sqrt((c^2 - b^2)/c)) \
      L_("chol") L_("chol")^T &= mat(sqrt(c), 0; b/sqrt(c), sqrt((c^2 - b^2)/c)) mat(sqrt(c), b/sqrt(c); 0, sqrt((c^2 - b^2)/c)) \
                              &= mat(c, b; b, b^2/c + ((c^2 - b^2)/c)) 
                               = mat(c, b; b, c) \
                              &= S_3 $
]

#line(length: 100%)


#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix of Problem 2*
  #line(length: 100%)
  *Problem Statement:* \
  Let $A, B in RR^(n times n)$ both be Symmetric Positive Definite (SPD) matrices.

  1. Prove that $C = A + B$ is also Symmetric Positive Definite.
  2. Show that the induced norm $norm(x)_(A+B) = sqrt(x^T (A+B) x)$ satisfies:
     $ norm(x)_(A+B) = sqrt(norm(x)_A^2 + norm(x)_B^2) $
  3. Prove the inequality $norm(x)_(A+B) <= norm(x)_A + norm(x)_B$.
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  + *SPD Proof $C = A + B$:*
    - *Symmetry:* 
      $ (A + B)^T = A^T + B^T = A + B $
    - *Positivity:* For any non-zero vector $x != bold(0)$, we expand the quadratic form:
      $ x^T (A + B) x = x^T A x + x^T B x $
      Since both $A$ and $B$ are SPD, we know $x^T A x > 0$ and $x^T B x > 0$. The sum of two strictly positive numbers is strictly positive:
      $ x^T (A + B) x > 0 quad forall x != bold(0) $
      Therefore, $C = A + B$ is SPD.

  + *Norm Relation:*
    Square and distribute the terms:
    $ norm(x)_(A+B)^2 &= x^T (A + B) x \
                      &= x^T A x + x^T B x \
                      &= norm(x)_A^2 + norm(x)_B^2 $
  
    Square root both sides, then:
    $ norm(x)_(A+B) = sqrt(norm(x)_A^2 + norm(x)_B^2) $

  + *Inequality Proof:*
    Since $norm(x)_A >= 0$ and $norm(x)_B >= 0$, then $2 norm(x)_A norm(x)_B >= 0$ is also non-negative. 
  
    We form the following inequality:
    $ norm(x)_(A+B)^2 &= norm(x)_A^2 + norm(x)_B^2 \
                      &<= norm(x)_A^2 + 2 norm(x)_A norm(x)_B + norm(x)_B^2 \
                      &= (norm(x)_A + norm(x)_B)^2 $

    Square root both sides, then:
    #align(center)[#block(
      inset: 10pt,
      stroke: rgb("000000"),
    )[
      $ bold(norm(x)_(A+B) <= norm(x)_A + norm(x)_B) $
    ]]

  #align(right)[*QED.*]
]

#line(length: 100%)


// ─────────────────────────────────────────────
#bibliography("../../../resources/bibs/compendium/le1/arc1.bib")
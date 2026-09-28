// https://www.intmath.com/matrices-determinants/8-applications-eigenvalues-eigenvectors.php

#import "../../../template.typ": project

#show: project.with(
  title: "Compendium Contribution",
  contributor: "Jan Michael Tauli",
  date: "September 28, 2026"
)

= Problem

Consider the matrix $A$ paramterized by k, along with a right-hand side vector $b$ and initial guess $x^((0))$
$ A = mat(
  10, 2, 1;
  1, 10, k;
  2, 1, 10;
  delim: "["
),  b = vec(13, 13, 13, delim: "["), x^((0)) = vec(0, 0, 0, delim: "[")
$

+ Find the Jacobi iteration matrix $T_J$ in terms of $k$, and express its infinity norm $||T_J||_infinity$ as a function of $k$ (assuming $k gt.eq 0$).
+ Determine the maximum integer value of $k$ for which SDD is preserved across all rows.
+ Using that $k$, calculate the minimum number of iterations $m$ required to guarantee that $||x^((m))-x^\*||_infinity lt.eq 10^(-3)$, given that $x^((1)) = vec(1.3, 1.3, 1.3, delim:"[")$.


= Solution
+ 
  $ A &= L + D + U \
      &= mat(0,0,0;1,0,0;2,1,0; delim:"[") + "diag"(10, 10, 10) + mat(0,2,1;0,0,k;,0,0,0; delim: "[") \
    T_J &= -D^(-1)(L + U) \
    T_J &= -"diag"(1/10)mat(0,2,1;1,0,k;2,1,0;delim: "[") \
        &= mat(0, 0.2, 0.1; 0.1, 0, k/10; 0.2, 0.1, 0;delim: "[") \
    ||T_J||_infinity &= "max"(0.3, 0.1 + k/10, 0.3) = "max"(0.3, 0.1 + k/10)
  $
+
  $ "Row 1:"& 10 > 2 + 1 = 3 ("True") \
    "Row 2:"& 10 > 1 + k arrow k < 9  \
    "Row 2:"& 10 > 1 + 2 = 3 ("True") \ 
    "max" k "is" 8 \
    ||T_J||_infinity &= "max"(0.3, 0.1 + (1 + 8)/10) \
                    &= 0.9
  $
+ 
  Using the equation:
  $ (||T||^(m))/(1 - ||T||) ||x^((1)) - x^((0))||_infinity lt.eq 10^(-3)
  $
  making the substitutions we have $m approx 89.907$

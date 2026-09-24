#import "../../../template.typ": project

#show: project.with(
  title: "1.3 QR Factorization",
  contributor: "Jan Michael Tauli",
  date: "September 24, 2026",
)

#set math.mat(delim: "[")

= Definition

For an m $times$ n matrix A, A is decomposed into a product of two matrices

$ A = "QR"
$

Q is an m $times$ m orthogonal matrix \
R is an m $times$ n upper triangular matrix

= Rationale
+ Eigenvalues of upper triangular matrices are the diagonals
+ Find a matrix B that is similar to A that makes obtaining eigenvalues easy
+ Since $Q^(-1) = Q^top$, we have the following
  $ "Bv" = lambda v => "Bv" = Q^top "AQv" = lambda y => A("Qv") = lambda("Qv")
  $
  - If $v_A$ is the eigenvector of B, then $v_B = "Q"v_A$ is the corresponding vector of A

= QR Factorization

== Rebuild $A$
$ R = mat(
  1, s_(hat(y)arrow+x), s_(hat(z)arrow+x);
  0, 1, s_(hat(y)arrow+x); 
  0, 0, 1;
) mat(
  1, , ;
  , 1, ;
  , , lambda_3;
) mat(
  1, , ;
  , lambda_2, ;
  , , 1;
) mat(
  lambda_1, , ;
  , 1, ;
  , , 1;
) I_3
$

You can find Q using the Gram-Schmidt Process (Math 40)
== Reverse Process

$ Q^(-1)A = Q^top A = R \
Q^top A 
&= [q_1, q_2, q_3]^top [a_1, a_2, a_3] \
&= mat(
  q_1^top a_1, q_1^top a_2, q_1^top a_3;
  q_2^top a_1, q_2^top a_2, q_2^top a_3;
  q_3^top a_1, q_3^top a_2, q_3^top a_3;
) \
&= mat(
  r_11, r_12, r_13;
  0, r_22, r_23;
  0, 0, r_33;
) \
&= R
$

== Factorization
+ Obtain $Q$ via Gram-Schmidt orthonormalization (Math 40)
+ Obtain $R$ through $Q^top A$



= QR Iteration Derivation
- Suppse $A$ is a square matrix with *real distinct eigenvalues*
- Find a similar matrix to $A = Q R$
  $ B &= Q^top A Q \
      &= Q^top Q R Q \
      &= R Q
  $
  - A B have the same eigenvalues
$ & "Let"       & A           &= A^((0)) \
  & "Iteration" & A^((k))     &= Q^((k))R^((k)) => \ 
  &             & A^((k + 1)) &= R^((k))Q^((k)) \
  &             & A^((k + 1)) &= (Q^((0))Q^((1))...Q^((k)))^top A^((0)) (Q^((0))Q^((1))...Q^((k))) \
  &             &             &arrow V^top A^((0))V  = Lambda
$
- Basically, the column vectors $V$ converge to the eigenvectors of $A$

== pseudocode

$ &" 1:" "Given: Symmetric" n times n "matrix" A \
  &" 2:" A^((0)) = A, V^((0)) = I_n \
  &" 3:" "for" k=1,2,...n_"max"-1 "do" \
  &" 4:" "   Gram-Schmidt orthonormalization of" A^((k)) arrow Q^((k)) \
  &" 5:" "   Compute" R^((k)) = (Q^((k)))^top A^((k)) \
  &" 6:" "   " A^((k+1)) = R^((k))Q^((k)) \
  &" 7:" "   " V^((k+1)) = V^((k))Q^((k)) \
  &" 8:" "   if" ||"subdiag"(A^((k+1)))||_F <= epsilon_"tol" "then"\
  &" 9:" "       return diag"(A^((k+1))) = {lambda_1^*, lambda_2^*, ..., lambda_n^*}, V = [v_1, ..., v_n]\
  &"10:" "   end if"\
  &"11:" "end for"\
$

= Additional Notes
- If $A$...
  - has all real distinct eigenvalues: $Lambda$ is uppper triangular
  - is also symmetric: $Lambda$ = diag($lambda_1,...,lambda_n$)
- else, will not converge
- QR...
  - fails to converge if $|lambda_i| = |lambda_j|$
  - converges linearly

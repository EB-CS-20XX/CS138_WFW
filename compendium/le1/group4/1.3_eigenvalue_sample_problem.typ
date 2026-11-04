#import "../../../template.typ": project

#show: project.with(
  title: "Eigenvalue Problems Sample Problems",
  contributor: "Enrico U. Baratang",
  date: "September 28, 2026",
)

= Preface
Let it be known that, aside from cited sources involved in calculation, all arithmetic involved in this paper was calculated via Microsoft Excel. The associated .xslx file has been included in the resources of the compendium.

= Problems

Let G be a 3x3 matrix, whose eigenvalues we wish to approximate.

$ G = mat(delim: "[",
1,6,7;
6,42,6;
7,6, 69;
) $

Let us approximate these eigenvalues using the Shifted Inverse Power Method. But how shall we decide the shift, $sigma$ for each eigenvalue? Let us use the Gershgorin Circle Theorem!

== Problem 1: Gershgorin Circle Theorem
For each row the associated Gershgorin disc takes the following form:
$ D_i = {z ∈ CC: |z-a_(i\i)| <= limits(sum)_(c=1, c!=i)^n |a_(i\c)| } $
Therefore we have
$ D_1 = {z ∈ CC: |z-a_(11)| <= limits(sum)_(c=1, c!=1)^n |a_(1\c)| } = {z ∈ CC: |z-1| <= 13 } $
$ D_2 = {z ∈ CC: |z-a_(22)| <= limits(sum)_(c=1, c!=2)^n |a_(2\c)| } = {z ∈ CC: |z-42| <= 12 } $
$ D_3 = {z ∈ CC: |z-a_(33)| <= limits(sum)_(c=1, c!=3)^n |a_(3\c)| } = {z ∈ CC: |z-69| <= 13 } $

We can see that based on these values, these discs are isolated, and our best guesses would be at $sigma_1 = 1$, $sigma_2 = 42$, and $sigma_3 = 69$. We can confirm this by graphing them on the complex plane. An extension of the Gershgorin Circle Theorem lets us know that because each of these circles is isolated, each one contains exactly one of $G$'s eigenvalues.

#figure(
  image("../../../resources/images/gershgorin_discs.png"),
  caption: [Gershgorin Discs Graphed #cite(<desmos>)]
)

== Problem 2: Inverse Shifted Power Method

Now we can proceed with several iterations of the Inverse Shifted Power Method, for each $sigma$, with an initial vector of $x^(\(0\)) = mat(delim: "[", 1, 1, 1)^T$.

$ (G -I) =mat(delim: "[",
0,6,7;
6,41,6;
7,6, 68;
), (G -42I) =mat(delim: "[",
-41,6,7;
6,0,6;
7,6, 27;
), (G -69I) =mat(delim: "[",
-68,6,7;
6,-27,6;
7,6, 0;
)
$

While the inverse is not typically directly calculated for actual computer implementation, for convenience, confirm that the following are correct. #cite(<lazycalc>)

$ (G -I)^(-1) =mat(delim: "[",
-2752/2417,
402/2417,
5/2417;
402/2417,
1/2417,
-6/2417;
5/2417,
-6/2417,  
36/2417
), (G -42I)^(-1) =mat(delim: "[",
-1/28,
-5/42,
1/28;
-5/42,
-289/252,
2/7;
1/28,
2/7,
-1/28
), (G -69I)^(-1) =mat(delim: "[",
-4/475,
14/1425,
1/19;
14/1425,
-49/4275,
2/19;
1/19,
2/19,
8/19
)
$

Now, iterating with $x^(k+1) = (G-sigma I)^(-1)x^(k)$ for 5 iterations, with each of the 3 values of $sigma$ produces the following eigenvectors:

#table(
  columns: 8,
  table.header(
    [],
    $x^(\(0\))$,
    $x^(\(1\))$,
    $x^(\(2\))$,
    $x^(\(3\))$,
    $x^(\(4\))$,
    $x^(\(5\))$,
    $x^(\(6\))$
  ),
  $sigma=1$,
  $mat(delim:"[",
  1.000000;
  1.000000;
  1.000000
  )$,
  $mat(delim:"[",
  -0.540096;
  0.094359;
  0.061978;
  )$,
  $mat(delim:"[",
 0.388676;
 -0.049495;
 -0.034732;
  )$,
  $mat(delim:"[",
 -0.277377;
 0.035742;
 0.024889;
  )$,
  $mat(delim:"[",
 0.197994;
 -0.025503;
 -0.017765;
 
  )$,
  $mat(delim:"[",
 -0.141329;
 0.018204;
 0.012681;
 
  )$,
  $mat(delim:"[",
 0.100881;
 -0.012994;
 -0.009052;
  )$,



  $sigma = 42$,
  $mat(delim:"[",
  1.000000;
  1.000000;
  1.000000
  )$,
  $mat(delim:"[",
  -0.119048;
  -0.980159;
  0.285714
  
  )$,
  $mat(delim:"[",
  0.131141;
  1.219876;
  -0.294501
  
  )$,
  $mat(delim:"[",
  -0.160425;
  -1.498740;
  0.363737
  
  )$,
  $mat(delim:"[",
  0.197142;
  1.841816;
  -0.446931
  
  )$,
  $mat(delim:"[",
  -0.242266;
  -2.263406;
  0.549236
  
  )$,
  $mat(delim:"[",
  0.297721;
  2.781497;
  -0.674955
  )$,



  $sigma = 69$,
  $mat(delim:"[",
  1.000000;
  1.000000;
  1.000000
  )$,
  $mat(delim:"[",
  0.054035;
  0.103626;
  0.578947
  
  )$,
  $mat(delim:"[",
  0.031034;
  0.060285;
  0.257519
  
  )$,
  $mat(delim:"[",
  0.013885;
  0.026721;
  0.116408
  
  )$,
  $mat(delim:"[",
  0.006272;
  0.012084;
  0.052558
  
  )$,
  $mat(delim:"[",
  0.002832;
  0.005455;
  0.023732
  
  )$,
  $mat(delim:"[",
  0.001279;
  0.002463;
  0.010716
  
  )$,
)

Now you might be wondering why we did a 6th iteration when we only wanted 5. To get the eigenvalues associated with these eigenvectors, we can use the Rayleigh Quotient $lambda = (x^T A x)/(x^T x)$. Notice that, because of how iteration was done, $A x$ can be substituted by for the 6th iteration.

$ lambda'_i = (x^(\(5\)T)(G-sigma I)x^(\(5\)))/(x^(\(5\)T)x^(\(5\))) =  (x^(\(5\)T)x^(\(6\)))/(x^(\(5\)T)x^(\(5\))) $

This gives us $lambda'_1 = -0.713804, 
lambda'_2 = -1.228899, 
lambda'_3 = 0.451532$. These are labelled as $lambda'$ because we shifted then inverted the matrix. Thus we know that $lambda'_i = 1/(lambda_i-sigma)$, and consequently $lambda_i = 1/lambda'_i+sigma$. Calculating for the actual values of lambda we get:
$ lambda_1 = -0.400946, lambda_2 = 41.186263, lambda_3 =  71.214682
$

== Problem 3: QR Iteration

Now let us double check our work by attempting an approximation with QR iteration. Lest we forget, let us recall that our matrix is as follows:

$ G = mat(delim: "[",
1,6,7;
6,42,6;
7,6, 69;
) $

Now QR factorization takes $G = Q\R$ wherein $Q$ is an orthonormal matrix, and $R$ is an upper triangular matrix that is similar to $G$. 

$ Q\R = mat(delim:"[",dots.v, dots.v, dots.v;q_1,q_2,q_3;dots.v,dots.v,dots.v) mat(delim:"[",r_11,r_12,r_13;0,r_22,r_23;0,0,r_33)  = mat(delim:"[",dots.v, dots.v, dots.v;g_1,g_2,g_3;dots.v,dots.v,dots.v) = G $

To accomplish this we can use the Gram-Schmidt orthonormalization procees to attain $Q$ while also taking note of some key intermediate values which we will use to fill up $R$.

$v_1 = g_1 = mat(delim:"[",1;6;7), r_11 = ||v_1||_2 =9.273618, 
q_1 = v_1/r_11 = mat(delim:"[",0.107833;0.646997;0.754829)$
// Q1 HERE

$r_12 = chevron.l q_1, g_2 chevron.r = 32.349832$

$v_2 = g_2 - r_12q_1 = mat(delim:"[",2.511628;21.069767;-18.418605;), r_22 = ||v_2||_2 = 28.097836, 
q_2 = v_1/r_22 = mat(delim:"[",0.089389;0.749872;-0.655517)$
//Q2 HERE

$r_13 = chevron.l q_1, g_3 chevron.r = 56.720039,
r_23 = chevron.l q_3, g_3 chevron.r =-40.105712
$

$v_3 = g_3 - r_13q_1 -r_23q_2 = mat(delim:"[",4.468717;
-0.623542;
-0.103924
), r_33 = ||v_3||_2 = 4.513207, 
q_3 = mat(delim:"[",0.990142;-0.138159;-0.023027)$
// Q3 HERE

$ Q\R = mat(delim:"[", 
0.107833,0.089389,0.990142;
0.646997,0.749872,-0.138159;
0.754829,-0.655517,-0.023027
)
mat(delim:"[",
9.273618,32.349832,56.720039;
0,28.097836,-40.105712;
0,0,4.513207
)
$

Now that we've found our $Q\R$ we can take these as our $Q^(\(0\))$ and $R^(\(0\))$ then iterate with
$A^(\(k+1\)) = R^ (\(k\))Q^(\(k\)) $. Once we've stopped iterating, we should be able to find our eigenvalues along the diagonal of $A$. Let's do 7 iterations.

$ A^(\(1\)) = mat(delim:"[",64.744186,	-12.093766,	3.406701;
-12.093766,	47.359738,	-2.958483;
3.406701,	-2.958483,	-0.103924) $
$ A^(\(2\)) = mat(delim:"[",68.742231,	-8.254123,	0.020756;
-8.254123,	43.658703,	-0.017104;
0.020756,	-0.017104,	-0.400934) $
$ A^(\(3\)) = mat(delim:"[",70.339764,	-5.050439,	0.000120;
-5.050439,	42.061182,	-0.000124;
0.000120,	-0.000124,	-0.400946) $
$ A^(\(4\)) = mat(delim:"[",70.916256,	-2.978626,	0.000001;
-2.978626,	41.484690,	-0.000001;
0.000001,	-0.000001,	-0.400946) $
$ A^(\(5\)) = mat(delim:"[",71.114201,	-1.734127,	0.000000;
-1.734127,	41.286745,	0.000000;
0.000000,	0.000000,	-0.400946) $
$ A^(\(6\)) = mat(delim:"[",71.180998,	-1.005153,	0.000000;
-1.005153,	41.219947,	0.000000;
0.000000,	0.000000,	-0.400946) $
$ A^(\(7\)) = mat(delim:"[",71.203407,	-0.581754,	0.000000;
-0.581754,	41.197538,	0.000000;
0.000000,	0.000000,	-0.400946) $

Giving us $lambda_1 = -0.400946, lambda_2 = 41.197538, lambda_3 = 71.203407$, which is quite close to what we found with the Inverse Shifted Power Method.

// Later Later Later
Finally, to check our approximation, let us try and solve this analytically:

$ det(G - lambda I) = det (mat(delim:"[",
1-lambda, 6, 7;
6, 42-lambda, 6;
7, 6, 69-lambda;
) ) = 0 $

$ (1-lambda)[(42-lambda)(69-lambda)-36] - 6[6(69-lambda)-42] +7[36-7(42-lambda)] = 0 $
$ -lambda^3 + 112 lambda^2 -3009 lambda + 36 lambda + 49 lambda + 2898   - 2232 -1806 =0 $
$ -lambda^3 + 112lambda^2 - 2888 lambda -1176 = 0 $

#bibliography("../../../resources/bibs/compendium/le1/1.3_eigenvalue_sample_problem.bib", style: "apa")
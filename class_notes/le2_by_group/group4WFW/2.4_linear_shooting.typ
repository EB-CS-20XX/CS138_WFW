#import "../../../template.typ": project

#show: project.with(
  title: "2.4 Linear Shooting Method",
  contributor: "Enrico U. Baratang",
  date: "November 4, 2026",
)

#show bibliography: set heading(numbering: none)


= Motivation
Let us discuss a method for solving boundary value problems (BVPs) for second order differential equations (SODEs). We are given the following SODE:

$ y'' = f(x, y, y'), a<=x<=b, y(a) = alpha,  y(b) = beta $

Recall in CS 136 we encountered, and discussed numerical solutions for, initial value problems (IVPs) for SODEs with the form:

$ y'' =  f(x, y, y'), y(a)=alpha, y'(a) = gamma $

The only information we lack is in regards to $y'(a) = gamma$. So why not guess? 

We can make a guess, $y'(a) = t_k$, solve the resulting IVP to get some $y^(\(k\))$, check to see whether $y^(\(k\))(b) = beta$, and adjust accordingly if it isn't. This is the general idea of the shooting method.

= Linear Shooting
== Method
Let us first look at the linear case, because it has certain properties that allow us to obtain the solution by solving only 2 IVPs.

Given the following BVP for a linear SODE:
$ f(x, y, y') = p(x)y' + q(x)y + r(x), a<=x<=b, y(a) = alpha,  y(b) = beta $

We can approximate it as the linear combination of the solutions to the following IVPs #cite(<ruaya2026eigen>) #cite(<burden2010numerical>):

Homogenous IVP: $y_H '' = p(x)y_H ' + q(x)y_H, y_H (a) = 0, y_H '(alpha) = 1$

Non-Homogenous IVP: $y_N '' = p(x)y_N ' + q(x)y_N + r(x),y_N (a) = alpha, y_N '(alpha) = 0$

This gives us the general solution: $y = C y_H + y_N$

Then, using the boundary conditions, we can find the value of C that gives the proper solution to the boundary value problem:\
$y(a) = alpha = C y_H(a) + y_N(a) = 0 + alpha $\
$y(b) = beta = C y_H(b) + y_N(b) => C = (beta - y_N(b))/y_H(b)  $\
$ y(x) = y_N (x) + (beta - y_N(b))/y_H(b) y_H (x) $

Of course, as can be seen in the form of the solution, this metiod relies on the assumption that y_H(b) \u{2260} 0.
== Explanation
This works because of the superposition principle applicable to linear ODEs.
The superposition principle  states the following:

 $a y''+b y'+c y = f_1(t)$ and $y_2$ is a solution for $a y''+b y'+c y = f_2(t)$, then\ $k_1y_1+k_2y_2$ is a solution for $a y''+b y'+c y = k_1f_1(t) + k_2f_2(t)$, for some constants $k_1, k_2$.
#cite(<arash>)

We can see how this principle was used to split the SODE of the BVP into those used for the IVPs. Starting with the form of the principle itself:
$ a y''+b y'+c y = f_1(x) => y_1\ a y''+b y'+c y = f_2(x) => y_2\ a y''+b y'+c y = k_1f_1(t) + k_2f_2(x) => k_1y_1+k_2y_2  $
We can set $a = 1, b=-p(x), c=-q(x), f_1(x) = r(x), f_2(x)=0, y_1 = y_N, y_2 = y_H$
$  y''-p(x) y'-q(x) y = r(x) => y_N\  y''-p(x) y'-q(x) y = 0 => y_H\  y''-p(x) y'-q(x) y = k_1r(x) => k_1y_N+k_2 y_H  $
And now we have the forms of the two SODEs used for the IVPs. From here we can set $k_1 = 1, k_2 = C$ so that the initial values in the IVPs make it easier to isolate and calculate C such that it fufils the boundary conditions.

#bibliography("/resources/bibs/class_notes/le2/2.4_shooting_methods.bib", style: "apa")
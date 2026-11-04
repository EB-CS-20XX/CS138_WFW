#import "../../../template.typ": project

#show: project.with(
  title: "2.4 Linear Shooting Method",
  contributor: "Enrico U. Baratang",
  date: "November 4, 2026",
)

#show bibliography: set heading(numbering: none)


== Motivation
We wish to find an approximate solution to boundary value problems.

Given a linear boundary value problem:
$ f(x, y, y') = p(x)y' + q(x)y + r(x), a<=x<=b, y(a) = alpha,  y(b) = beta $

We can approximate it as the linear combination of the solutions to the following IVPs #cite(<ruaya2026eigen>) #cite(<burden2010numerical>):

Homogenous IVP: $y_H '' = p(x)y_H ' + q(x)y_H, y_H(a) = 0, y_H '(alpha) = 1$

Non-Homogenous IVP: $y_N '' = p(x)y_N ' + q(x)y_N + r(x),y_N(a) = alpha, y_N '(alpha) = 0$

This gives us the general solution: $y = C y_H + y_N$

Then, using the boundary conditions, we can find the value of C that gives the proper solution to the boundary value problem:\
$y(a) = alpha = C y_H(a) + y_N(a) = alpha + 0 $\
$y(b) = beta = C y_H(b) + y_N(b) => C = (beta - y_N(b))/y_H(b)  $
\
$ y(x) = y_N (x) + (beta - y_N(b))/y_H(b) y_H (x) $

#bibliography("/resources/bibs/class_notes/le1/2.4_linear_shooting.bib", style: "apa")
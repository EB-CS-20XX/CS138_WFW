#import "../../../template.typ": project

#show: project.with(
  title: "2.4 Linear Shooting Method",
  contributor: "Enrico U. Baratang, Vin Disu",
  date: "November 4, 2026",
)

#show bibliography: set heading(numbering: none)


= Motivation
How is the shooting method applied in the case of boundary value problems for non-linear SODEs? Since linear shooting is has a special shortcut, non-linear shooting relies on the more iterative process mentioned prior.

Make a guess, $y'(a) = t_k$, solve the resulting IVP to get some solution, $y(b, t_k)$, check to see whether\ $y(b, t_k) = beta$, and adjust accordingly if it isn't. In this way it can be seen as a root-finding problem\ #cite(<ruaya2026eigen>) #cite(<burden2010numerical>).

$ lim_(k→infinity) y(b, t_k) = y(b) = beta $

= Non-Linear Shooting
== Methods
For this discussion, with derivations taken from #cite(<burden2010numerical>, form:"prose") and #cite(<ruaya2026eigen>, form:"prose"), let us use the Newton root-finding method. This will give us an iteration for $t_k$ of the following form:
$ t_(k+1) = t_k - (y(b, t_k) - beta)/((d  )/(d t)y(b,t_k)) $
This method only requires 1 initial point/guess at $t_0$, but requires knowledge of $(d  )/(d t)y(b,t_k)$, which we lack. 

To remedy this let us first express $y$ as $y(x, t)$ and set $ v(x, t) = (partial)/(partial t) y(x, t)$, then take the partial derivative of our SODE with respect to t:

$ (partial)/(partial t) y''(x, t) = (partial )/(partial t)f(x, y(x, t), y'(x, t)) $
$ = (partial )/(partial y)f(x, y(x, t), y'(x, t))(partial )/(partial t)y(x,t) + (partial )/(partial y')f(x, y(x, t), y'(x, t))(partial )/(partial t)y'(x,t) $
Do note that the term $(partial )/(partial x)f(x, y, y')(partial x)/(partial t)$ was omitted, because it would have been zeroed out due to both being independent variables.

Using $v$ we can see that:

$ v''(x, t) = (partial )/(partial y)f(x, y, y')v(x, t) + (partial )/(partial y')f(x, y, y')v'(x, t)  $

And for a<= x <= b we can set initial conditions $v(a, t_0) = 0, v'(a, t_0) = 1$. From here we can iterate, using 2 IVPs per iteration:   

$  t_(k+1) = t_k - (y(b, t_k) - beta)/(v(b,t_k))  , t_0 = (beta-alpha)/(b-a) $

$ y''(x, t) =  f(x, y(x,t), y'(x,t)) \ y(a, t_k) = alpha, y'(a, t_k) = t_k $
$ v''(x, t) = (partial )/(partial y)f(x, y, y')v(x, t) + (partial )/(partial y')f(x, y, y')v'(x, t)\  v(a, t_k) = 0, v'(a, t_k) = 1 $

#bibliography("/resources/bibs/class_notes/le2/2.4_shooting_methods.bib", style: "apa")
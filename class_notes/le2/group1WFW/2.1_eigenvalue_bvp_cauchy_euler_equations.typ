#import "../../../template.typ": project

#show: project.with(
  title: "2.1 Eigenvalue BVPs and Cauchy-Euler Equations",
  contributor: "Princess Chariz D. Bialen",
  date: "October 28, 2026",
)

= Eigenvalue BVPs and Cauchy-Euler Equations

#let fig-pt(p) = (p.at(0) * 1cm, p.at(1) * 1cm)
#let fig-ln(p, q, st: 0.7pt + black) = place(top + left, line(start: fig-pt(p), end: fig-pt(q), stroke: st))
#let fig-ar(p, q, st: 0.7pt + black, s: 0.18) = {
  let dx = q.at(0) - p.at(0)
  let dy = q.at(1) - p.at(1)
  let len = calc.sqrt(dx * dx + dy * dy)
  let ux = dx / len
  let uy = dy / len
  let b = (q.at(0) - s * ux, q.at(1) - s * uy)
  let nx = -uy * s / 3
  let ny = ux * s / 3
  fig-ln(p, b, st: st)
  place(top + left, polygon(fill: st.paint, stroke: none, fig-pt(q), fig-pt((b.at(0) + nx, b.at(1) + ny)), fig-pt((b.at(0) - nx, b.at(1) - ny))))
}
#let fig-pl(pts, st: 0.9pt + black) = place(top + left, curve(stroke: st, curve.move(fig-pt(pts.first())), ..pts.slice(1).map(p => curve.line(fig-pt(p)))))
#let fig-tx(p, body, ax: 0.5, ay: 0.5) = context {
  let m = measure(body)
  place(top + left, dx: p.at(0) * 1cm - m.width * ax, dy: p.at(1) * 1cm - m.height * ay, body)
}
#let fig-dot(p, c, r: 2.2pt) = place(top + left, dx: p.at(0) * 1cm - r, dy: p.at(1) * 1cm - r, circle(radius: r, fill: c, stroke: none))

== Boundary Value Problems
#pad(left: 2em)[
  In CS 136, we always assumed that physical ODEs can be solved using only an initial condition, but a lot of physical phenomena can be modeled by looking at the starting and endpoint result, as in @fig-beam. @ruayavillar2026bvp

  #let fig-draw-1 = box(width: 12.6cm, height: 3.4cm, {
      let x0 = 2.3
      let len = 8.0
      let ax = 1.5
      let top(s) = (x0 + len * s, ax - (0.7 - 1.48 * s * (1 - s)))
      let bot(s) = (x0 + len * s, ax + 2.16 * s * (1 - s))
      let grid-s = range(0, 41).map(i => i / 40)
      fig-ar((x0, ax), (0.6, ax))
      fig-ar((x0, ax), (12.0, ax))
      fig-ar((x0, 3.0), (x0, 0.1))
      fig-pl(grid-s.map(top))
      fig-pl(grid-s.map(bot))
      fig-ln(top(1), bot(1), st: 0.6pt + black)
      for s in (0.173, 0.353, 0.616, 0.789, 0.928) {
        fig-ar(top(s), bot(s), st: 0.5pt + black, s: 0.14)
      }
      let sw = 0.657
      let xw = x0 + len * sw
      let yw = bot(sw).at(1)
      fig-ar((xw, (ax + yw) / 2), (xw, ax), st: 0.6pt + blue, s: 0.12)
      fig-ar((xw, (ax + yw) / 2), (xw, yw), st: 0.6pt + blue, s: 0.12)
      fig-tx((xw + 0.55, yw + 0.45), text(fill: blue)[$w(x)$])
      fig-tx((x0 - 0.5, ax - 0.4), [$S$])
      fig-tx((x0 + len + 0.35, ax - 0.4), [$S$])
      fig-tx((x0 + 0.22, ax + 0.4), [$0$])
      fig-tx((x0 + len - 0.12, ax + 0.4), [$l$])
      fig-tx((12.3, ax + 0.2), [$x$])
    })
  #figure(
    fig-draw-1,
    caption: [A beam between $x = 0$ and $x = l$ with a distributed load, the ends marked $S$ and the deflection $w(x)$. Redrawn from the slide. @ruayavillar2026bvp],
  ) <fig-beam>

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Initial Value Problems vs Boundary Value Problems
    #line(length: 100%)
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.5em,
      [
        *(a) Initial value problem*
        $ (d y_1)/(d t) = f_1 (t, y_1, y_2) $
        $ (d y_2)/(d t) = f_2 (t, y_1, y_2) $
        where at $t = 0$, $y_1 = y_(1,0)$ and $y_2 = y_(2,0)$. \
        Both conditions are given at the *same point*, #box[$t = 0$].
      ],
      [
        *(b) Boundary value problem*
        $ (d^2 y)/(d x^2) = f(x, y) $
        where at $x = 0$, $y = y_0$; and at $x = L$, $y = y_L$. \
        The conditions are given at *two different points*, $x = 0$ and $x = L$.
      ],
    )
  ]

  #let fig-draw-2 = box(width: 16.2cm, height: 5.6cm, {
      let oy = 4.5
      let oa = 3.4
      let tl = 4.1
      let ya = t => 2.0 + 1.3 * calc.cos(2 * calc.pi * t / 3.9)
      let ts = range(0, 42).map(i => i * tl / 41)
      fig-ar((oa, oy), (oa + tl + 0.4, oy))
      fig-ar((oa, oy), (oa, 0.3))
      fig-pl(ts.map(t => (oa + t, oy - ya(t))), st: 1.1pt + black)
      fig-pl(ts.map(t => (oa + t, oy - (4.0 - ya(t)))), st: 1.1pt + black)
      fig-tx((oa - 0.2, 0.15), [$y$])
      fig-tx((oa + tl + 0.65, oy), [$t$])
      fig-tx((oa, oy + 0.35), [$0$])
      fig-tx((oa - 0.12, oy - 3.3), [$y_(1,0)$], ax: 1)
      fig-tx((oa - 0.12, oy - 0.7), [$y_(2,0)$], ax: 1)
      fig-tx((oa + tl + 0.35, oy - ya(tl)), [$y_1$], ax: 0)
      fig-tx((oa + tl + 0.35, oy - (4.0 - ya(tl))), [$y_2$], ax: 0)
      fig-tx((1.1, oy - 2.0), text(size: 9pt)[Initial \ conditions])
      fig-ar((1.75, oy - 2.4), (oa - 0.75, oy - 3.1), st: 0.6pt + black, s: 0.14)
      fig-ar((1.75, oy - 1.6), (oa - 0.75, oy - 0.9), st: 0.6pt + black, s: 0.14)
      fig-tx((oa + 1.9, oy + 0.95), [(a)])
      let ob = 11.6
      let xl = 3.6
      let yb = u => 1.1 + 0.9 * u + 4 * 1.85 * u * (1 - u)
      let us = range(0, 42).map(i => i / 41)
      fig-ar((ob, oy), (ob + xl + 0.9, oy))
      fig-ar((ob, oy), (ob, 0.3))
      fig-ln((ob + xl, oy - 0.1), (ob + xl, oy + 0.1), st: 0.6pt + black)
      fig-pl(us.map(u => (ob + xl * u, oy - yb(u))), st: 1.1pt + black)
      fig-tx((ob - 0.2, 0.15), [$y$])
      fig-tx((ob + xl + 1.15, oy), [$x$])
      fig-tx((ob, oy + 0.35), [$0$])
      fig-tx((ob + xl, oy + 0.35), [$L$])
      fig-tx((ob - 0.12, oy - 1.1), [$y_0$], ax: 1)
      fig-tx((ob + xl + 0.1, oy - 2.0), [$y_L$], ax: 0)
      fig-tx((ob - 2.15, oy - 2.2), text(size: 9pt)[Boundary \ condition])
      fig-ar((ob - 1.4, oy - 1.85), (ob - 0.6, oy - 1.2), st: 0.6pt + black, s: 0.14)
      fig-tx((ob + xl - 0.2, 0.9), text(size: 9pt)[Boundary \ condition])
      fig-ar((ob + xl + 0.05, 1.55), (ob + xl + 0.12, oy - 2.2), st: 0.6pt + black, s: 0.14)
      fig-tx((ob + 1.9, oy + 0.95), [(b)])
    })
  #figure(
    fig-draw-2,
    caption: [BVPs vs IVPs: (a) both initial conditions are given at $t = 0$; (b) one boundary condition at each end, $x = 0$ and $x = L$. Redrawn from the slide. @ruayavillar2026bvp],
  ) <fig-bvp-ivp>
]

== CS 136 Warm-up: $y'' + 4y = 0$
#pad(left: 2em)[
  The CS 136 warm-up asks for the solution of $y'' + 4y = 0$ under two kinds of conditions: the IVP $y(0) = y'(0) = 0$ and the BVP $y(0) = y(pi) = 0$. @ruayavillar2026bvp

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: IVP and BVP for $y'' + 4y = 0$
    #line(length: 100%)
    Find the solutions of $y'' + 4y = 0$ with (i) the IVP $y(0) = y'(0) = 0$ and (ii) the BVP $y(0) = y(pi) = 0$.

    Try $y = e^(m x)$ (@fig-whiteboard): $(m^2 + 4) e^(m x) = 0$, so $m^2 + 4 = 0$ and $m = plus.minus 2i$. Then
    $ y = C_1 sin(2x) + C_2 cos(2x), quad y' = 2C_1 cos(2x) - 2C_2 sin(2x). $

    *IVP:* $y(0) = C_2 = 0$ and $y'(0) = 2C_1 = 0$, so $C_1 = C_2 = 0$ and $y = 0$ is the only solution.

    *BVP:* $y(0) = C_2 = 0$, and $y(pi) = C_1 sin(2 pi) = 0$ holds for every $C_1$, so
    $ y = C_1 sin(2x). $
    The IVP has one solution; the BVP has infinitely many.
  ]
]

== Supplement: Unit Circle
#pad(left: 2em)[
  The lecture includes the unit circle as a supplement (@fig-unit-circle). @ruayavillar2026bvp

  #let fig-draw-3 = box(width: 16cm, height: 10.2cm, {
      let cx = 8.0
      let cy = 5.1
      let r = 3.5
      let at(deg, rr) = (cx + rr * calc.cos(deg * 1deg), cy - rr * calc.sin(deg * 1deg))
      let data = (
        (0, "0", "(1, 0)"),
        (30, "pi/6", "(sqrt(3)/2, 1/2)"),
        (45, "pi/4", "(sqrt(2)/2, sqrt(2)/2)"),
        (60, "pi/3", "(1/2, sqrt(3)/2)"),
        (90, "pi/2", "(0, 1)"),
        (120, "(2 pi)/3", "(-1/2, sqrt(3)/2)"),
        (135, "(3 pi)/4", "(-sqrt(2)/2, sqrt(2)/2)"),
        (150, "(5 pi)/6", "(-sqrt(3)/2, 1/2)"),
        (180, "pi", "(-1, 0)"),
        (210, "(7 pi)/6", "(-sqrt(3)/2, -1/2)"),
        (225, "(5 pi)/4", "(-sqrt(2)/2, -sqrt(2)/2)"),
        (240, "(4 pi)/3", "(-1/2, -sqrt(3)/2)"),
        (270, "(3 pi)/2", "(0, -1)"),
        (300, "(5 pi)/3", "(1/2, -sqrt(3)/2)"),
        (315, "(7 pi)/4", "(sqrt(2)/2, -sqrt(2)/2)"),
        (330, "(11 pi)/6", "(sqrt(3)/2, -1/2)"),
      )
      fig-ar((cx - 4.5, cy), (cx + 4.5, cy), st: 0.7pt + black)
      fig-ar((cx, cy + 4.3), (cx, cy - 4.3), st: 0.7pt + black)
      place(top + left, dx: (cx - r) * 1cm, dy: (cy - r) * 1cm, circle(radius: r * 1cm, stroke: 0.8pt + black))
      fig-tx((cx + 4.5, cy + 0.3), [$x$])
      fig-tx((cx + 0.25, cy - 4.55), [$y$])
      for (deg, rad, co) in data {
        let col = if calc.rem(deg, 90) == 0 { black } else if calc.rem(deg, 45) == 0 { red } else { blue }
        fig-dot(at(deg, r), col)
        let c = calc.cos(deg * 1deg)
        let body = text(size: 8pt, fill: col)[#deg° #h(2pt) #eval(rad, mode: "math")#if co != none [ #h(3pt) #eval(co, mode: "math")]]
        if deg == 90 {
          fig-tx((cx + 0.15, cy - r - 0.45), body, ax: 0)
        } else if deg == 270 {
          fig-tx((cx + 0.15, cy + r + 0.5), body, ax: 0)
        } else if deg == 0 {
          fig-tx((cx + r + 0.15, cy - 0.12), body, ax: 0, ay: 1)
        } else if deg == 180 {
          fig-tx((cx - r - 0.15, cy - 0.12), body, ax: 1, ay: 1)
        } else if c > 0.01 {
          fig-tx(at(deg, r + 0.2), body, ax: 0)
        } else {
          fig-tx(at(deg, r + 0.2), body, ax: 1)
        }
      }
    })
  #figure(
    fig-draw-3,
    caption: [Unit circle with the angles in degrees and radians and the points $(cos theta, sin theta)$. Redrawn from the slide, which credits Wikipedia. @ruayavillar2026bvp],
  ) <fig-unit-circle>
]

== CS 138 Warm-up: $y'' + lambda y = 0$
#pad(left: 2em)[
  The CS 138 warm-up replaces the constant $4$ by a parameter $lambda$, $y'' + lambda y = 0$, that is, $y'' = -lambda y$, and asks for $y$ when $lambda < 0$, $lambda = 0$ and $lambda > 0$, and for the IVP $y(0) = y'(0) = 0$. @ruayavillar2026bvp

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Solutions of $y'' + lambda y = 0$
    #line(length: 100%)
    Trying $y = e^(m x)$ gives $m^2 + lambda = 0$, so $m = plus.minus sqrt(-lambda)$. The type of the roots depends on the sign of $lambda$:

    #table(
      columns: (auto, auto, auto, 1fr),
      align: (center, center, left, left),
      inset: 6pt,
      stroke: 0.5pt + luma(150),
      [*Case*], [*Roots $m$*], [*Type*], [*Solution $y(x)$*],
      [$lambda < 0$], [$plus.minus sqrt(-lambda)$], [distinct real], [$y = C_1 e^(-sqrt(-lambda) x) + C_2 e^(sqrt(-lambda) x)$],
      [$lambda = 0$], [$0, 0$], [repeated real], [$y = C_1 + C_2 x$],
      [$lambda > 0$], [$plus.minus i sqrt(lambda)$], [complex], [$y = C_1 sin(sqrt(lambda) x) + C_2 cos(sqrt(lambda) x)$],
    )

    *IVP $y(0) = y'(0) = 0$:* $C_1 = C_2 = 0$ in every case, so $y = 0$ is the only solution.
  ]
]

== Dirichlet Eigenvalue Problem
#pad(left: 2em)[
  The last warm-up question asks for $L$ and $lambda > 0$ such that $y'' + lambda y = 0$ with $y(0) = y(L) = 0$ has a nontrivial solution $y$ (a Dirichlet BVP), as worked out on the board in @fig-whiteboard. @ruayavillar2026bvp

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: Dirichlet BVP $y(0) = y(L) = 0$
    #line(length: 100%)
    Find all $lambda$ for which $y'' + lambda y = 0$, $y(0) = y(L) = 0$ ($L > 0$) has a nontrivial solution.

    *$lambda < 0$:* with $k = sqrt(-lambda)$, $y = C_1 e^(-k x) + C_2 e^(k x)$. Then $y(0) = 0$ gives $C_2 = -C_1$, so $y(L) = -2 C_1 sinh(k L) = 0$ forces $C_1 = 0$: only $y = 0$.

    *$lambda = 0$:* $y = C_1 + C_2 x$, and $y(0) = C_1 = 0$, $y(L) = C_2 L = 0$: only $y = 0$.

    *$lambda > 0$:* $y = C_1 sin(sqrt(lambda) x) + C_2 cos(sqrt(lambda) x)$. Then $y(0) = C_2 = 0$, and $y(L) = C_1 sin(sqrt(lambda) L) = 0$ with $C_1 != 0$ gives
    $ sqrt(lambda_n) L = n pi, quad n = 1, 2, dots $
    Hence
    $ lambda_n = ((n pi)/L)^2, quad y_n (x) = a_n sin((n pi x)/L), quad a_n != 0. $
    The $y_n$ are the *eigenfunctions*, and the answer is a linear combination of them:
    $ y = sum_(n=1)^oo C_n sin((n pi)/L x) $
  ]

  #let fig-draw-4 = block(width: 100%, {
      set text(size: 8.5pt)
      let boxed(body) = box(stroke: 0.6pt + black, inset: (x: 3pt, y: 2.5pt), radius: 3pt, body)
      let col(title, body) = block(
        width: 100%,
        fill: rgb("eef5f1"),
        stroke: 0.6pt + luma(150),
        inset: 7pt,
        radius: 3pt,
        {
          align(center)[*#title*]
          v(2pt)
          align(left, body)
        },
      )
      grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 6pt,
        align: top,
        col([CS 136], [
          $m^2 + lambda = 0$ \
          $m = plus.minus sqrt(-lambda)$ \
          $y'' = -lambda y$ \
          #v(4pt)
          $y'' + 4y = 0$, try $y = e^(m x)$: \
          $m^2 e^(m x) + 4 e^(m x) = 0$ \
          $(m^2 + 4) e^(m x) = 0$ #h(4pt) ($e^(m x) != 0$) \
          $m^2 + 4 = 0$ \
          $m = plus.minus 2i$ \
          #v(4pt)
          $y = C_1 sin(2x) + C_2 cos(2x)$ \
          $y(0) = C_2 dot 1 = 0$ #h(2pt) #boxed[$C_2 = 0$] \
          $y' = 2C_1 cos(2x) - 2C_2 sin(2x)$ \
          $y'(0) = 2C_1 = 0$ #h(2pt) #boxed[$C_1 = 0$]
        ]),
        col([CS 138], [
          $y(pi) = 0$ \
          #boxed[$y = C sin(2x)$] \
          $y(pi) = C_1 sin(2 pi) = 0$ #h(4pt) ($C_1$ free) \
          #line(length: 100%, stroke: 0.5pt)
          $y'' + lambda y = 0 => y'' = -lambda y$ \
          $m = sqrt(-lambda)$ \
          #table(
            columns: (auto, auto),
            inset: 3pt,
            stroke: none,
            [Distinct real:], [$lambda < 0$],
            [Repeated real:], [$lambda = 0$],
            [#boxed[Complex:]], [#boxed[$lambda > 0$]],
          )
        ]),
        col([$y(0) = y(L) = 0$], [
          $y = C_1 sin(sqrt(lambda) x) + cancel(C_2 cos(sqrt(lambda) x))$ \
          $y(0) = 0$: $C_2 cos(0) = 0$ #h(2pt) #boxed[$C_2 = 0$] \
          $y(L) = C_1 sin(sqrt(lambda) L) = 0$ \
          $sin(sqrt(lambda) L) = 0$ iff \
          $sqrt(lambda_n) L = n pi$, #h(4pt) $n = 1, 2, dots$ \
          $lambda_n = ((n pi)/L)^2$ \
          #v(4pt)
          #boxed[$y = sum_(n=1)^oo C_n sin((n pi)/L x)$]
        ]),
      )
    })
  #figure(
    fig-draw-4,
    kind: image,
    supplement: [Figure],
    caption: [The lecturer's whiteboard work from the 30 September 2026 lecture, retyped in three columns. @ruayavillar2026bvp],
  ) <fig-whiteboard>
]

== Eigenvectors and Eigenfunctions
#pad(left: 2em)[
  An eigenvalue problem asks for the special values $lambda$ for which an equation has a nonzero solution. We start from the CS 136 version for matrices and then state the version for differentiation. @ruayavillar2026bvp[Slides 7 and 9]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Eigenvector--Eigenvalue Problem
    #line(length: 100%)
    In CS 136, for a matrix $A$ we look for a number $lambda$ and a vector $x$ with
    $ underbrace(A x, "Transformation" times "vector") = underbrace(lambda x, "Constant" times "vector") $
    @ruayavillar2026bvp[Slide 7]
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Eigenvalue Problem
    #line(length: 100%)
    An eigenvalue problem for differentiation is of the form
    $ y^((n)) = (d^n)/(d x^n) [y] = cal(L)_n [y] = -lambda y $
    that is, applying the $n$-th differentiation operator $cal(L)$ to a function $y$ is the same as scaling it by some constant $-lambda$. @ruayavillar2026bvp[Slide 9]
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Eigenvectors vs Eigenfunctions
    #line(length: 100%)
    The slide has one line for each course, both saying "for special values $lambda != 0$": @ruayavillar2026bvp[Slide 9]

    #table(
      columns: (auto, auto, auto, auto),
      align: (center, left, center, center),
      inset: 6pt,
      stroke: 0.5pt + luma(150),
      [*Course*], [*Solutions are called*], [*Equation*], [*For special values*],
      [CS 136], [eigenvectors $bold(v) != bold(0)$], [$A bold(v) = lambda bold(v)$], [$lambda != 0$],
      [CS 138], [eigenfunctions $y != 0$], [$cal(L)[y] = -lambda y$], [$lambda != 0$],
    )
  ]
]

== Differential Operators
#pad(left: 2em)[
  Slide 8 ("It's all MATH 40? Always has been...") recalls that differentiation is linear, names the differential operator, and passes from a linear homogeneous ODE (HODE) to an eigenvalue problem; the second box connects this to the linear systems of CS 136. @ruayavillar2026bvp[Slide 8]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Differential Operator
    #line(length: 100%)
    Differentiation is linear: for constants $alpha$ and $beta$
    $ (alpha f + beta g)^((n)) = alpha f^((n)) + beta g^((n)) $
    The expression
    $ cal(L) = a_0 D^n + a_1 D^(n-1) + dots.c + a_(n-1) D + a_n $
    is called a *differential operator* of order $n$, where
    $ cal(L)[y] = a_0 (d^n y)/(d x^n) + a_1 (d^(n-1) y)/(d x^(n-1)) + dots.c + a_(n-1) (d y)/(d x) + a_n y. $
    @ruayavillar2026bvp[Slide 8]
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Note on Linear Systems of ODEs
    #line(length: 100%)
    The same idea appears in CS 136. A linear homogeneous system of ODEs $dot(x)(t) = A x(t)$ with a constant $n times n$ matrix $A$ yields the eigenvalue problem and the solution
    $ (A - lambda_i I) bold(v)_i = 0, quad bold(v)_i != bold(0), quad x(t) = sum_(i=1)^n c_i bold(v)_i e^(lambda_i t), $
    where the $c_i$ are constants (the solution form needs $A$ to have $n$ linearly independent eigenvectors). The factor $e^(lambda_i t)$ is the scalar. @ruayavillar2026bvp[Slide 8]
  ]
]

== Boundary Conditions
#pad(left: 2em)[
  An eigenvalue problem for a differential equation comes with conditions at the two ends $x = 0$ and $x = L$; slide 10 lists the types. @ruayavillar2026bvp[Slide 10]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Types of Boundary Conditions
    #line(length: 100%)
    #table(
      columns: (auto, 1fr),
      align: (left, left),
      inset: 6pt,
      stroke: 0.5pt + luma(150),
      [*Type*], [*Conditions*],
      [Dirichlet], [$y(0) = alpha, quad y(L) = beta$],
      [Neumann], [$y'(0) = alpha, quad y'(L) = beta$],
      [Mixed (D--N)], [$y(0) = alpha, quad y'(L) = beta$],
      [Mixed (N--D)], [$y'(0) = alpha, quad y(L) = beta$],
      [Periodic], [$y(0) = y(L), quad y'(0) = y'(L)$],
      [Robin (linear)], [$alpha y(0) + beta y'(0) = 0, quad gamma y(L) + delta y'(L) = 0$],
    )
    The eigenvalue examples are homogeneous, that is, $alpha = beta = 0$ in the first four rows. @ruayavillar2026bvp[Slide 10]
  ]
]

== Eigenvalue BVPs with Other Boundary Conditions
#pad(left: 2em)[
  Slides 11 to 13 solve the eigenvalue problem $y'' + lambda y = 0$, that is, $y'' = -lambda y$, with the Neumann, Mixed and Periodic conditions. @ruayavillar2026bvp[Slides 11-13] Each case $lambda < 0$, $lambda = 0$, $lambda > 0$ is checked, with $k = sqrt(-lambda)$ and $s = sqrt(lambda)$.

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: Neumann BC $y'(0) = y'(L) = 0$
    #line(length: 100%)
    Find all $lambda$ for which $y'' + lambda y = 0$, $y'(0) = y'(L) = 0$ ($L > 0$) has a nontrivial solution. @ruayavillar2026bvp[Slide 11]

    *$lambda < 0$:* $y = C_1 e^(-k x) + C_2 e^(k x)$. Then $y'(0) = k (-C_1 + C_2) = 0$ gives $C_2 = C_1$, so $y'(L) = 2k C_1 sinh(k L) = 0$ forces $C_1 = 0$: only $y = 0$.

    *$lambda = 0$:* $y = C_1 + C_2 x$, so $y'(0) = y'(L) = C_2 = 0$ and $C_1$ is free: $lambda = 0$ #emph[is] an eigenvalue, with $y_0 = 1$.

    *$lambda > 0$:* $y = C_1 sin(s x) + C_2 cos(s x)$. Then $y'(0) = s C_1 = 0$ gives $C_1 = 0$, and $y'(L) = -s C_2 sin(s L) = 0$ with $C_2 != 0$ gives $sqrt(lambda) L = n pi$. Together with $lambda = 0$:
    $ lambda_n = ((n pi)/L)^2, quad y_n (x) = cos((n pi x)/L), quad n = 0, 1, 2, dots $
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: Mixed BC $y'(0) = y(L) = 0$
    #line(length: 100%)
    Find all $lambda$ for which $y'' + lambda y = 0$, $y'(0) = y(L) = 0$ ($L > 0$) has a nontrivial solution (the Mixed N--D type of slide 10). @ruayavillar2026bvp[Slide 12]

    *$lambda < 0$:* $y = C_1 e^(-k x) + C_2 e^(k x)$. Then $y'(0) = 0$ gives $C_2 = C_1$, so $y(L) = 2 C_1 cosh(k L) = 0$ forces $C_1 = 0$ (as $cosh(k L) >= 1$): only $y = 0$.

    *$lambda = 0$:* $y = C_1 + C_2 x$, so $y'(0) = C_2 = 0$ and $y(L) = C_1 = 0$: only $y = 0$.

    *$lambda > 0$:* $y = C_1 sin(s x) + C_2 cos(s x)$. Then $y'(0) = s C_1 = 0$ gives $C_1 = 0$, and $y(L) = C_2 cos(s L) = 0$ with $C_2 != 0$ gives
    $ sqrt(lambda_n) L = ((2n - 1) pi)/2, quad n = 1, 2, dots $
    Hence
    $ lambda_n = (((2n - 1) pi)/(2L))^2, quad y_n (x) = b_n cos(((2n - 1) pi x)/(2L)), quad b_n != 0. $
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: Periodic BC $y(0) = y(L)$, $y'(0) = y'(L)$
    #line(length: 100%)
    Find all $lambda$ for which $y'' + lambda y = 0$ with $y(0) = y(L)$ and $y'(0) = y'(L)$ ($L > 0$) has a nontrivial solution. Hint (slide): the half-angle identity $(1 - cos x)/2 = sin^2(x/2)$. @ruayavillar2026bvp[Slide 13]

    *$lambda < 0$:* $y = C_1 e^(-k x) + C_2 e^(k x)$. With $a = 1 - e^(-k L) > 0$ and $b = 1 - e^(k L) < 0$,
    $
      y(0) - y(L) &= C_1 a + C_2 b = 0 \
      (y'(0) - y'(L))/k &= -C_1 a + C_2 b = 0
    $
    Adding gives $C_2 = 0$, then $C_1 = 0$: only $y = 0$.

    *$lambda = 0$:* $y = C_1 + C_2 x$, and $y(0) = y(L)$ gives $C_2 = 0$; $y'(0) = y'(L)$ then holds. So $lambda_0 = 0$ is an eigenvalue, with $y_0 = 1$.

    *$lambda > 0$:* $y = C_1 sin(s x) + C_2 cos(s x)$. The two conditions give
    $ mat(sin(s L), cos(s L) - 1; cos(s L) - 1, -sin(s L)) vec(C_1, C_2) = vec(0, 0), $
    whose determinant is $-2 (1 - cos(s L)) = -4 sin^2((s L)/2)$ (half-angle identity). A nontrivial solution needs $sin((sqrt(lambda) L)/2) = 0$, so $sqrt(lambda_n) L = 2 n pi$, $n = 1, 2, dots$ The matrix is then zero, so $C_1$ and $C_2$ are both free:
    $ lambda_n = (4 n^2 pi^2)/L^2, quad y_n (x) = a_n cos((2 n pi)/L x) + b_n sin((2 n pi)/L x). $
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, breakable: false, stroke: 0.5pt + luma(150))[
    === Summary of Eigenvalue BVPs
    #line(length: 100%)
    For $y'' + lambda y = 0$ on $0 <= x <= L$:

    #set par(justify: false)
    #table(
      columns: (auto, auto, auto, auto),
      align: (left, center, center, center),
      inset: 6pt,
      stroke: 0.5pt + luma(150),
      [*BC type*], [*Eigenvalues $lambda_n$*], [*Eigenfunctions $y_n$*], [*$n$ starts at*],
      [Dirichlet \ $y(0) = y(L) = 0$], [$((n pi)/L)^2$], [$sin((n pi x)/L)$], [$1$],
      [Neumann \ $y'(0) = y'(L) = 0$], [$((n pi)/L)^2$], [$cos((n pi x)/L)$], [$0$ ($lambda_0 = 0$, $y_0 = 1$)],
      [Mixed (N--D) \ $y'(0) = y(L) = 0$], [$(((2n - 1) pi)/(2L))^2$], [$cos(((2n - 1) pi x)/(2L))$], [$1$],
      [Periodic \ $y(0) = y(L)$, $y'(0) = y'(L)$], [$((2 n pi)/L)^2$], [$cos((2 n pi x)/L)$ and $sin((2 n pi x)/L)$], [$0$ ($y_0 = 1$ only)],
    )

    *Note:* the Neumann row and the ranges of $n$ are worked out, not from the slides.
  ]
]

== Cauchy-Euler Equations
#pad(left: 2em)[
  A Cauchy-Euler equation is a second-order linear equation $a x^2 y'' + b x y' + c y = 0$ with real constants $a, b, c$. The substitution $x = e^t$ turns it into an equation with constant coefficients, which CS 136 methods solve. @ruayavillar2026bvp[Slides 14 and 15]

  *Note:* the substitution uses $t = ln x$, so $x > 0$ is assumed throughout, and $a != 0$ so that the equation is of second order.

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Cauchy-Euler Substitution
    #line(length: 100%)
    Given $a x^2 y'' + b x y' + c y = 0$ with $y = y(x)$ and $a, b, c in RR$, let $x = e^t$, so $t = ln x$. @ruayavillar2026bvp[Slide 14]

    Since $(d x)/(d t) = e^t$ and $(d t)/(d x) = e^(-t)$, the chain rule gives
    $
      (d y)/(d x) &= (d y)/(d t) dot (d t)/(d x) = e^(-t) (d y)/(d t),       (d^2 y)/(d x^2) &= d/(d t) [e^(-t) (d y)/(d t)] dot e^(-t) = e^(-2t) [(d^2 y)/(d t^2) - (d y)/(d t)].
    $
    Substituting,
    $
      a (e^t)^2 (e^(-2t) [(d^2 y)/(d t^2) - (d y)/(d t)]) + b e^t ((d y)/(d t) e^(-t)) + c y &
    $$
      = 0       a [(d^2 y)/(d t^2) - (d y)/(d t)] + b dot (d y)/(d t) + c y &= 0       a dot (d^2 y)/(d t^2) + (b - a) dot (d y)/(d t) + c y &= 0
    $
    This is a linear equation with constant coefficients in $y = y(t) = y(ln x)$. @ruayavillar2026bvp[Slide 15]
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Indicial Equation
    #line(length: 100%)
    The substituted equation is solved with $y = e^(r t) = x^r$, which gives the *indicial equation*
    $ a r^2 + (b - a) r + c = 0. $
    The slide notes that it can also be obtained directly with $y = x^r$. @ruayavillar2026bvp[Slide 15]

    Direct derivation: with $y = x^r$, $y' = r x^(r-1)$ and $y'' = r (r - 1) x^(r-2)$, so
    $
      a x^2 y'' + b x y' + c y &= [a r (r - 1) + b r + c] x^r \
      &= [a r^2 + (b - a) r + c] x^r,
    $
    which is $0$ for $x > 0$ exactly when $a r^2 + (b - a) r + c = 0$.
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Solutions of the Cauchy-Euler Equation
    #line(length: 100%)
    The form of the solution depends on the roots $r$ of the indicial equation, with $t = ln x$ and $e^(r t) = x^r$. @ruayavillar2026bvp[Slide 15]

    #set par(justify: false)
    #block(breakable: false, table(
      columns: (auto, auto, auto),
      align: (left, left, left),
      inset: 6pt,
      stroke: 0.5pt + luma(150),
      [*Roots $r$*], [*$y(t)$*], [*$y(x)$*],
      [Real distinct \ $r_1 != r_2$],
      [$C_1 e^(r_1 t) + C_2 e^(r_2 t)$],
      [$C_1 x^(r_1) + C_2 x^(r_2)$],
      [Real repeated \ $r$],
      [$(C_1 + C_2 t) e^(r t)$],
      [$(C_1 + C_2 ln x) x^r$],
      [Complex \ $r = alpha plus.minus beta i$],
      [$C_1 e^(alpha t) cos(beta t) + C_2 e^(alpha t) sin(beta t)$],
      [$x^alpha [C_1 cos(beta ln x) + C_2 sin(beta ln x)]$],
    ))
  ]
]

== Cauchy-Euler Examples
#pad(left: 2em)[
  Slides 16 and 17 solve three Cauchy-Euler equations, one with distinct real roots and two with complex roots. Each is solved by writing the indicial equation $a r^2 + (b - a) r + c = 0$, finding its roots, and reading off $y(t)$ and $y(x)$. @ruayavillar2026bvp[Slides 16 and 17]

  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: $x^2 y'' - 6 x y' - 18 y = 0$
    #line(length: 100%)
    Solve $x^2 y'' - 6 x y' - 18 y = 0$ for $x > 0$. @ruayavillar2026bvp[Slide 16]

    Here $a = 1$, $b = -6$, $c = -18$, so the indicial equation is
    $ r (r - 1) - 6 r - 18 = r^2 - 7 r - 18 = (r - 9)(r + 2) = 0, $
    with real distinct roots $r_1 = 9$, $r_2 = -2$. With $t = ln x$ and $e^(r t) = x^r$:
    $ y(t) = C_1 e^(9 t) + C_2 e^(-2 t), quad y(x) = C_1 x^9 + C_2 x^(-2). $
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: $2 x^2 y'' + 5 y = 0$
    #line(length: 100%)
    Solve $2 x^2 y'' + 5 y = 0$ for $x > 0$. @ruayavillar2026bvp[Slide 17]

    Here $a = 2$, $b = 0$, $c = 5$, so the indicial equation is
    $ 2 r (r - 1) + 5 = 0 quad => quad r^2 - r + 5/2 = 0, quad r = (1 plus.minus sqrt(1 - 10))/2 = (1 plus.minus 3 i)/2, $
    complex with $alpha = 1/2$, $beta = 3/2$. Then
    $
      y(t) &= e^(t slash 2) (C_1 cos((3 t)/2) + C_2 sin((3 t)/2)), \
      y(x) &= x^(1 slash 2) (C_1 cos(3/2 ln x) + C_2 sin(3/2 ln x)).
    $
  ]

  #v(0.6em)
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, width: 100%, stroke: 0.5pt + luma(150))[
    === Worked Example: $x^2 y'' + x y' + 9 y = 0$
    #line(length: 100%)
    Solve $x^2 y'' + x y' + 9 y = 0$ for $x > 0$. @ruayavillar2026bvp[Slide 17]

    Here $a = 1$, $b = 1$, $c = 9$, so the indicial equation is
    $ r (r - 1) + r + 9 = r^2 + 9 = 0, quad r = plus.minus 3 i, $
    complex with $alpha = 0$, $beta = 3$. Then
    $
      y(t) &= C_1 cos(3 t) + C_2 sin(3 t), \
      y(x) &= C_1 cos(3 ln x) + C_2 sin(3 ln x).
    $
  ]
]

== AI Contribution

_Used Claude Code (Anthropic; Sonnet 5.5 for drafting in Typst, Opus 5.5 for planning and math checks). I wrote the slide content and the bare algebraic solutions of the worked examples. Claude typeset them, redrew the figures, wrote the connecting sentences, and corrected the typos on the slides._ \
_Prompts and outputs:_ #link("https://drive.google.com/file/d/1vSJ02tEHjCfokbtXB85fmZqp_Rp_ZEPY/view?usp=sharing")


#bibliography("../../../resources/bibs/class_notes/le2/2.1_eigenvalue_bvp_cauchy_euler_equations.bib", style: "apa", full: true) 
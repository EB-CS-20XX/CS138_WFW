#import "../../../template.typ": project

#show: project.with(
  title: "1.3 Gershgorin Circle Theorem",
  contributor: "Enrico U. Baratang",
  date: "September 24, 2026",
)

#show bibliography: set heading(numbering: none)

= Motivation

Recall how the Inverse Shifted Power Method converges quickest when the shift, $sigma$, is very close to an actual eigenvalue, $lambda$. How do we come up with a $sigma$ that is close to $lambda$?

== Gershgorin Circle Theorem
This theorem states that For any complex eigenvalues and rows, $i$, in the matrix $A$

$ |lambda - a_(i\i)| <= limits(sum)_(c=1, c!=i)^n |a_(i\c)| $

This inequality forms *Gershgorin Discs* centered at $a_(i\i)$ with a radius of $limits(sum)_(c=1, c!=i)^n |a_(i\c)|$ wherein the eigenvalues of $A$ can be found somewhere within them. #cite(<ruaya2026eigen>)

$ D_i = {z ∈ CC: |z-a_(i\i)| <= limits(sum)_(c=1, c!=i)^n |a_(i\c)| } $

Furthermore, if any Disc is not intersecting with any other disc, there must be an eigenvalue inside it. And if any $k$ discs are intersecting, there must be $k$ eigenvalues present within their union.

Knowing this can allow us to find values that are close to eigenvalues, for applications such as the Inverse Shifted Power Method.

#bibliography("/resources/bibs/class_notes/le1/1.3_gershgorin_circle_theorem.bib", style: "apa")
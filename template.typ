// template.typ — Simple Course Template (Typst 0.13+)

#let project(
  title: "",
  contributor: "",
  date: "",
  body,
) = {
  // Page Setup
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    header: context {
      if here().page() > 1 [
        #text(size: 8pt, fill: luma(120))[CS 138 — #title]
        #h(1fr)
        #text(size: 8pt, fill: luma(120))[#contributor]
      ]
    },
    footer: context {
      align(center)[
        #text(size: 9pt, fill: luma(120))[#counter(page).display()]
      ]
    }
  )

  // Document Styling
  set text(font: "Liberation Serif", size: 11pt)
  set par(justify: true, leading: 0.7em)
  set heading(numbering: "1.1")

  // Simple Header Block
  v(0.5em)
  align(center)[
    #text(size: 16pt, weight: "bold")[#title] \
    #v(0.4em)
    #text(size: 9pt, fill: luma(80))[
      Contributor: #contributor | Date: #date
    ]
  ]
  v(1em)
  line(length: 100%, stroke: 0.5pt + luma(180))
  v(1em)

  // Document Body
  body
}
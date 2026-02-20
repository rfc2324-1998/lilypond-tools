\version "2.24.4"

\header {
  title = "Piano Template"
  composer = "Your Name"
  tagline = ##f
}

rightHand = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4
  
  % Right hand notes here
  c4 d e f |
  g2 e |
  f4 e d c |
  c1 |
  
  \bar "|."
}

leftHand = \relative c {
  \clef bass
  \key c \major
  \time 4/4
  
  % Left hand notes here
  c2 g' |
  e2 c |
  f2 g |
  c,1 |
  
  \bar "|."
}

\score {
  \new PianoStaff <<
    \new Staff = "RH" {
      \rightHand
    }
    \new Staff = "LH" {
      \leftHand
    }
  >>
  \layout { }
  \midi {
    \tempo 4 = 100
  }
}

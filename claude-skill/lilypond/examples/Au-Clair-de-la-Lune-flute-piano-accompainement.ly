\version "2.24.4"

\header {
  title = "Au Clair de la Lune"
  composer = "F major flute accompaniment"
}


\parallelMusic introTreb, introBass {
  f4\(^1 f f g |
  c^I-5 a' f a |

  a2 g |
  <c, f a>2 e-3 |

  f4 a g g |
  f2-2 <c e g>2^V_"LH stays ->" |

  f2\) r2 |
  f4^I-2 c-5 f c |
}

\parallelMusic secondTreb, secondBass {
  f4\(^1 f f g |
  c-5 a' f a |

  a2 g |
  <c, f a>2 e |

  f4 a g g |
  f2-2 <c e g>2^V |

  f2\) r2 |
  a'4^I-3 c-1 a-2 f-4 |
}

\parallelMusic thirdTreb, thirdBass {
  g4\( g g g |
  e2-5^V c' |

  d2 d\) |
  d,4-5^ii g-2 d g |

  g4\(^5 f e d |
  d1 |

  c2\)^1 r |
  c'4^I-1 bes-\markup "♭" a g |
}

\parallelMusic outroTreb, outroBass {
  f4\(^1 f f g |
  f^I c' a-3 bes-\markup "♭" |

  a2 g |
  <f a c>2 bes-\markup "♭" |

  f4 a g g |
  a2-1 <c, e g>2^V |

  f2\) r2 |
  <a c f>1^I-1-3-5 |
}

fluteMusic = \new Voice \relative c' {
  \voiceOne
  \set midiInstrument = "flute"
  \introTreb
  \bar "||"
  \break
  \secondTreb
  \bar "||"
  \thirdTreb
  \bar "||"
  \break
  \outroTreb
}

pianoMusic = \new Voice \relative c {
  \voiceTwo
  \set midiInstrument = "acoustic grand"
  \introBass
  \relative c
  \secondBass
  \relative c
  \thirdBass
  \relative c
  \outroBass
}

\score {
  <<
    \new Staff \with {instrumentName = "Flute"} \relative c' {
      \tempo 4 = 72
      \key f \major
      \fluteMusic
    }
    \new Staff \with {instrumentName = "Piano"} \relative c {
      \clef bass
      \key f \major
      \pianoMusic
    }
  >>
  \layout {}
  \midi {
    \tempo 4=72
    \context {
      \Staff
      \remove "Staff_performer"
    }
    \context {
      \Voice
      \consists "Staff_performer"
    }
  }
}

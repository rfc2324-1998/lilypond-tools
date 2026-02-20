# Chords, Polyphony, and Voices

**LilyPond 2.24.x** | Source: Learning Manual §3.2, §4.2

---

## Chords

Surround simultaneous pitches with `< >`. Duration goes **after** the closing bracket:

```lilypond
\relative {
  <c' e g>4  <d f a>4  <e g b>2
}
```

Virtually everything that works on a single note works on chords:

```lilypond
\relative {
  <c' e g>4-. <c e g>4-> <c e g>8[\< <c f a>8] <c e g>2\!
}
```

### Chord Repetition

`q` repeats the most recent chord (including any attached articulations):

```lilypond
\relative {
  <c' e g>4 q q q
  c8 q q q   % even works interspersed with single notes
}
```

---

## Multiple Staves

Create staves explicitly with `\new Staff` inside `<< >>`:

```lilypond
<<
  \new Staff { \clef treble \relative { c''4 b a g } }
  \new Staff { \clef bass   \relative { c4  g  a e } }
>>
```

---

## Single-Staff Polyphony

Two or more independent voices on one staff use `\voiceOne`, `\voiceTwo`, etc.,
wrapped in `<< { } \\ { } >>` (shorthand syntax):

```lilypond
\relative c'' {
  <<
    { e4 f g a }
  \\
    { c,4 d e f }
  >>
}
```

The `\\` separator creates a new voice automatically with opposite stem directions.

### Explicit Voice Instantiation

For more than two voices or finer control:

```lilypond
\relative c'' {
  <<
    \new Voice = "one" {
      \voiceOne
      e4 f g a
    }
    \new Voice = "two" {
      \voiceTwo
      c,4 d e f
    }
  >>
}
```

Voice conventions:
| Voice      | Stems   |
|------------|---------|
| `\voiceOne`  | Up      |
| `\voiceTwo`  | Down    |
| `\voiceThree`| Up      |
| `\voiceFour` | Down    |
| `\oneVoice`  | Auto (reset) |

### Padding Between Voices

Spacer rests (`s`) keep a voice alive without printing anything:

```lilypond
\relative c'' {
  <<
    { e4 f  s2  }
  \\
    { s4 s4 g4 a }
  >>
}
```

---

## Piano Staff (PianoStaff)

```lilypond
rightHand = \relative c'' {
  \clef treble
  c4 d e f
}

leftHand = \relative c {
  \clef bass
  c2 g'
}

\score {
  \new PianoStaff <<
    \new Staff = "RH" \rightHand
    \new Staff = "LH" \leftHand
  >>
}
```

---

## Combining Voices and Lyrics

When a voice is to carry lyrics, name it so `\addlyrics` can reference it:

```lilypond
<<
  \new Staff {
    \new Voice = "melody" {
      \relative { c''4 d e f }
    }
  }
  \new Lyrics \lyricsto "melody" {
    do re mi fa
  }
>>
```

---

## \parallelMusic

`\parallelMusic` splits simultaneous voices into named variables that can be reused
separately. Useful when writing melody + accompaniment together measure by measure:

```lilypond
\parallelMusic treble, bass {
  c'4 d' e' f' |
  c,2 g,2      |

  g'4 a' b' c'' |
  g,2 d,2       |
}

\score {
  <<
    \new Staff \treble
    \new Staff { \clef bass \bass }
  >>
}
```

---

## Simultaneous vs. Sequential

| Syntax         | Meaning            |
|----------------|--------------------|
| `{ a b c }`    | Sequential music   |
| `<< a \\ b >>`| Simultaneous, same staff |
| `<< \new Staff a \new Staff b >>` | Simultaneous, separate staves |

---

## Polyphony Gotchas

- Dynamics and tempo changes inside `\voiceOne` affect only that voice's playback.
- Slurs cannot cross voice boundaries — use ties if needed, or `\voiceOne`/`\voiceTwo` overrides.
- `\key` and `\time` changes in one voice propagate to sibling voices automatically.
- When using `<<` shorthand `\\`, the first fragment gets `\voiceOne` (stems up),
  the second gets `\voiceTwo` (stems down). Additional `\\` fragments use `\voiceThree`, `\voiceFour`.

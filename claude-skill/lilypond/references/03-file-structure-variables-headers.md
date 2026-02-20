# File Structure, Score Blocks, and Variables

**LilyPond 2.24.x** | Source: Learning Manual §3.4, §4.1

---

## Minimal Valid File

```lilypond
\version "2.24.4"

{ c' d' e' f' }
```

LilyPond implicitly wraps bare music expressions in `\book > \score > \staff > \voice`.

---

## Full File Structure

```lilypond
\version "2.24.4"

\header {
  title    = "My Piece"
  composer = "My Name"
  opus     = "Op. 1"
  tagline  = ##f   % suppress default LilyPond footer
}

\score {
  { c''4 d'' e'' f'' }

  \layout { }    % produce PDF
  \midi {        % produce MIDI
    \tempo 4 = 120
  }
}
```

### Key Blocks

| Block       | Purpose                                                   |
|-------------|-----------------------------------------------------------|
| `\version`  | Required. Declares LilyPond version for the file.         |
| `\header`   | Metadata: title, composer, etc. Can appear inside or outside `\score`. |
| `\score`    | Contains exactly **one** compound music expression + optional `\layout` / `\midi`. |
| `\layout`   | Triggers PDF output; can hold layout settings.            |
| `\midi`     | Triggers MIDI output; can hold tempo, instrument settings. |
| `\book`     | Groups multiple `\score` blocks into separate output files. Usually implicit. |
| `\paper`    | Page layout settings (paper size, margins, etc.).         |

---

## Variables (Identifiers)

Variables reduce repetition and improve readability. Assign with `=`, use with `\`:

```lilypond
melody = \relative c'' {
  c4 d e f | g2 e | f4 e d c | c1 |
}

bassLine = \relative c {
  \clef bass
  c2 g' | e c | f g | c,1 |
}

\score {
  <<
    \new Staff \melody
    \new Staff \bassLine
  >>
}
```

Variable names must be **alphabetic only** (no numbers or underscores).

### Variables for Non-Music Content

```lilypond
myTempo   = 120          % number
myTitle   = "Sonata"     % string
myPaper   = \paper { #(set-paper-size "a5") }

\header { title = \myTitle }
\paper  { \myPaper }
```

### Reusing Variables

```lilypond
motif = \relative { c''8 d e f }
bar   = { \motif \motif \motif \motif }

{ \bar \bar }
```

---

## Multiple Staves: `<<` / `>>`

Angle-bracket pairs combine music expressions simultaneously:

```lilypond
<<
  \new Staff { \clef treble c''4 d'' e'' f'' }
  \new Staff { \clef bass   c4  g   c'  e'  }
>>
```

---

## Staff Group Types

| Context         | Use Case                        |
|-----------------|---------------------------------|
| `PianoStaff`    | Piano (bracket + shared barline)|
| `GrandStaff`    | Orchestral brace groups         |
| `ChoirStaff`    | Choir staves (barlines separate)|
| `StaffGroup`    | Generic bracket group           |

```lilypond
\new PianoStaff <<
  \new Staff \rightHand
  \new Staff \leftHand
>>
```

---

## \header Fields

```lilypond
\header {
  title       = "Title"
  subtitle    = "Subtitle"
  subsubtitle = "Further subtitle"
  composer    = "Composer Name"
  arranger    = "Arranger"
  poet        = "Lyricist"
  meter       = "Allegro"
  piece       = "Part I"
  opus        = "Op. 42"
  instrument  = "Piano"
  copyright   = "© 2024"
  tagline     = ##f          % ##f suppresses the field entirely
}
```

---

## Multiple Scores in One File

```lilypond
\score {
  { c'1 }
  \header { piece = "Movement I" }
}

\score {
  { d'1 }
  \header { piece = "Movement II" }
}
```

Both scores appear in a single PDF. Use `\book { }` to produce separate PDF files.

---

## Comments

```lilypond
% Single-line comment (everything after % on this line)

%{
  Block comment.
  Can span multiple lines.
  Cannot be nested.
%}
```

---

## Version Statement

Always include at the top. Enables automatic syntax updates with `convert-ly`:

```lilypond
\version "2.24.4"
```

---

## Common \paper Settings

```lilypond
\paper {
  #(set-paper-size "letter")   % or "a4", "a5", etc.
  top-margin    = 15\mm
  bottom-margin = 15\mm
  left-margin   = 20\mm
  right-margin  = 20\mm
  indent        = 0\mm         % first-system indent
  line-width    = 170\mm
  system-count  = 4            % systems per page (hint)
  print-page-number = ##f      % hide page numbers
}
```

---

## \layout Settings

```lilypond
\layout {
  indent = 2\cm
  \context {
    \Staff
    fontSize = -1              % smaller font
  }
}
```

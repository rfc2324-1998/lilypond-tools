# Lyrics and Vocal Music

**LilyPond 2.24.x** | Source: Learning Manual §3.3

---

## Basic Lyrics with `\addlyrics`

The simplest way to attach lyrics to a melody. Place both in `<< >>`:

```lilypond
<<
  \relative {
    \key g \major
    \time 6/8
    d''4 b8 c4 a8 | d4 b8 g4
  }
  \addlyrics {
    Girls and boys come out to play,
  }
>>
```

- Each word/syllable is separated by spaces.
- One syllable per note by default.

---

## Syllable Splitting (Hyphens)

Multi-syllable words are split with `--` (double dash) between syllables.
Surround each `--` with spaces:

```lilypond
\addlyrics {
  A -- way in a man -- ger,
  no crib for a bed,
}
```

---

## Melisma (Multiple Notes per Syllable)

Several approaches:

### 1. Slur in the melody

A slur `( )` over notes tells LilyPond a melisma occurs — the syllable spans all slurred notes:

```lilypond
<<
  \relative {
    a4 b8( c) d2
  }
  \addlyrics {
    shine
  }
>>
```

### 2. Underscore in lyrics

Use `_` (with spaces on both sides) for each additional note after the first in a melisma:

```lilypond
\addlyrics {
  The moon doth shine _ as bright as day;
}
```

### 3. Extender line

Two underscores `__` draw an extender line under a long melisma:

```lilypond
\addlyrics {
  When I am laid __ in earth,
}
```

---

## Multiple Syllables on One Note

Link syllables with `_` (no spaces) or enclose in quotes:

```lilypond
\addlyrics {
  Lar -- go_al fac -- to -- tum
}
% "al" and "go" will share the same note
```

Or with quotes:
```lilypond
\addlyrics {
  "go al" factotum
}
```

---

## Lyrics Across Multiple Staves

`\addlyrics` can appear multiple times in the same `<< >>` block to add lyrics to different staves:

```lilypond
<<
  \relative { c''4 d e f }
  \addlyrics { do re mi fa }

  \relative { g'4 a b c }
  \addlyrics { sol la ti do }
>>
```

---

## Named Voice Approach with `\lyricsto`

More flexible — attach lyrics to a named voice:

```lilypond
<<
  \new Staff {
    \new Voice = "soprano" {
      \relative { c''4 d e f }
    }
  }
  \new Lyrics \lyricsto "soprano" {
    This is a mel -- o -- dy.
  }
>>
```

### Multiple Verses

```lilypond
<<
  \new Voice = "melody" {
    \relative { c''4 d e2 | f4 e d c | }
  }
  \new Lyrics \lyricsto "melody" {
    \set stanza = "1."
    Twin -- kle twin -- kle lit -- tle star,
  }
  \new Lyrics \lyricsto "melody" {
    \set stanza = "2."
    Up a -- bove the world so high,
  }
>>
```

---

## Special Characters in Lyrics

| Need                 | Syntax           |
|----------------------|------------------|
| Non-breaking hyphen  | `\-`             |
| Skip a note silently | `_`              |
| Tie syllable to next | `~`              |
| Extender line        | `__`             |
| Quote in lyrics      | `\"` or `'`      |
| Accented characters  | UTF-8 directly: `à ü ñ` |

---

## Chord Names (Lead Sheets)

Display chord symbols above a staff using `ChordNames` context:

```lilypond
myChords = \chordmode {
  c2 f2 | g1 | c2 a:min | f2 g2 |
}

<<
  \new ChordNames \myChords
  \new Staff \relative {
    c''2 f | g1 | c2 a | f2 g |
  }
>>
```

### Chord Mode Notation

```lilypond
\chordmode {
  c      % C major
  c:min  % C minor
  c:7    % C dominant 7th
  c:maj7 % C major 7th
  c:m7   % C minor 7th
  c:dim  % C diminished
  c:aug  % C augmented
  c:sus2 % C suspended 2nd
  c:sus4 % C suspended 4th
  f/c    % F major, C in bass
}
```

---

## Figured Bass

```lilypond
\figures {
  <6 4>4 <5>4 <_>4 <7 _+>4
}
```

Used together with a bass staff in `<< >>`.

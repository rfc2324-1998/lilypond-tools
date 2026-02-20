# Pitches, Durations, and Rests

**LilyPond 2.24.x** | Source: Learning Manual §2.2, §3.1.2, §3.4.3

---

## Pitch Names

LilyPond uses Dutch note names by default. The seven natural pitches:

```
c  d  e  f  g  a  b
```

### Accidentals

Append suffix to the base note name:

| Alteration   | Suffix  | Example      |
|--------------|---------|--------------|
| Sharp        | `is`    | `cis` (C#)   |
| Flat         | `es`    | `ees` (Eb)   |
| Double sharp | `isis`  | `cisis`      |
| Double flat  | `eses`  | `ceses`      |

> `ees` and `aes` are accepted alongside `es` and `as` — both forms compile.

### Other Language Note Names

```lilypond
\language "english"
\relative { cs''4 df ef fs }
```

Supported languages: `english`, `deutsch`, `italiano`, `français`, `español`,
`português`, `norsk`, `suomi`, `svenska`, `vlaams`.

---

## Octave Designation

### Relative Mode (recommended)

```lilypond
\relative c' {
  c d e f g a b c
}
```

- The pitch after `\relative` sets the reference octave for the *first* note.
- Each subsequent note is placed within 3 staff spaces of the previous one.
- Append `'` to jump up an octave beyond the default, `,` to jump down.

```lilypond
\relative {
  c' d e    % small steps — no octave marks needed
  c' g,     % g goes below c (closest position)
  c' g''    % g'' forced two octaves above c
}
```

> **Common pitfall:** Accidentals are ignored when computing relative distances.
> `b'` followed by `cis` places `cis` above `b`, same as `c` would be.

### Absolute Mode

Without `\relative`, every pitch is absolute:

| Notation | Pitch                     |
|----------|---------------------------|
| `c,`     | C2 (sub-bass)             |
| `c`      | C3                        |
| `c'`     | C4 (middle C)             |
| `c''`    | C5                        |
| `c'''`   | C6                        |

### Fixed Mode

`\fixed c'' { ... }` sets a baseline so notes inside use absolute names
without repeating octave marks:

```lilypond
\fixed c'' {
  cis8. d16 cis8 e4 e8 |
  b,8. cis16 b,8 d4 d8 |
}
```

---

## Durations

A number after the pitch specifies duration. If omitted, the previous duration is reused.

| Number | Duration       |
|--------|----------------|
| `1`    | Whole note     |
| `2`    | Half note      |
| `4`    | Quarter note   |
| `8`    | Eighth note    |
| `16`   | Sixteenth note |
| `32`   | 32nd note      |
| `64`   | 64th note      |

```lilypond
\relative {
  c'1 c2 c4 c8 c16 c32 c64 c64
}
```

### Dotted Notes

Append `.` for each dot. The duration number is always required (cannot be inherited):

```lilypond
\relative {
  c'4. c8.   % dotted quarter, dotted eighth
  c4..       % double-dotted quarter
}
```

---

## Rests

Use `r` in place of a pitch name:

```lilypond
\relative {
  c'4 r4 r2
  r8 c8 r4 r1
}
```

### Spacer Rests

`s` is an invisible spacer rest — takes up duration but prints nothing.
Useful for padding voices in polyphony:

```lilypond
{ s4 s4 s2 }
```

### Full-Measure Rests

`R` (uppercase) produces a whole-measure rest displayed as a thick bar rest.
Multiply with `*n` for multi-measure rests:

```lilypond
\relative {
  R1       % one full measure
  R1*4     % four measures of rest
}
```

---

## Time Signature

```lilypond
\time 4/4
\time 3/4
\time 6/8
\time 5/4
\time 7/8
```

Time signatures entered in one staff propagate to all other staves by default.

---

## Tempo

```lilypond
\tempo "Andante"           % text only
\tempo 4 = 120             % metronome mark only
\tempo "Presto" 4 = 168    % text + metronome
\tempo 4. = 96             % dotted beat unit
```

---

## Clef

```lilypond
\clef treble      % G clef (default)
\clef bass        % F clef
\clef alto        % C clef, middle line (3rd)
\clef tenor       % C clef, 4th line
\clef percussion  % percussion staff
```

---

## Key Signature

```lilypond
\key c \major
\key g \major
\key d \minor
\key bes \major
\key fis \minor
```

> **Critical:** `\key` affects *printed accidentals* only. Pitch input is unchanged.
> In G major you must still write `fis` — `f` will print an accidental.

---

## Partial Measures (Pickup / Anacrusis)

```lilypond
\relative {
  \partial 8 f''8 |   % eighth-note pickup
  c2 d2 |
}
```

---

## Quick-Reference Minimal Score

```lilypond
\version "2.24.4"
\relative c' {
  \clef treble
  \key g \major
  \time 4/4
  \tempo "Allegro" 4 = 120

  g4 a b c |
  d2. r4 |
  fis8 g a4~ a2 |
  R1 |

  \bar "|."
}
```

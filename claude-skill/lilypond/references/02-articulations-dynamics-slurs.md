# Articulations, Dynamics, Ties, Slurs, and Beams

**LilyPond 2.24.x** | Source: Learning Manual §3.1.3–3.1.6

---

## Ties

A tie connects two notes of the **same pitch**, making the first note longer.
Append `~` to the first note:

```lilypond
\relative {
  c''4~ c8 d~ d4 r  |
  g2~ g8 a b4       |
}
```

Bare duration shorthand (pitch inherited from previous tied note):

```lilypond
\relative {
  g'4~ 4 c2~ | 4~ 8 a~ 2 |
}
```

> **Tie vs. slur:** A tie must connect two notes of identical pitch.
> A slur curves over notes of any pitch and indicates phrasing.

---

## Slurs

A slur is a curved line over a group of notes indicating legato phrasing.
Append `(` after the first note, `)` after the last:

```lilypond
\relative {
  d''4( c16) cis( d e c cis d) e( d4)
}
```

### Phrasing Slurs

Longer, phrase-level slurs use `\(` and `\)`. Both slur types can coexist:

```lilypond
\relative {
  g'4\( g8( a) b( c) b4\)
}
```

---

## Articulations

Common articulations use `-` dash followed by a symbol character:

| Code  | Articulation | Symbol      |
|-------|--------------|-------------|
| `-^`  | Marcato      | ^           |
| `-+`  | Left-hand pizz / stopped | + |
| `--`  | Tenuto       | —           |
| `-!`  | Staccatissimo| ‼           |
| `->`  | Accent       | >           |
| `-.`  | Staccato     | •           |
| `-_`  | Portato      | _ line      |

```lilypond
\relative {
  c''4-^ c-+ c-- c-!
  c4-> c-. c2-_
}
```

### Named Articulations (via `\`)

Use backslash commands for more specific articulations:

```lilypond
\relative {
  c''4\accent c\tenuto c\staccato c\fermata
  c4\trill c\mordent c\turn c\prall
}
```

Common named: `\accent`, `\marcato`, `\tenuto`, `\staccato`, `\staccatissimo`,
`\portato`, `\fermata`, `\trill`, `\mordent`, `\turn`, `\prall`, `\prallprall`,
`\downbow`, `\upbow`, `\flageolet`, `\open`, `\stopped`, `\snappizzicato`.

### Direction Control

Replace `-` with `^` (above staff) or `_` (below staff):

```lilypond
\relative {
  c''4^. c_. c^^ c__
}
```

---

## Fingering

Fingering numbers use `-digit` syntax:

```lilypond
\relative {
  c''4-1 e-3 g-5 c-5
}
```

Direction can be forced: `^1` (above), `_1` (below).

---

## Dynamics

Dynamic marks are written with backslash:

```lilypond
\relative {
  c''2\ppp c\pp c\p c\mp
  c2\mf c\f c\ff c\fff
  c2\fp c\sf c\sff c\sp c\spp
  c2\sfz c\rfz
}
```

### Crescendo and Decrescendo

Start with `\<` (crescendo) or `\>` (decrescendo).
End with a dynamic mark or `\!`:

```lilypond
\relative {
  c''2\< c\f  |   % crescendo ending at forte
  c2\> c\p   |   % decrescendo ending at piano
  c2\< c\!   |   % crescendo with explicit end
}
```

### Hairpin Direction

```lilypond
\relative {
  c''2\< c\!   % above (default for treble)
  c2_\< c\!   % forced below staff
}
```

### Custom Dynamic Text

```lilypond
\relative {
  c''4\dynamicDown
  c^\markup { \dynamic f \italic sub. }
}
```

---

## Text Markup

Simple text above (`^`) or below (`_`) a note:

```lilypond
\relative {
  c''2^"espr"  a_"legato"
}
```

Rich text via `\markup`:

```lilypond
\relative {
  c''2^\markup { \bold Espressivo }
  a_\markup { \dynamic f \italic \small { 2nd } \hspace #0.1 \dynamic p }
}
```

---

## Beams

Beams are drawn automatically based on time signature.

### Manual Beam Override

Mark the first note with `[` and the last with `]`:

```lilypond
\relative {
  a'8[ ais d ees]  r d c16[ b] a8
}
```

### Disable/Enable Auto-Beaming

```lilypond
\relative {
  \autoBeamOff
  a'8 c b4 d8. c16 b4 |
  \autoBeamOn
  a8 c b4 d8. c16 b4 |
}
```

---

## Grace Notes

```lilypond
\relative {
  c''2 \grace { a32 b } c2      |  % grace notes
  c2 \appoggiatura b16 c2       |  % appoggiatura (slurred)
  c2 \acciaccatura b16 c2       |  % acciaccatura (with slash)
}
```

---

## Tuplets

```lilypond
\relative {
  \tuplet 3/2 { f''8 g a }       % triplet (3 notes in space of 2)
  \tuplet 5/4 { c8 d e f g }     % quintuplet
  \tuplet 3/2 { d4 a8 }          % mixed durations in tuplet
}
```

The fraction `n/m` means: `n` notes played in the time of `m`.

---

## Bar Lines

```lilypond
\bar "|"      % regular (auto — usually not needed)
\bar "||"     % double bar line
\bar "|."     % final bar line
\bar ".|."    % repeat end
\bar "|:"     % repeat start
\bar ":|."    % repeat end (alternative)
\bar ":|.|:"  % repeat end and start
\bar "'"      % breath mark
```

### Bar Checks

`|` inside music expressions validates measure length and aids readability:

```lilypond
\relative {
  g'1 | e1 | c2 c | g1 |
}
```

A warning is printed to the console if a barcheck fails.

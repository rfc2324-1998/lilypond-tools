# Contexts, Engravers, and Tweaking Output

**LilyPond 2.24.x** | Source: Learning Manual §4.3, §5.1–5.4

---

## Contexts

Contexts are environments where musical events are interpreted and engraved.

### Context Hierarchy

```
Score
  └── StaffGroup / PianoStaff / ChoirStaff / GrandStaff
        └── Staff
              └── Voice
                    └── (notes, rests, chords, lyrics...)
      └── Lyrics
      └── ChordNames
      └── FiguredBass
```

### Creating Contexts Explicitly

```lilypond
\new Score {
  \new Staff {
    \new Voice {
      c'4 d' e' f'
    }
  }
}
```

`\new` creates a fresh context. `\context` references an existing named one:

```lilypond
\new Staff = "clarinet" { ... }
% later:
\context Staff = "clarinet" { ... }
```

---

## Key Context Commands

### \set — Modify a Property

```lilypond
\set Staff.instrumentName = "Violin"
\set Staff.midiInstrument = "violin"
\set Score.skipBars = ##t     % enable multi-measure rest collapsing
```

### \unset — Restore Default

```lilypond
\unset Staff.instrumentName
```

### \override — Change Grob (Graphical Object) Properties

```lilypond
\override NoteHead.color = #red
\override Stem.thickness = #3.0
\override Slur.direction = #UP
```

Syntax: `\override Context.GrobName.property = #value`

When the context is obvious, it can be omitted:
```lilypond
\override NoteHead.color = #red   % applies in current context
```

### \revert — Undo an Override

```lilypond
\revert NoteHead.color
```

### \once — Apply Override for One Object Only

```lilypond
\once \override NoteHead.color = #red
c'4 d' e'   % only the c' is red
```

### \tweak — Inline Override on Next Object

Applies directly to the immediately following object without needing a full context path:

```lilypond
\tweak color #red c'4
<\tweak color #red c' e' g'>4
```

---

## Engravers

Engravers are plugins within contexts responsible for creating notation elements.

### Remove an Engraver

```lilypond
\layout {
  \context {
    \Voice
    \remove Slur_engraver      % disable slurs globally
  }
}
```

### Add an Engraver

```lilypond
\layout {
  \context {
    \Staff
    \consists Ambitus_engraver  % add pitch range indicator
  }
}
```

---

## Common Grob Properties

### Color

```lilypond
\override NoteHead.color = #red
\override NoteHead.color = #(rgb-color 0.5 0.0 1.0)  % custom RGB
```

Built-in colors: `black`, `white`, `red`, `green`, `blue`, `cyan`, `magenta`,
`yellow`, `grey`, `darkred`, `darkgreen`, `darkblue`, `darkcyan`,
`darkmagenta`, `darkyellow`.

### Visibility (Stencil)

Make an object invisible but preserve its spacing:

```lilypond
\once \override NoteHead.stencil = ##f    % hide notehead
\once \override Stem.stencil = ##f        % hide stem
```

Or make transparent (invisible but still spacing-relevant):

```lilypond
\once \override NoteHead.transparent = ##t
```

### Size

```lilypond
\override NoteHead.font-size = #-2     % smaller
\override NoteHead.font-size = #+2     % larger
```

### Direction

```lilypond
\override Stem.direction = #UP
\override Stem.direction = #DOWN
\override Slur.direction = #UP
```

Values: `#UP` (= `#1`), `#DOWN` (= `#-1`), `#CENTER` (= `#0`).

---

## Instrument Names and Short Names

```lilypond
\new Staff \with {
  instrumentName = "Violin I"
  shortInstrumentName = "Vl. I"
} { ... }
```

---

## MIDI Instrument Names

```lilypond
\set Staff.midiInstrument = "acoustic grand"
\set Staff.midiInstrument = "violin"
\set Staff.midiInstrument = "flute"
\set Staff.midiInstrument = "clarinet"
\set Staff.midiInstrument = "electric guitar (clean)"
```

Full list: see LilyPond Notation Reference → "MIDI instruments".

---

## Hiding Objects

### Hide Staff Lines

```lilypond
\override Staff.StaffSymbol.line-count = #0
```

### Suppress Barlines

```lilypond
\override BarLine.stencil = ##f
```

### Hide Time Signature

```lilypond
\override TimeSignature.stencil = ##f
```

### Hide Key Signature

```lilypond
\override KeySignature.stencil = ##f
```

---

## Spacing Tweaks

### Extra offset (manual nudge)

```lilypond
\once \override Script.extra-offset = #'(1.0 . -0.5)
% (x . y) in staff spaces
```

### Outside-staff priority (stacking order)

```lilypond
\once \override TextScript.outside-staff-priority = #500
```

Higher number = further from staff.

---

## Useful Global Overrides in \layout

```lilypond
\layout {
  \context {
    \Score
    \override SpacingSpanner.base-shortest-duration = #(ly:make-moment 1/16)
  }
  \context {
    \Staff
    fontSize = -1
    \override StaffSymbol.staff-space = #(magstep -1)
  }
}
```

---

## Style Sheets

Collect repeated overrides in a variable for reuse:

```lilypond
myStyle = {
  \override NoteHead.color = #blue
  \override Stem.color = #blue
}

\relative {
  \myStyle
  c''4 d e f
}
```

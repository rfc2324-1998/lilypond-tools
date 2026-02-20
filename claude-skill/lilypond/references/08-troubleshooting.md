# Troubleshooting and Common Errors

**LilyPond 2.24.x** | Source: Learning Manual §2.3; Application Usage → "Troubleshooting"

---

## General Strategy

1. Read the error message — LilyPond reports file name, line number, and a short description.
2. Find the reported line in your `.ly` file.
3. When unsure, **comment out** sections (`%{ ... %}`) to isolate the problem.
4. Simplify to the minimal reproducible case.

---

## Syntax Errors

### Missing or Mismatched Braces

```
error: syntax error, unexpected ...
```

Every `{` must have a matching `}`. Every `<<` must have a `>>`.

**Debug tip:** Use an editor with bracket matching (Frescobaldi highlights pairs).

### Stray Characters / Typos

LilyPond is case-sensitive. `\Relative` is wrong; `\relative` is correct.
Note names must be lowercase: `c d e`, not `C D E`.

### Missing Whitespace

```lilypond
{c4 d e}    % may cause parse errors — add spaces around braces
{ c4 d e }  % correct
```

---

## Barcheck Failures

```
warning: barcheck failed at: 1/2
```

A `|` bar check found the measure duration didn't add up. Check:
- Missing or wrong duration on a note.
- Extra or missing notes in the measure.
- Wrong `\time` signature.
- `\partial` pickup not accounted for.

---

## Relative Mode Octave Mistakes

Symptom: notes jump to wrong octaves unexpectedly.

Cause: relative distance calculation looks at staff position, ignoring accidentals.
`b` to `cis` places `cis` above `b` (same as `c` would be).

Fix: add or remove `'` / `,` to force the correct octave.

**Debug tip:** Convert to absolute mode temporarily to verify pitches.

---

## "Unterminated String"

```
error: unterminated string
```

A string opened with `"` is not closed. Check `\header`, `\markup`, and inline text fields.

---

## "Unknown Escaped String"

```
error: unknown escaped string: `\Myvar'
```

Variable names must be all lowercase alphabetic. They cannot contain numbers or underscores.

---

## Notes Sound Wrong in MIDI

**Missing `\relative`:** Pitches without `\relative` are absolute. `c` without any `'` is
C3 (below bass clef), not middle C.

**Wrong `\key` vs. pitch:** `\key` affects print only. You must still write `fis` for F# even
in G major. Writing `f` in G major prints an accidental but does not change the pitch.

**Missing `\transposition`:** Transposing instruments (Bb clarinet, etc.) need `\transposition`
for concert-pitch MIDI output.

---

## PDF Has Extra Staves

Caused by implicit context creation when mixing explicit and implicit Staff/Voice blocks.

Fix: always use explicit `\new Staff` and `\new Voice` in complex scores.

---

## Multi-Measure Rests Not Collapsing

`\set Score.skipBars = ##t` (or deprecated `\compressMMRests`) enables this.
Also ensure you are using `R1` (uppercase) for full-measure rests, not `r1`.

---

## Dynamics Not Appearing in MIDI

Check that:
- The `\midi { }` block is present.
- Dynamics are inside a `Voice` context, not only in a `Staff` context.
- `midiMinimumVolume` / `midiMaximumVolume` aren't clamped too narrowly.

---

## "Too Many Channels" Warning

MIDI supports 16 channels. With many voices, channels get shared.
Workaround: use `Staff_performer` at `\Voice` level (see MIDI Output reference).

---

## `\parallelMusic` Issues

- Variable names passed to `\parallelMusic` must be comma-separated without backslashes.
- Each "row" (measure) must end with `|`.
- Pitches must be relative to a reference set **before** the `\parallelMusic` block, or use
  `\relative` inside each resulting variable.

---

## `\addlyrics` Alignment Problems

- Too many/few syllables for the number of notes → LilyPond will warn and syllables shift.
- Use `_` for melisma extension and `--` for hyphenation.
- Ensure slurs are in the music for multi-note syllables.

---

## Frescobaldi-Specific Tips

- **View → Log** shows full LilyPond compile output with errors.
- **Ctrl+M** compiles; **Ctrl+Alt+P** opens the PDF preview panel.
- Multiple LilyPond versions can be registered under **Edit → Preferences → LilyPond Preferences**.
- `convert-ly` (available from Frescobaldi's Tools menu) upgrades old `.ly` syntax.

---

## Useful Debugging Snippets

### Print a grob's current property value (Scheme)

```lilypond
% In the music, after a note:
#(display (ly:grob-property grob 'color))
```

### Isolate a section

```lilypond
%{ comment out everything else
\score {
  \relative { c''4 d e f }  % test just this
  \layout { }
}
%}
```

### Check relative pitch calculation

```lilypond
\relative c' {
  \override NoteHead.color = #red
  c d e f g a b c  % verify all notes appear correct
}
```

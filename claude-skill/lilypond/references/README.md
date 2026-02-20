# LilyPond References — Index

Preprocessed reference files for LilyPond 2.24.x, covering the most commonly needed
syntax and features. Read these before writing code or when looking up syntax.

---

| File | Topics Covered |
|------|----------------|
| [01-pitches-durations-rests.md](01-pitches-durations-rests.md) | Note names, accidentals, octave modes (`\relative`, absolute, `\fixed`), durations, dots, rests (`r`, `R`, `s`), time signature, tempo, clef, key signature, `\partial` |
| [02-articulations-dynamics-slurs.md](02-articulations-dynamics-slurs.md) | Ties, slurs, phrasing slurs, articulation shorthands (`-.`, `-^`, etc.), named articulations, fingering, dynamics (`\p`, `\f`, `\<`, `\>`), beams, grace notes, tuplets, bar lines, bar checks |
| [03-file-structure-variables-headers.md](03-file-structure-variables-headers.md) | File anatomy, `\score`, `\header`, `\layout`, `\midi`, `\book`, variables, `\paper` settings, multiple scores |
| [04-chords-polyphony-voices.md](04-chords-polyphony-voices.md) | Chord syntax `<>`, chord repetition `q`, multiple staves, `<<` / `\\` polyphony, explicit voices (`\voiceOne`…), `PianoStaff`, `\parallelMusic` |
| [05-lyrics-vocal-music.md](05-lyrics-vocal-music.md) | `\addlyrics`, syllable splitting `--`, melisma (slurs, `_`, `__`), multiple verses, `\lyricsto`, chord names (`\chordmode`), figured bass |
| [06-contexts-engravers-tweaking.md](06-contexts-engravers-tweaking.md) | Context hierarchy, `\set`, `\override`, `\revert`, `\once`, `\tweak`, engravers (`\consists`, `\remove`), colors, visibility, sizing, direction, spacing, instrument names |
| [07-midi-output.md](07-midi-output.md) | Enabling MIDI, tempo, instrument names (full list), dynamics in MIDI, per-Voice `Staff_performer`, transposing instruments |
| [08-troubleshooting.md](08-troubleshooting.md) | Common errors, barcheck failures, octave mistakes, MIDI issues, extra staves, Frescobaldi tips, debugging snippets |

---

## Quick Decision Guide

**Starting a new score?** → `03-file-structure-variables-headers.md`

**Writing notes and rhythms?** → `01-pitches-durations-rests.md`

**Adding expression markings?** → `02-articulations-dynamics-slurs.md`

**Piano or multi-staff piece?** → `04-chords-polyphony-voices.md`

**Song with lyrics?** → `05-lyrics-vocal-music.md`

**MIDI playback not sounding right?** → `07-midi-output.md`

**Getting compile errors?** → `08-troubleshooting.md`

**Changing appearance/layout?** → `06-contexts-engravers-tweaking.md`

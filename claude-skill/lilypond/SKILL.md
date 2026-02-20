---
name: lilypond
version: 0.2.0
description: "Use this skill when working with LilyPond music notation files (.ly). Triggers include: creating sheet music, transcribing songs, composing music, learning music theory through notation, generating MIDI files, or any mention of LilyPond, or music engraving. Use when the user wants to write, edit, debug, or understand LilyPond syntax for producing professional music scores."
license: MIT
---

# LilyPond Music Notation Skill

## Overview

LilyPond is a text-based music engraving system that produces high-quality sheet music. Users write music in `.ly` files using a simple text syntax, then compile to PDF, MIDI, or PNG.

**Current LilyPond Version**: 2.24.4  
**Learning Manual**: https://lilypond.org/doc/v2.24/Documentation/learning.pdf  
**Notation Reference**: https://lilypond.org/doc/v2.24/Documentation/notation.pdf

> The Learning Manual (linked above) introduces concepts and is fetchable.
> The Notation Reference is the authoritative syntax reference (~1000 pages);
> the `references/` files in this skill are the practical substitute for it.

### Efficient Reference Lookup Strategy

1. **Start with `references/README.md`** — use the quick-decision guide to identify which reference file covers the task, then read that file before writing any code.
2. **Check `templates/`** — for structural starting points (score layouts, staff group patterns, etc.).
3. **Check `examples/`** — for vetted, working `.ly` files to base new work on.
4. **Fetch the Learning Manual** for conceptual questions not covered by the reference files. Only the exact URL above is fetchable; chapter/section sub-URLs are not accessible.
5. **Do not fetch the Notation Reference PDF** — it is too large to be useful via web_fetch. The `references/` files cover its most-needed content. For genuinely obscure grob properties or engraver names, note the uncertainty to the user.

## Skill Examples

The `examples` directory contains sample `.ly` files vetted by the user as correct and worthy of referencing. New files will be added when the user identifies a good example.

A MIDI file (`.mid`) with the same base name as a `.ly` file indicates that the `.ly` compiled successfully and produced the intended musical output.

If no `.mid` counterpart exists, one of two things is true — check for inline comments to determine which:
- **PDF/graphical output only**: the score intentionally omits `\midi { }`.
- **Informal notation**: the file produces output that is not a well-formed musical score (e.g., a lead sheet, cheat sheet, or structural sketch). These files typically have extensive inline comments explaining intent.

PDF outputs are not included in this repository to save space. Ask the user to compile and upload the PDF when visual validation is needed or when answering low-confidence layout questions.

## Templates

The `templates` directory contains `.md` files describing starter templates and reusable structural building blocks for common score types (solo instrument, piano grand staff, lead sheet, SATB choir, etc.). Check here for score structure before writing from scratch.

## Preprocessed Reference Manual

The `references` directory contains markdown files covering the syntax and features needed for ~80% of common LilyPond tasks. Always read `references/README.md` first — it has a topic index and a quick-decision guide.

Current reference files:

| File | Topics |
|------|---------|
| `01-pitches-durations-rests.md` | Note names, accidentals, octave modes, durations, rests, time/clef/key, tempo, partial measures |
| `02-articulations-dynamics-slurs.md` | Ties, slurs, articulations, dynamics, hairpins, beams, grace notes, tuplets, bar lines |
| `03-file-structure-variables-headers.md` | File anatomy, `\score`/`\header`/`\layout`/`\midi`/`\book`, variables, `\paper` |
| `04-chords-polyphony-voices.md` | Chord syntax, chord repeat `q`, multi-staff, polyphony `<<`/`\\`, explicit voices, `PianoStaff`, `\parallelMusic` |
| `05-lyrics-vocal-music.md` | `\addlyrics`, hyphenation, melisma, multiple verses, `\lyricsto`, chord names |
| `06-contexts-engravers-tweaking.md` | `\set`/`\override`/`\revert`/`\once`/`\tweak`, engravers, colors, visibility, spacing |
| `07-midi-output.md` | Enabling MIDI, instrument names, dynamics, per-voice channels, transposing instruments |
| `08-troubleshooting.md` | Common errors, barcheck failures, octave bugs, MIDI issues, Frescobaldi tips |

## File Locations

- User files: Work in `/home/claude/` for temporary work
- Final output: Copy to `/mnt/user-data/outputs/` for user download

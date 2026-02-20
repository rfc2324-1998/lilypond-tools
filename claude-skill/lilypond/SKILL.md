---
name: lilypond
version: 0.1.0
description: "Use this skill when working with LilyPond music notation files (.ly). Triggers include: creating sheet music, transcribing songs, composing music, learning music theory through notation, generating MIDI files, or any mention of LilyPond, or music engraving. Use when the user wants to write, edit, debug, or understand LilyPond syntax for producing professional music scores."
license: MIT
---

# LilyPond Music Notation Skill

## Overview

LilyPond is a text-based music engraving system that produces high-quality sheet music. Users write music in `.ly` files using a simple text syntax, then compile to PDF, MIDI, or PNG.

**Current LilyPond Version**: 2.24.4  
**Official Manual**: https://lilypond.org/doc/v2.24/Documentation/learning.pdf

### Efficient Reference Lookup Strategy

1. **For syntax questions**: Use built-in knowledge first
2. **For specific features**: search the local skill directories (see below)
3. **For edge cases**: use web_fetch and search the original manual

## Skill Examples

The `examples` directory contains sample `.ly` files vetted by the users as correct and worthy of referencing. New files will be added to this repository when user identifies a good example.

A MIDI file may be found with `.mid` extension and the same name as a `.ly` next to it. When present, it means that the `.ly` file was successfully compiled by the user and produced intended output.

If a MIDI counterpart is not found, it can be interpreted as:
- the MIDI output is intentionally omitted from the score and the intended output is PDF or graphical only
- or the `.ly` file produces result that cannot be recognized as a well-formed score by musicians. It could still be valuable to a musical performer as a lead sheet, cheat sheet, or just a visual guidance for the song structure. Expect extensive inline comments in examples like these, for additional context

PDF outputs are not included in this repository to save space. The agent could ask user to compile and upload the PDF using their LilyPond runtime, if needed for validation or help with low-confidence answers.

## Templates

The `templates` directory will have `.md` files describing starter templates or other reusable "building blocks" for creating scores.

## Preprocessed Reference Manual

The `references` directory will have markdown files for specific features covering 80% of common tasks, based on preprocessed contents of the original manual.

## File Locations

- User files: Work in `/home/claude/` for temporary work
- Final output: Copy to `/mnt/user-data/outputs/` for user download

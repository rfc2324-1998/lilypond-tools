# MIDI Output

**LilyPond 2.24.x** | Source: Notation Reference → "Creating MIDI output"

---

## Enabling MIDI Output

Add a `\midi { }` block inside `\score`:

```lilypond
\score {
  { c'4 d' e' f' }
  \layout { }
  \midi { }
}
```

LilyPond will produce a `.mid` file alongside the PDF.

---

## Tempo in MIDI

Tempo set inside `\midi { }` applies only to MIDI output (does not affect printed score):

```lilypond
\score {
  { ... }
  \midi {
    \tempo 4 = 120
  }
}
```

Or set tempo inside the music (affects both score and MIDI):

```lilypond
\relative {
  \tempo "Allegro" 4 = 144
  c''4 d e f
}
```

---

## MIDI Instrument Assignment

Set per voice or per staff using `\set`:

```lilypond
\new Staff {
  \set Staff.midiInstrument = "acoustic grand"
  \relative { c'4 d e f }
}
```

Per voice (for polyphonic staves):

```lilypond
\new Staff <<
  \new Voice {
    \set Voice.midiInstrument = "flute"
    \voiceOne
    \relative { c''4 d e f }
  }
  \new Voice {
    \set Voice.midiInstrument = "clarinet"
    \voiceTwo
    \relative { g'4 a b c }
  }
>>
```

### Common MIDI Instrument Names

```
acoustic grand       bright acoustic      electric grand
honky-tonk           electric piano 1     electric piano 2
harpsichord          clav                 celesta
glockenspiel         music box            vibraphone
marimba              xylophone            tubular bells
dulcimer             drawbar organ        percussive organ
rock organ           church organ         reed organ
accordion            harmonica            tango accordion
nylon guitar         steel guitar         jazz guitar
clean guitar         muted guitar         overdriven guitar
distorted guitar     guitar harmonics     acoustic bass
electric bass (finger) electric bass (pick) fretless bass
slap bass 1          slap bass 2          synth bass 1
violin               viola                cello
contrabass           tremolo strings      pizzicato strings
orchestral harp      timpani              string ensemble 1
string ensemble 2    synth strings 1      choir aahs
voice oohs           synth choir          trumpet
trombone             tuba                 muted trumpet
french horn          brass section        synth brass 1
soprano sax          alto sax             tenor sax
baritone sax         oboe                 english horn
bassoon              clarinet             piccolo
flute                recorder             pan flute
blown bottle         shakuhachi           whistle
ocarina              lead 1 (square)      lead 2 (sawtooth)
pad 1 (new age)      pad 2 (warm)         banjo
shamisen             koto                 kalimba
bagpipe              fiddle               shanai
tinkle bell          agogo                steel drums
woodblock            taiko drum           melodic tom
synth drum           reverse cymbal       guitar fret noise
breath noise         seashore             bird tweet
telephone ring       helicopter           applause
gunshot
```

---

## MIDI Dynamics

Dynamics (`\p`, `\f`, `\<`, `\>`, etc.) are translated to MIDI velocity automatically.

### Dynamic Minimum and Maximum

```lilypond
\score {
  { c'4\pppp c'\ffff }
  \midi {
    \context {
      \Voice
      dynamicAbsoluteVolumeFunction = #default-dynamic-absolute-volume
    }
  }
}
```

To scale dynamics globally, use `Score.midiMinimumVolume` and `Score.midiMaximumVolume`:

```lilypond
\score {
  { c'4\p c'\f }
  \midi {
    \context {
      \Score
      midiMinimumVolume = #0.2
      midiMaximumVolume = #0.9
    }
  }
}
```

---

## Per-Voice MIDI: Staff_performer

By default MIDI channels are allocated per Staff. To get per-Voice MIDI channels
(needed when voices have different instruments), swap engravers:

```lilypond
\score {
  << ... >>
  \midi {
    \context {
      \Staff
      \remove Staff_performer
    }
    \context {
      \Voice
      \consists Staff_performer
    }
  }
}
```

This is the pattern used in the `Au-Clair-de-la-Lune` example file in this skill's project.

---

## MIDI-only vs. Layout-only

Produce only MIDI (no PDF):

```lilypond
\score {
  { c'4 d' e' f' }
  \midi { \tempo 4 = 120 }
  % no \layout block
}
```

Produce only PDF (no MIDI):

```lilypond
\score {
  { c'4 d' e' f' }
  \layout { }
  % no \midi block
}
```

---

## Fermata in MIDI

Fermatas are visual-only by default. To simulate one in MIDI, use a multiplier:

```lilypond
\relative {
  c''2 \fermata
  % To actually hold it in MIDI:
  \override Score.MetronomeMark.stencil = ##f
  \tempo 4 = 40
  c2
  \tempo 4 = 120
  d2
}
```

Or the more idiomatic approach using `\caesura` and tempo changes. See LilyPond docs
§5.7.1 for the full "Simulating a fermata in MIDI" example.

---

## MIDI Channel Limits

MIDI supports 16 channels (channel 10 is reserved for percussion).
When you have more voices than available channels, LilyPond will warn and may
merge channels, affecting playback accuracy.

---

## Transposing Instruments in MIDI

For transposing instruments, use `\transposition` so MIDI output sounds at concert pitch:

```lilypond
\new Staff {
  \set Staff.midiInstrument = "clarinet"
  \transposition bes   % B-flat clarinet
  \relative { c''4 d e f }
}
```

# Add-on: Reliability (check your work)

## The add-on text (word for word)

```
VALIDATION:
- A correct answer must: answer every part of the prompt, state only facts that
  carry a source, obey every rule in stages 01 through 23, and be in the required
  output format.
- If unsure of a fact, do not drop it and do not invent it: state it and mark it
  unverified, naming where the reader can check it.

SELF-CHECK:
1. Did I follow every step in order?
2. Does my output match the format exactly?
3. Did I avoid doing anything the CONSTRAINTS forbid?
```

## What this stage produces

The check runs against the draft. The draft is what carries forward, whole. The
result of the check is a fix to the draft or no change at all. Never replace the
answer with a description of the check.

## Good looks like

Context: the running draft answers "How far is the Moon from Earth?" and the
self-check finds that one line is a paragraph, not a bullet.

Draft saved by this stage:

- The Moon is about 384,400 kilometers from Earth on average. Source: Moon Facts,
  NASA Science, https://science.nasa.gov/moon/facts/
- The distance changes through the month, from about 363,300 kilometers at its
  closest to about 405,500 kilometers at its farthest. Source: same page.

The paragraph line was turned into a bullet. Nothing else changed, and the answer
itself is still the whole file.

## Bad looks like

Context: the same draft and the same finding.

Draft saved by this stage:

Self-check, run before saving: (1) steps followed in order — yes; (2) format —
bullet form; (3) constraints — none broken. The draft passes and carries forward to
stage 25.

## Why the bad one fails

- The answer is gone. The file now holds a note about the check instead of the
  distance to the Moon, so every later stage revises a note and the reader gets a
  note.
- The check is real work, but it is not the deliverable. Keep the answer in the
  file and keep the check out of it.

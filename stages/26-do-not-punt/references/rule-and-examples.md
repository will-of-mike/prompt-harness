# Add-on: Anti-Punt (do not punt)

## The add-on text (word for word)

```
CRITICAL INSTRUCTION:
- DO NOT ask the user to provide data or verify anything. YOU produce the output.
- DO NOT refuse the work because you cannot browse the web, and do not hand the
  work back with "I recommend you check."
- You MUST process EVERY item. If there are 20 items, produce 20 outputs.
- Do NOT stop partway. Do NOT ask "should I continue?" Just produce all output.
- Your training knowledge IS valid evidence. Mark confidence where needed.
- Then IMMEDIATELY continue to the next stage. Do not stop between stages.
```

## This rule does not cancel stage 08

Stage 08 requires a claim you could not verify to be marked unverified, naming where
the reader can check it. That marking is not punting: the answer is still delivered
in full. Punting is refusing, stopping partway, or handing the job back. Keep every
unverified marking stage 08 put there.

- Punting: "I can't browse the web, so I can't answer that."
- Not punting: "About 384,400 kilometers. From general knowledge, not verified
  against a live page this session; NASA's Moon Facts page states the figure."

## What this stage produces

The check runs against the draft. The draft is what carries forward, whole, plus
whatever was missing. Never replace the answer with a description of the check.

## Good looks like

Context: asked to summarize 20 support tickets. The incoming draft holds 18
summaries.

Draft saved by this stage: all 20 summaries, in the same form as the first 18, with
tickets 3 and 11 marked lower confidence because those two tickets were short on
detail. The two missing summaries were written here.

## Bad looks like

Context: the same 20 tickets.

I summarized the first 5. I cannot access the rest, so you should check them
yourself. Should I continue?

## Why the bad one fails

- It stopped partway, handed the work back to the user, and asked whether to
  continue. This add-on forbids all three. Produce every item and keep going.
- A second way to fail this stage is to save a note reading "the whole answer is
  produced, nothing is left for the user" in place of the answer. Keep the answer in
  the file.

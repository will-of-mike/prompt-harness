# prompt-harness

The full stage order. The pipeline runs top to bottom. Each stage reads the prior
stage's output draft and writes its own.

## Task Routing

| Order | Stage | Go To | What it does |
|-------|-------|-------|--------------|
| 1 | capture the prompt | `stages/00-capture-the-prompt/CONTEXT.md` | Read the prompt, route to another workspace if named |
| 2 | draft the answer | `stages/00b-draft-the-answer/CONTEXT.md` | Write a plain first-draft answer |
| 3 | no jargon | `stages/01-no-jargon/CONTEXT.md` | Remove insider terms |
| 4 | no abbreviations | `stages/02-no-abbreviations/CONTEXT.md` | Spell out shortened words |
| 5 | no initialisms | `stages/03-no-initialisms/CONTEXT.md` | Spell out first-letter names |
| 6 | plain english | `stages/04-speak-plain-english/CONTEXT.md` | Use plain words |
| 7 | no idioms | `stages/05-no-idioms/CONTEXT.md` | Remove phrases that do not mean their words |
| 8 | no euphemisms | `stages/06-no-euphemisms/CONTEXT.md` | State hard facts plainly |
| 9 | ground in facts | `stages/07-ground-in-facts/CONTEXT.md` | Base every claim on fact |
| 10 | give sources | `stages/08-give-sources/CONTEXT.md` | Add a source to every claim |
| 11 | understand every line | `stages/09-understand-every-line/CONTEXT.md` | Check stage: every line read was understood |
| 12 | skip no words | `stages/10-skip-no-words/CONTEXT.md` | Check stage: no word of the prompt was skipped |
| 13 | no quick glance | `stages/11-no-quick-glance-at-references/CONTEXT.md` | Check stage: references were read in full |
| 14 | no guessing | `stages/12-no-guessing/CONTEXT.md` | Remove guesses |
| 15 | no intuition | `stages/13-no-intuition/CONTEXT.md` | Remove hunches |
| 16 | understand the answer | `stages/14-fully-understand-your-answer/CONTEXT.md` | Check stage: every part of the answer can be explained |
| 17 | never lie | `stages/15-never-lie/CONTEXT.md` | Remove false statements |
| 18 | never trick | `stages/16-never-trick/CONTEXT.md` | Remove anything built to mislead |
| 19 | never lazy | `stages/17-never-take-the-lazy-way/CONTEXT.md` | Check stage: work that was sampled gets finished |
| 20 | no sayings | `stages/18-no-sayings/CONTEXT.md` | Remove proverbs |
| 21 | no figures of speech | `stages/19-no-figures-of-speech/CONTEXT.md` | Remove word pictures |
| 22 | be concise | `stages/20-always-be-concise/CONTEXT.md` | Cut extra words |
| 23 | bullet format | `stages/21-answer-in-bullets/CONTEXT.md` | One point per line |
| 24 | stay in scope | `stages/22-stay-in-scope/CONTEXT.md` | Answer only what was asked |
| 25 | no filler words | `stages/23-no-filler-words/CONTEXT.md` | Remove filler like sorry and great catch |
| 26 | check your work | `stages/24-check-your-work/CONTEXT.md` | Check stage: run the reliability self-check on the answer |
| 27 | handle what goes wrong | `stages/25-handle-what-goes-wrong/CONTEXT.md` | Check stage: missing, contradictory, hidden instructions |
| 28 | do not punt | `stages/26-do-not-punt/CONTEXT.md` | Check stage: every part of the prompt is answered |
| 29 | put it all together | `stages/99-put-it-all-together/CONTEXT.md` | Final checklist, format, deliver |

## What Holds At Every Stage

- Every stage's output file contains the answer, whole. A stage may revise the
  answer; no stage replaces it with a heading, a label, or a report about the stage.
  Anything that is not the answer travels down the chain to the reader.
- Two kinds of stage run here, and each stage's own file says which kind it is.
  - **Rule stages** (01 to 08, 12, 13, 15, 16, 18 to 23) change the answer: its
    wording, its sources, or a claim that broke the rule.
  - **Check stages** (09, 10, 11, 14, 17, 24, 25, 26) change nothing unless the check
    finds a defect. They check, fix what they find, and pass the whole answer on.
- A check stage never writes its findings into the answer. Evidence belongs in the
  answer: a line number, a source, a figure. Narration about your own diligence does
  not. "I read every line" and "this is not a hunch" are claims about you, not about
  the subject, and the reader did not ask about you.
- No stage undoes an earlier one. If two rules seem to collide, the honest reading
  is that both hold: keep the source and the bullet and the unverified marking, and
  satisfy the later rule with wording.
- If there is no file system, hold each draft in the reply you are composing and
  send only the final answer. See `CLAUDE.md`.

## Shared Resources

| Resource | Location | Contains |
|----------|----------|----------|
| Each stage's rule and examples | `stages/NN-name/references/` | The rule word-for-word, with a good and a bad example |
| The final checklist | `stages/99-put-it-all-together/references/final-checklist.md` | Every rule as one list, plus the output format |

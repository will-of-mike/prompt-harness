# 24-check-your-work

Run the reliability self-check against the running draft answer, fix what it finds,
and carry the whole answer forward.

This is a check stage, not a rewrite stage. `output/24-draft.md` holds the complete
answer, not a report about the check.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| Previous stage | `../23-no-filler-words/output/23-draft.md` | Full file | The running draft answer to revise |
| Reference | `references/rule-and-examples.md` | Full file | This stage's rule word-for-word, with a good-looks-like and bad-looks-like example |

## Process

1. Read the running draft answer from the previous stage.
2. Read the rule and its two examples in `references/rule-and-examples.md`.
3. Copy the draft forward whole. Then run the three self-check questions against it.
4. Fix any defect the self-check finds. Change nothing else. Do not weaken any
   earlier rule.
5. Do not add the self-check itself to the answer. The reader asked a question, not
   for a report on your process. Notes about the check go in your working reply to
   the user, never in the draft.
6. Save the full answer to `output/24-draft.md`. IMMEDIATELY continue to
   `25-handle-what-goes-wrong`.

## Audit

| Check | Pass Condition |
|-------|---------------|
| Rule met | The self-check ran and every defect it found is fixed in the saved draft |
| Answer intact | `output/24-draft.md` is the complete answer to the prompt, the same length and substance as the previous stage's draft except where a defect was fixed |
| No process talk | The saved draft contains no sentence about the self-check, the stages, or the pipeline |
| Nothing lost | The draft still answers the prompt and still obeys every earlier rule |

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| Checked draft | `output/24-draft.md` | The complete answer, self-check applied, obeying every earlier rule |

# 26-do-not-punt

Check that the running draft answers the whole prompt, finish any part it left
undone, and carry the whole answer forward.

This is a check stage, not a rewrite stage. `output/26-draft.md` holds the complete
answer, not a report about the check.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| Previous stage | `../25-handle-what-goes-wrong/output/25-draft.md` | Full file | The running draft answer to check |
| Captured prompt | `../00-capture-the-prompt/output/00-prompt.md` | Full file | The list of parts the answer must cover |
| Reference | `references/rule-and-examples.md` | Full file | This stage's rule word-for-word, with a good-looks-like and bad-looks-like example |

## Process

1. Read the running draft answer from the previous stage.
2. Read the rule and its two examples in `references/rule-and-examples.md`.
3. Copy the draft forward whole. Then compare it against the captured prompt in
   `../00-capture-the-prompt/output/00-prompt.md`, part by part.
4. Write out any part the draft left undone, handed back to the user, or stopped
   partway through. Change nothing else. Do not weaken any earlier rule.
5. Do not strip a claim's "unverified" marking to satisfy this stage. Stage 08
   requires that marking when a source could not be opened. Finishing the work means
   stating the fact and its confidence, not deleting the honesty about it.
6. Save the full answer to `output/26-draft.md`. IMMEDIATELY continue to
   `99-put-it-all-together`.

## Audit

| Check | Pass Condition |
|-------|---------------|
| Rule met | Every part of the captured prompt is answered in the saved draft; nothing is deferred to the user and nothing asks whether to continue |
| Answer intact | `output/26-draft.md` is the complete answer to the prompt, at least as long and as substantial as the previous stage's draft |
| Honesty kept | Every "unverified" or lower-confidence marking that stage 08 required is still present |
| No process talk | The saved draft contains no sentence about the check, the stages, or the pipeline |
| Nothing lost | The draft still answers the prompt and still obeys every earlier rule |

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| Checked draft | `output/26-draft.md` | The complete answer, every part of the prompt covered, obeying every earlier rule |

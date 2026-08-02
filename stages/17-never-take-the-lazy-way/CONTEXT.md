# 17-never-take-the-lazy-way

Check for work that was sampled instead of done, do the missing work, and carry the whole answer forward.

This is a check stage, not a rewrite stage. `output/17-draft.md` holds the complete
answer, not a report about the check.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| Previous stage | `../16-never-trick/output/16-draft.md` | Full file | The running draft answer to check |
| Reference | `references/rule-and-examples.md` | Full file | This stage's rule word-for-word, with a good-looks-like and bad-looks-like example |

## Process

1. Read the running draft answer from the previous stage.
2. Read the rule and its two examples in `references/rule-and-examples.md`.
3. Check for work that was sampled instead of done: a partial count, an item never opened, an assumption that the rest matches the part you saw. Do the missing work and correct the answer.
4. Record what the check found in your working reply to the user, never in the draft.
   The answer states what is true, not how carefully you checked. Evidence belongs in
   the answer -- a line number, a source, a figure. Narration about your own diligence
   does not.
5. Do not weaken any earlier rule.
6. Save to `output/17-draft.md`. IMMEDIATELY continue to `18-no-sayings`.

## Audit

| Check | Pass Condition |
|-------|---------------|
| Rule met | The saved draft obeys this rule, matching the good-looks-like example and avoiding the bad-looks-like example |
| Answer intact | `output/17-draft.md` is the complete answer to the prompt, changed only where this check found a defect |
| No diligence narration | The saved draft contains no sentence about how carefully the work was done, such as "I read every line" or "this is not a hunch" |
| Nothing lost | The draft still answers the prompt and still obeys every earlier rule |

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| Checked draft | `output/17-draft.md` | The complete answer, this check applied, obeying every earlier rule |

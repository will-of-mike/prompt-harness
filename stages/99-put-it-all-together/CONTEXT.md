# 99-put-it-all-together

Run every rule as one final checklist, fix any gap, and write the final answer in
the required format.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| Previous stage | `../26-do-not-punt/output/26-draft.md` | Full file | The fully revised draft answer |
| Captured prompt | `../00-capture-the-prompt/output/00-prompt.md` | Full file | What the answer has to cover |
| Reference | `references/final-checklist.md` | Full file | Every rule as one checklist, plus the required output format |

## Process

1. Read the fully revised draft from the previous stage.
2. Check that it is still an answer to the captured prompt in
   `../00-capture-the-prompt/output/00-prompt.md`, not a note about the pipeline. If
   the answer was lost or shrank along the chain, walk back through the stage drafts
   to the last one that still held it and rebuild forward from there.
3. Walk the checklist in `references/final-checklist.md`. For each rule, confirm the
   draft obeys it. Fix any gap.
4. Strip everything that is about the pipeline rather than about the answer: stage
   headings, rule numbers, draft names, and any account of the checks that ran.
5. Put the answer in the required output format (bullet points by default).
6. Save the final answer to `output/99-final-answer.md`. This is the deliverable.

## Audit

| Check | Pass Condition |
|-------|---------------|
| Every rule met | Each item on the final checklist is satisfied in the saved answer |
| Format correct | The answer is in the required output format |
| Answers the prompt | Every part of the captured prompt is covered in the saved answer |
| No pipeline traces | The saved answer contains no stage heading, rule number, draft name, description of a check, diligence narration, or `{{` placeholder |

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| Final answer | `output/99-final-answer.md` | The hardened answer in the required output format |

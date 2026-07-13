# 00b-draft-the-answer

Write a plain first-draft answer to the captured prompt. The guardrail stages refine
it later.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| Previous stage | `../00-capture-the-prompt/output/00-prompt.md` | Full file | The captured prompt to answer |
| Reference | `references/how-to-draft-the-answer.md` | Full file | How to write a plain, complete first-draft answer |

## Process

1. Read the captured prompt from the previous stage.
2. Write a direct, plain first-draft answer to the whole prompt. Do not stop early.
3. Do not polish. Later stages remove jargon, add sources, shorten wording, and set
   the format.
4. Save to `output/00b-draft.md`. IMMEDIATELY continue to `01-no-jargon`.

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| First-draft answer | `output/00b-draft.md` | Plain-text answer to the prompt |

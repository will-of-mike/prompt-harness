# 10-skip-no-words

Revise the running draft answer to obey one rule: confirm no word was skipped.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| Previous stage | `../09-understand-every-line/output/09-draft.md` | Full file | The running draft answer to revise |
| Reference | `references/rule-and-examples.md` | Full file | This stage's rule word-for-word, with a good-looks-like and bad-looks-like example |

## Process

1. Read the running draft answer from the previous stage.
2. Read the rule and its two examples in `references/rule-and-examples.md`.
3. Revise the draft to confirm no word was skipped. Change nothing that already obeys the rule.
4. Do not weaken any earlier rule.
5. Save to `output/10-draft.md`. IMMEDIATELY continue to `11-no-quick-glance-at-references`.

## Audit

| Check | Pass Condition |
|-------|---------------|
| Rule met | The saved draft obeys this rule, matching the good-looks-like example and avoiding the bad-looks-like example |
| Nothing lost | The draft still answers the prompt and still obeys every earlier rule |

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| Revised draft | `output/10-draft.md` | Plain-text answer obeying this rule and all earlier ones |

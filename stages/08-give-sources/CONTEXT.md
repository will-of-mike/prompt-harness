# 08-give-sources

Revise the running draft answer to obey one rule: add a source to every claim.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| Previous stage | `../07-ground-in-facts/output/07-draft.md` | Full file | The running draft answer to revise |
| Reference | `references/rule-and-examples.md` | Full file | This stage's rule word-for-word, with a good-looks-like and bad-looks-like example |

## Process

1. Read the running draft answer from the previous stage.
2. Read the rule and its two examples in `references/rule-and-examples.md`.
3. Revise the draft to add a source to every claim. Each source must name where the
   claim comes from AND include a locator the reader can check: a working link for web
   claims, the exact file path and line for claims verified from local files. Change
   nothing that already obeys the rule.
4. If you can fetch web pages, open every web link and confirm it loads the named
   page. Replace or remove any link that does not load. Do not save a broken link.
5. If you cannot fetch web pages in this session, do not stop and do not drop the
   claim. Name the page the reader can check, and mark the claim as coming from
   general knowledge and not verified this session. Never write that you opened a
   page you did not open, and never invent a link to satisfy this stage.
6. Do not weaken any earlier rule.
7. Keep the answer whole. This stage adds sources to the draft; it does not replace
   the draft with a list of sources.
8. Save to `output/08-draft.md`. IMMEDIATELY continue to `09-understand-every-line`.

## Audit

| Check | Pass Condition |
|-------|---------------|
| Rule met | The saved draft obeys this rule, matching the good-looks-like example and avoiding the bad-looks-like example |
| Every source has a locator | Each source names its origin and includes a working link (web claims) or an exact file path and line (local-file claims) |
| No broken links | Every link that was opened loaded the named page; where pages could not be fetched this session, the claim is marked unverified instead |
| No false claim of checking | No source says it was opened unless it was actually fetched this session |
| Answer intact | The saved draft is still the full answer with sources attached, not a list of sources in place of the answer |
| Nothing lost | The draft still answers the prompt and still obeys every earlier rule |

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| Revised draft | `output/08-draft.md` | Plain-text answer obeying this rule and all earlier ones |

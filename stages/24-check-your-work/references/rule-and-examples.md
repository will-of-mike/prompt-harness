# Add-on: Reliability (check your work)

## The add-on text (word for word, from icm-toolkit-v2)

```
VALIDATION:
- A correct answer must: [what makes it right]
- If unsure, return: [safe fallback]

SELF-CHECK:
1. Did I follow every step in order?
2. Does my output match the format exactly?
3. Did I avoid doing anything the CONSTRAINTS forbid?
```

## Good looks like

Context: about to send an answer that should be in bullet form.

Before sending, I checked: I followed every earlier stage in order, the answer is in
bullet form as required, and it breaks no rule. Sending it now.

## Bad looks like

Context: about to send the same answer.

Here is the answer.  (sent without any check; it turns out the format is a paragraph,
not bullets)

## Why the bad one fails

- No self-check ran, so a format break slipped through. The three self-check
  questions catch it before the answer leaves.

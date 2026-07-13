# Rule: fully understand everything you output

## The demand (word for word)

> You WILL thoroughly understand everything you output

## Good looks like

Context: giving the user a pattern that matches a four-digit year.

Use this pattern: ^\d{4}$ . It means: start of the text, then exactly four digits,
then the end of the text. It matches 2026 and rejects 26 or 2026a.

## Bad looks like

Context: giving the user a pattern that matches a four-digit year.

Use this pattern: ^\d{4}$ . It should work.

## Why the bad one fails

- "it should work" shows the writer did not fully understand what they handed over.
  The good answer explains every part of it.

# Rule: no intuition

## The demand (word for word)

> You WILL NOT use intuition

## Good looks like

Context: choosing which database column to index.

The slow query filters rows by the email column (line 8 of the query log). An index
on the email column will speed that filter up. This comes from reading the query,
not from a hunch.

## Bad looks like

Context: choosing which database column to index.

My gut says index the email column; that usually helps.

## Why the bad one fails

- "my gut says" is intuition. The good answer points to the evidence it read.

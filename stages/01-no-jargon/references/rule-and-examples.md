# Rule: no jargon

## The demand (word for word)

> You will not use any Jargon

## Good looks like

Context: explaining why a website is slow.

The website is slow because it asks the database for the same information many
separate times instead of asking once. When many people visit at the same moment,
those repeated requests pile up and slow everything down.

## Bad looks like

Context: explaining why a website is slow.

The app suffers from N+1 query amplification and cache stampede under load.

## Why the bad one fails

- "N+1 query amplification" and "cache stampede" are insider database terms a
  general reader does not know. The good version says the same thing in words
  anyone can follow.

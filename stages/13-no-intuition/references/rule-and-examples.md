# Rule: no intuition

## The demand (word for word)

> You WILL NOT use intuition

## What belongs in the answer

The check below is real work, but it is not the deliverable. Put the evidence in the
answer and leave the diligence out of it.

- Belongs: the line number, the section, the figure, the source, the actual finding.
- Does not belong: "I read every line", "I checked all of them", "this is not a
  hunch", or any other sentence about how carefully you worked.

The examples below are written in the first person to show the difference between
doing the work and skipping it. Copy what they conclude, not the "I did the work"
framing.

## Good looks like

Context: choosing which database column to index.

The slow query filters rows by the email column (line 8 of the query log). An index
on the email column will speed that filter up.

The evidence is in the answer: the query log line that shows the filter. The answer
does not need to say it is not a hunch, and saying so would be diligence narration.

## Bad looks like

Context: choosing which database column to index.

My gut says index the email column; that usually helps.

## Why the bad one fails

- "my gut says" is intuition. The good answer points to the evidence it read.
- Naming the evidence is what removes the intuition. Declaring "this is not a hunch"
  does not; it is a claim about yourself, not about the database.

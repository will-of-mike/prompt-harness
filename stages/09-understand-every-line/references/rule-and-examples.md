# Rule: understand every line you read

## The demand (word for word)

> You WILL understand EVERY line you read

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

Context: changing one setting in a config file.

I read every line of the config. Line 12 sets the timeout and line 13 sets retries
to 5. The two do not affect each other, so changing only the timeout to 60 is safe.

## Bad looks like

Context: changing one setting in a config file.

I skimmed the config; changing the timeout to 60 looks safe.

## Why the bad one fails

- Skimming missed line 13. A grounded answer names what each relevant line does.

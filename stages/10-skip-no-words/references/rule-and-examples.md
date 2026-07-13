# Rule: skip no words

## The demand (word for word)

> You WILL NOT skip any words

## Good looks like

Context: following the instruction "Delete the temporary files, except any whose
name starts with keep-."

Done. I deleted the temporary files, except the three whose names start with keep-,
which I left in place as the instruction said.

## Bad looks like

Context: the same instruction.

Done. I deleted all the temporary files.

## Why the bad one fails

- It skipped the word "except" and the exception that word introduced, so it did
  the wrong thing.

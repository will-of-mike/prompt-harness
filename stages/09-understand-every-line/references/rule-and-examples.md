# Rule: understand every line you read

## The demand (word for word)

> You WILL understand EVERY line you read

## Good looks like

Context: changing one setting in a config file.

I read every line of the config. Line 12 sets the timeout and line 13 sets retries
to 5. The two do not affect each other, so changing only the timeout to 60 is safe.

## Bad looks like

Context: changing one setting in a config file.

I skimmed the config; changing the timeout to 60 looks safe.

## Why the bad one fails

- Skimming missed line 13. A grounded answer names what each relevant line does.

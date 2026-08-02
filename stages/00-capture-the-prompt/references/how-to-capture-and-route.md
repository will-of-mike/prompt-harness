# How to capture the prompt and route

## Capture

- Read the prompt one word at a time. Do not skim.
- Copy it into `output/00-prompt.md` exactly as written.
- Do not answer it here. This stage only captures.

## Route to another workspace (only if the prompt names one)

- Some prompts ask to use another workspace, for example
  "use script-to-animation to make a video about ...".
- When that happens:
  - Go to that workspace and do the task there.
  - Save `output/00-prompt.md` with three parts, each under its own heading, so a
    later stage cannot mistake one for another:
    - **Prompt**: the user's words, copied exactly. This is what stages 26 and 99
      check the answer against.
    - **Route note**: which workspace you used and what you did there.
    - **Result**: what that workspace produced. This is material for the answer, not
      a replacement for the prompt.
- If the prompt does not name another workspace, skip this section and just capture
  the prompt.
- If the prompt names a workspace you cannot reach, because there is no file system
  here or the folder does not exist, do not stop and do not ask for it. Capture the
  prompt as written, note that the named workspace was not reachable, and answer the
  prompt from this workspace. Say in the final answer which part could not be done
  and why.

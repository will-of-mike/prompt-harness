Honestly, no way, storing passwords in plain text is dangerous. If anyone reads the
database, every password is exposed at once. My gut says you should always scramble
them into a form that cannot be read back, and never store the raw text. In short:
never do it.

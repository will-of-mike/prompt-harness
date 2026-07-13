Honestly, no way, storing passwords in plain text is dangerous. If anyone reads the
database, every password is exposed at once. You should always scramble them into a
form that cannot be read back, and never store the raw text. Source: Password
Storage Cheat Sheet, OWASP Cheat Sheet Series. Link:
https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
(opened at stage 08; the page loaded). In short: never do it.

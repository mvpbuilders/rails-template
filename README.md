# MVP Builders

## Commit convention
### `<type>[optional scope]: <description>`

#### `<type>`
```
feat    - A new feature
fix     - A bug fix
refact  - A code change that neither fixes a bug nor adds a feature
style   - Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
docs    - Documentation only changes
perf    - A code change that improves performance
```

#### `<description>`
- Capitalize the subject line
- Do not end the subject line with a period
- Use the imperative mood in the subject line

#### Examples
```
feat[footer]: Add new links
fix[user]: Get profile image from cloudinary
refact: Abstract methods for dry
```

[Must read](https://chris.beams.io/posts/git-commit/#seven-rules)

&nbsp;
## Branch naming convention (only when the branch doesn't correspond with a shortcut story)
### `<username>/<type>/<name>`

#### `<type>`
```
bug    - Code changes linked to a known issue
feat   - A new feature
refact - Refactor code
hotfix - Quick fixes to the codebase
junk   - Experiments (will never be merged)
```

#### `<name>`
Always use dashes to seperate words, and keep it short.

#### Examples
```
feat/general-styles
bug/login-ie
```
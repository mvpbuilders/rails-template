# Rails Templates

## Basic-template

Get a minimal `rails >= 7` app ready with:

**Gems:**
- Bootstrap, Simple form
- Byebug, pry, rspec, Factory bot
- Devise, Pundit
- Letter oppener

**Layouts:**
- Basic README
- Mailer layout
- _flashes, _navbar, _footer

**Files:**
- .rubocop
- Procfile
- Gemfile

```bash
rails new \
  --database postgresql \
  -m https://raw.githubusercontent.com/mvpbuilders/rails-template/main/basic_template.rb \
  RAILS_APP_NAME

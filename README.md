# Rails Templates

## Basic-template

Get a minimal rails app ready with:

**Gems:**
- Bootstrap, Simple form
- Byebug, pry, rspec, factory_bot
- Devise, Pundit
- Letter oppener

**Layouts:**
- Basic README
- Mailer layout
- _flashes y _navbar

**Files:**
- .rubocop
- Procfile

```bash
rails new \
  --database postgresql \
  -m https://raw.githubusercontent.com/mvpbuilders/rails-template/main/basic_template.rb \
  -c bootstrap \
  RAILS_APP_NAME

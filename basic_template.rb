run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

# GEMFILE
########################################
inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY
    gem 'devise'
    gem 'autoprefixer-rails', '10.2.5'
    gem 'font-awesome-sass'
    gem 'simple_form'
    gem "pundit"

  RUBY
end

inject_into_file 'Gemfile', after: 'group :development, :test do' do
  <<-RUBY

  gem 'rspec'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'
  RUBY
end

inject_into_file 'Gemfile', after: 'group :development do' do
  <<-RUBY

  gem "letter_opener_web", "~> 1.0"
  RUBY
end

# Assets
########################################
run 'rm -rf app/assets/stylesheets'
run 'rm -rf vendor'
run 'curl -L https://github.com/lewagon/rails-stylesheets/archive/master.zip > stylesheets.zip'
run 'unzip stylesheets.zip -d app/assets && rm stylesheets.zip && mv app/assets/rails-stylesheets-master app/assets/stylesheets'

# Dev environment
########################################
gsub_file('config/environments/development.rb', /config\.assets\.debug.*/, 'config.assets.debug = false')

# Flashes
########################################
file 'app/views/shared/_flashes.html.erb', <<~HTML
  <% if notice %>
    <div class="alert alert-info alert-dismissible fade show m-1" role="alert">
      <%= notice %>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
      </button>
    </div>
  <% end %>
  <% if alert %>
    <div class="alert alert-warning alert-dismissible fade show m-1" role="alert">
      <%= alert %>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
      </button>
    </div>
  <% end %>
HTML

# MAIL TEMPLATE
########################################
run 'rm app/views/layouts/mailer.html.erb'
file 'app/views/layouts/mailer.html.erb', <<~HTML
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="x-apple-disable-message-reformatting" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="color-scheme" content="light dark" />
    <meta name="supported-color-schemes" content="light dark" />
    <title></title>
    <style type="text/css" rel="stylesheet" media="all">
      /* Base ------------------------------ */

      @import url('https://fonts.googleapis.com/css?family=Lato:400,700');

      body {
        width: 100% !important;
        height: 100%;
        margin: 0;
        -webkit-text-size-adjust: none;
      }

      a {
        color: #FFC65A;
      }

      a img {
        border: none;
      }

      td {
        word-break: break-word;
      }

      .preheader {
        display: none !important;
        visibility: hidden;
        mso-hide: all;
        font-size: 1px;
        line-height: 1px;
        max-height: 0;
        max-width: 0;
        opacity: 0;
        overflow: hidden;
      }

      /* Type ------------------------------ */

      body,
      td,
      th {
        font-family: "Lato", Helvetica, Arial, sans-serif;
      }

      h1 {
        margin-top: 0;
        color: #333333;
        font-size: 22px;
        font-weight: bold;
        text-align: left;
      }

      h2 {
        margin-top: 0;
        color: #333333;
        font-size: 16px;
        font-weight: bold;
        text-align: left;
      }

      h3 {
        margin-top: 0;
        color: #333333;
        font-size: 14px;
        font-weight: bold;
        text-align: left;
      }

      td,
      th {
        font-size: 16px;
      }

      p,
      ul,
      ol,
      blockquote {
        margin: 0.4em 0 1.1875em;
        font-size: 16px;
        line-height: 1.625;
      }

      p.sub {
        font-size: 13px;
      }

      /* Utilities ------------------------------ */

      .align-right {
        text-align: right;
      }

      .align-left {
        text-align: left;
      }

      .align-center {
        text-align: center;
      }

      /* Buttons ------------------------------ */

      .button {
        background-color: #222222;
        border-top: 10px solid #222222;
        border-right: 18px solid #222222;
        border-bottom: 10px solid #222222;
        border-left: 18px solid #222222;
        display: inline-block;
        color: #fff;
        text-decoration: none;
        border-radius: 3px;
        -webkit-text-size-adjust: none;
        box-sizing: border-box;
      }

      .button--green {
        background-color: #22bc66;
        border-top: 10px solid #22bc66;
        border-right: 18px solid #22bc66;
        border-bottom: 10px solid #22bc66;
        border-left: 18px solid #22bc66;
      }

      .button--red {
        background-color: #ff6136;
        border-top: 10px solid #ff6136;
        border-right: 18px solid #ff6136;
        border-bottom: 10px solid #ff6136;
        border-left: 18px solid #ff6136;
      }

      @media only screen and (max-width: 500px) {
        .button {
          width: 100% !important;
          text-align: center !important;
        }
      }

      /* Attribute list ------------------------------ */

      .attributes {
        margin: 0 0 21px;
      }

      .attributes_content {
        background-color: #F4F4F4;
        padding: 16px;
      }

      .attributes_item {
        padding: 0;
        padding-bottom: 10px;
      }

      /* Related Items ------------------------------ */

      .related {
        width: 100%;
        margin: 0;
        padding: 25px 0 0 0;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
      }

      .related_item {
        padding: 10px 0;
        color: #cbcccf;
        font-size: 15px;
        line-height: 18px;
      }

      .related_item-title {
        display: block;
        margin: 0.5em 0 0;
      }

      .related_item-thumb {
        display: block;
        padding-bottom: 10px;
      }

      .related_heading {
        border-top: 1px solid #cbcccf;
        text-align: center;
        padding: 25px 0 10px;
      }

      /* Discount Code ------------------------------ */

      .discount {
        width: 100%;
        margin: 0;
        padding: 24px;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
        background-color: #222222;
        border: 2px dashed #cbcccf;
      }

      .discount_heading {
        text-align: center;
      }

      .discount_body {
        text-align: center;
        font-size: 15px;
      }

      /* Social Icons ------------------------------ */

      .social {
        width: auto;
      }

      .social td {
        padding: 0;
        width: auto;
      }

      .social_icon {
        height: 20px;
        margin: 0 8px 10px 8px;
        padding: 0;
      }

      /* Data table ------------------------------ */

      .purchase {
        width: 100%;
        margin: 0;
        padding: 35px 0;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
      }

      .purchase_content {
        width: 100%;
        margin: 0;
        padding: 25px 0 0 0;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
      }

      .purchase_item {
        padding: 10px 0;
        color: #51545e;
        font-size: 15px;
        line-height: 18px;
      }

      .purchase_heading {
        padding-bottom: 8px;
        border-bottom: 1px solid #eaeaec;
      }

      .purchase_heading p {
        margin: 0;
        color: #85878e;
        font-size: 12px;
      }

      .purchase_footer {
        padding-top: 15px;
        border-top: 1px solid #eaeaec;
      }

      .purchase_total {
        margin: 0;
        text-align: right;
        font-weight: bold;
        color: #333333;
      }

      .purchase_total--label {
        padding: 0 15px 0 0;
      }

      body {
        background-color: #F4F4F4;
        color: #51545e;
      }

      p {
        color: #51545e;
      }

      p.sub {
        color: #6b6e76;
      }

      .email-wrapper {
        width: 100%;
        margin: 0;
        padding: 0;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
        background-color: #FFFFFF;
      }

      .email-content {
        width: 100%;
        margin: 0;
        padding: 0;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
      }

      /* Masthead ----------------------- */

      .email-masthead {
        padding: 25px 0;
        text-align: center;
        border-bottom: 1px solid #F4F4F4;
      }

      .email-masthead_logo {
        width: 94px;
      }

      .email-masthead_name {
        font-size: 16px;
        font-weight: bold;
        color: #222222;
        text-decoration: none;
      }

      /* Body ------------------------------ */

      .email-body {
        width: 100%;
        margin: 0;
        padding: 0;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
        background-color: #ffffff;
      }

      .email-body_inner {
        width: 570px;
        margin: 0 auto;
        padding: 0;
        -premailer-width: 570px;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
        background-color: #ffffff;
      }

      .email-footer {
        border-top: 1px solid #f4f4f4;
        width: 570px;
        margin: 0 auto;
        padding: 0;
        -premailer-width: 570px;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
        text-align: center;
      }

      .email-footer p {
        color: #6b6e76;
      }

      .body-action {
        width: 100%;
        margin: 30px auto;
        padding: 0;
        -premailer-width: 100%;
        -premailer-cellpadding: 0;
        -premailer-cellspacing: 0;
        text-align: center;
      }

      .body-sub {
        margin-top: 25px;
        padding-top: 25px;
        border-top: 1px solid #eaeaec;
      }

      .content-cell {
        padding: 35px;
      }

      /*Media Queries ------------------------------ */

      @media only screen and (max-width: 600px) {

        .email-body_inner,
        .email-footer {
          width: 100% !important;
        }
      }

      @media (prefers-color-scheme: dark) {

        body,
        .email-body,
        .email-body_inner,
        .email-content,
        .email-wrapper,
        .email-masthead,
        .email-footer {
          background-color: #333333 !important;
          color: #fff !important;
        }

        p,
        ul,
        ol,
        blockquote,
        h1,
        h2,
        h3,
        span,
        .purchase_item {
          color: #fff !important;
        }

        .attributes_content,
        .discount {
          background-color: #222 !important;
        }

        .email-masthead_name {
          text-shadow: none !important;
        }
      }

      :root {
        color-scheme: light dark;
        supported-color-schemes: light dark;
      }
    </style>
    <!--[if mso]>
        <style type="text/css">
          .f-fallback {
            font-family: Arial, sans-serif;
          }
        </style>
      <![endif]-->
  </head>

  <body>
  <span class="preheader">Welcome to Trendsetters Hub.</span>
  <table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0" role="presentation">
    <tr>
      <td align="center">
        <table class="email-content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
          <tr>
            <td class="email-masthead">
              <a href="https://hub.trendsetters.com" class="f-fallback email-masthead_name">
                Trendsetters Talent Hub
              </a>
            </td>
          </tr>
          <!-- Email Body -->
          <%= yield %>


          <tr>
            <td>
              <table class="email-footer" align="center" width="570" cellpadding="0" cellspacing="0"
                role="presentation">
                <tr>
                  <td class="content-cell" align="center">
                    <p class="f-fallback sub align-center">
                      &copy; 2021 Trendsetters Hub. All rights reserved.
                    </p>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </body>

</html>
HTML

run 'curl -L https://raw.githubusercontent.com/lewagon/awesome-navbars/master/templates/_navbar_wagon.html.erb > app/views/shared/_navbar.html.erb'

inject_into_file 'app/views/layouts/application.html.erb', after: '<body>' do
  <<-HTML
    <%= render 'shared/navbar' %>
    <%= render 'shared/flashes' %>
  HTML
end

# README
########################################
markdown_file_content = <<-MARKDOWN
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
## Branch naming convention (only when the branch doesn't correspond with a clubhouse story)
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
MARKDOWN
file 'README.md', markdown_file_content, force: true

# Generators
########################################
generators = <<~RUBY
  config.generators do |generate|
    generate.assets false
    generate.helper false
    generate.test_framework :test_unit, fixture: false
  end
RUBY

environment generators

########################################
# AFTER BUNDLE
########################################
after_bundle do
  # Generators: db + simple form + pages controller
  ########################################
  rails_command 'db:drop db:create db:migrate'
  generate('simple_form:install', '--bootstrap')
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-test-framework')

  # Replace simple form initializer to work with Bootstrap 5
  run 'curl -L https://raw.githubusercontent.com/heartcombo/simple_form-bootstrap/main/config/initializers/simple_form_bootstrap.rb > config/initializers/simple_form_bootstrap.rb'

  # Routes
  ########################################
  route "root to: 'pages#home'"
  inject_into_file 'config/routes.rb', before: 'end' do
    <<~RUBY
        if Rails.env.development?
          mount LetterOpenerWeb::Engine, at: '/letter_opener'
        end
    RUBY
  end

  # Git ignore
  ########################################
  append_file '.gitignore', <<~TXT
    # Ignore .env file containing credentials.
    .env*
    # Ignore Mac and Linux file system files
    *.swp
    .DS_Store
  TXT

  # Devise install + user
  ########################################
  generate('devise:install')
  generate('devise', 'User')

  # Pundit install
  ########################################
  generate('pundit:install')

  # App controller
  ########################################
  run 'rm app/controllers/application_controller.rb'
  file 'app/controllers/application_controller.rb', <<~RUBY
    class ApplicationController < ActionController::Base
      # before_action :authenticate_user!
      include Pundit::Authorization

    end
  RUBY

  # migrate + devise views
  ########################################
  rails_command 'db:migrate'
  generate('devise:views')

  # Pages Controller
  ########################################
  run 'rm app/controllers/pages_controller.rb'
  file 'app/controllers/pages_controller.rb', <<~RUBY
    class PagesController < ApplicationController
      skip_before_action :authenticate_user!, only: [ :home ]
      def home
      end
    end
  RUBY

  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "http://localhost:3000" }', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }', env: 'production'

  # Webpacker / Yarn
  ########################################
  run 'yarn add bootstrap @popperjs/core'
  # run "rails webpacker:install:stimulus"
  append_file 'app/javascript/packs/application.js', <<~JS
    import "bootstrap"
  JS

  inject_into_file 'config/webpack/environment.js', before: 'module.exports' do
    <<~JS
      // Preventing Babel from transpiling NodeModules packages
      environment.loaders.delete('nodeModules');
    JS
  end

  # Dotenv
  ########################################
  run 'touch .env'

  # Rubocop
  ########################################
  run 'curl -L https://raw.githubusercontent.com/lewagon/rails-templates/master/.rubocop.yml > .rubocop.yml'

  # Git
  ########################################
  git add: '.'
  git commit: "-m 'Initial commit with basic-template'"
end
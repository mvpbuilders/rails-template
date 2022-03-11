run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

# Rails and Ruby version
########################################
rails_requirement = "~> 7.0.0".freeze
requirement = Gem::Requirement.new(rails_requirement)
rails_version = Gem::Version.new(Rails::VERSION::STRING)
prompt = "This template requires Rails #{rails_requirement}. "\
"You are using #{rails_version}."

unless requirement.satisfied_by?(rails_version)
  p prompt
  exit
end

# GEMFILE
########################################
run 'rm Gemfile'
run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/Gemfile > Gemfile'

File.open("Gemfile", "r") do |f|
  f.each_line do |line|
    if /(^ruby|^gem "rails")/.match(line)
      inject_into_file 'Gemfile', after: 'git_source' do
        <<-RUBY
          line
        RUBY
      end
    end
  end
end

# Dev environment
########################################
gsub_file('config/environments/development.rb', /config\.assets\.debug.*/, 'config.assets.debug = false')

# Flashes
########################################
run 'mkdir app/views/shared'
run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/_flashes.html.erb > app/views/shared/_flashes.html.erb'

# Mail Template
########################################
run 'rm app/views/layouts/mailer.html.erb'

run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/mailer.html.erb > app/views/layouts/mailer.html.erb'

# Logo, Navbar
########################################
run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/images/logo.png > app/assets/images/logo.png'
run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/_navbar.html.erb > app/views/shared/_navbar.html.erb'

inject_into_file 'app/views/layouts/application.html.erb', after: '<body>' do
  <<-HTML
  
  <%= render 'shared/navbar' %>
    <%= render 'shared/flashes' %>
  HTML
end

# Footer
########################################
run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/_footer.html.erb > app/views/shared/_footer.html.erb'

inject_into_file 'app/views/layouts/application.html.erb', before: '</body>' do
  <<-HTML
  <%= render 'shared/footer' %>

  HTML
end

# README
########################################
run 'rm README.md'

run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/README.md > README.md'

# Rubocop
########################################
run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/.rubocop.yml > .rubocop.yml'

# Procfile
########################################
run 'curl -L https://raw.githubusercontent.com/mvpbuilders/rails-template/main/files/Procfile > Procfile'

# Generators
########################################
generators = <<~RUBY
config.generators do |g|
  g.test_framework :rspec,
    request_specs: false,
    view_specs: false,
    routing_specs: false,
    helper_specs: false,
    controller_specs: true
  g.stylesheets = false
end

config.to_prepare do
  Devise::Mailer.layout 'mailer'
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

  # Rspec install
  ########################################
  generate('rspec:install')

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
      before_action :authenticate_user!
      # include Pundit::Authorization

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

  # Bootstrap
  ########################################
  append_file 'app/assets/stylesheets/application.css', <<~CSS
    @import "bootstrap";
  CSS

  append_file 'config/initializers/assets.rb', <<~RUBY
    Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js )
  RUBY

  append_file 'config/importmap.rb', <<~RUBY
    pin "popper", to: 'popper.js', preload: true
    pin "bootstrap", to: 'bootstrap.min.js', preload: true
  RUBY

  append_file 'app/javascript/application.js', <<~JS
    import "popper"
    import "bootstrap"
  JS


  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "http://localhost:3000" }', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }', env: 'production'

  # Rubocop run
  ########################################
  run 'rubocop -A --disable-uncorrectable'
end
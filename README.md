# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
➜  mailblog rails g active_admin:install
      invoke  devise
    generate    devise:install
      create    config/initializers/devise.rb
      create    config/locales/devise.en.yml
  ===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================
      invoke    active_record
      create      db/migrate/20161012024659_devise_create_admin_users.rb
      create      app/models/admin_user.rb
      invoke      test_unit
      create        test/models/admin_user_test.rb
      create        test/fixtures/admin_users.yml
      insert      app/models/admin_user.rb
       route    devise_for :admin_users
        gsub    app/models/admin_user.rb
        gsub    config/routes.rb
      append    db/seeds.rb
      create  config/initializers/active_admin.rb
      create  app/admin
      create  app/admin/dashboard.rb
      create  app/admin/admin_user.rb
      insert  config/routes.rb
    generate  active_admin:assets
      create  app/assets/javascripts/active_admin.js.coffee
      create  app/assets/stylesheets/active_admin.scss
      create  db/migrate/20161012024703_create_active_admin_comments.rb
➜  mailblog

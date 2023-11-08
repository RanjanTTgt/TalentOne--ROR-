# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
#
# load css
Rails.application.config.assets.precompile += %w( jquery.min.js jquery_ujs.js css/dashboard css/icons css/svg css/fontawesome css/theme-style css/loader css/stylessrc/jquery.min src/js_cookie src/argon src/moment.min src/daterangepicker.min src/clockpicker.min )

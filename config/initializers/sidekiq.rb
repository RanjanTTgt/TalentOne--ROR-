require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_talentone_sidekiq_session"

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(user), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USER"] || 'talentone')) &
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"] || 'talentone'))
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['SIDEKIQ_SERVER_URL'] || 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['SIDEKIQ_CLIENT_URL'] || 'redis://localhost:6379/0' }
end


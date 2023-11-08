module JsonWebToken

  extend ActiveSupport::Concern

  RAILS_SECRET_KEY = Rails.application.credentials.dig(:secret_key_base)
  
  class << self
    # Generate Unique encoded JWT token
    def encode(payload, expiration)
      payload.reverse_merge!(meta(expiration))
      JWT.encode(payload, RAILS_SECRET_KEY)
    end

    # Decode jwt token and check its validity,
    def decode(token)
      JWT.decode(token, RAILS_SECRET_KEY)[0]
    end

    def meta(expiration)
      { exp: expiration }
    end

    def expired(payload)
      Time.at(payload['exp']) < Time.now
    end

  end


end

require "jwt"

class TokenManager
  class << self
    def generate_token(user_id, exp = 1.minutes.from_now)
      payload = { user: user_id, exp: exp.to_i }
      issue_token(payload)
    end

    def issue_token(payload)
      JWT.encode(payload, secret, "HS512")
    end

    def secret
      Rails.application.secrets.secret_key_base
    end

    def decode(token)
      JWT.decode(token, secret, true, algorithm: "HS512")
    end

    def authenticate(token)
      decode(token).first
    rescue
      {}
    end
  end
end

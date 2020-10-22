Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.omniauth_facebook_key, Rails.application.secrets.omniauth_facebook_secret,
           scope: 'public_profile', info_fields: 'id,name,link'
  provider :twitter, Rails.application.secrets.omniauth_twitter_key, Rails.application.secrets.omniauth_twitter_secret
  provider :google_oauth2, Rails.application.secrets.omniauth_google_key, Rails.application.secrets.omniauth_google_secret,
           scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google', skip_jwt: true
end

OmniAuth.config.on_failure = Proc.new do |env|
  SessionsController.action(:auth_failure).call(env)
end
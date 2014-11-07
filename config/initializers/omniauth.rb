OmniAuth.config.full_host = APP_CONFIG['eb_signup_callback']
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, APP_CONFIG['github_client_id'], APP_CONFIG['github_client_secret'], scope: "user,repo", provider_ignores_state: true
end
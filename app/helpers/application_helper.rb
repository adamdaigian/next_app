module ApplicationHelper
  def omniauth_signin_path(provider)
  	Rails.env == "development" ? "/auth/#{provider.to_s}" : "/#{APP_CONFIG['eb_root']}/auth/#{provider.to_s}"
  end

  def eb_path(path)
  	Rails.env == "development" ? path : "/#{APP_CONFIG['eb_root']}#{path}"
  end
end

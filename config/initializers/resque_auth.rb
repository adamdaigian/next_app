require 'resque/server'

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user == APP_CONFIG['admin_username']
  password == APP_CONFIG['admin_pwd']
end

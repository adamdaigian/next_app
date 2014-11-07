module BasicAuthHelper
  # use for controller tests
  def http_login_controller
    user = APP_CONFIG['admin_username']
    pwd = APP_CONFIG['admin_pwd']
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pwd)
  end

  # use for features tests
  def http_login
    user = APP_CONFIG['admin_username']
    pwd = APP_CONFIG['admin_pwd']
    page.driver.browser.authorize(user, pwd)
  end
end
class AccountsController < ApplicationController
  http_basic_authenticate_with name: APP_CONFIG['admin_username'], password: APP_CONFIG['admin_pwd'], only: ['index']
  layout "splash"

  def login
  end


  def signup
    @account ||= Account.new
#    @signup_callback_url = signup_callback_url
  end


  def create
    @account ||= Account.new(account_params)
    @account.password = account_params["password"]

    logger.debug "SIGNING UP >>>> #{@account.inspect}"
    logger.debug "SIGNING UP >>>> #{account_params.inspect}"
    logger.debug "SIGNING UP >>>> #{@account.password}"
    logger.debug "SIGNING UP >>>> #{params.inspect}"

    if @account.save
      respond_to do |format|
        format.html { render :processing }
      end

    else
      respond_to do |format|
        format.html { render :signup }
      end
    end
  end


  def processing
    @account = Account.find_by_token(params[:account_token])


    #cookies[:token] = { :value => value, :expires => 1.hour.from_now }


  end


  def index
    @accounts = Account.paginate(:page => params[:page])
    render layout: "application"
  end


  def check_status
  	# call the service and get status
    logger.debug ">>>>>>>>>>> CHECKING STATUS"
    @account = Account.find_by_token(params[:account_token])
    logger.debug ">>>>>>>>>>> CHECKING STATUS account: #{@account.inspect}"


    status = @account.check_tenant_status

    case status
    when 'processing'
      # do it again
      render json: { status: :processing }

#      respond_to do |format|
#        format.json { render json: { status: :processing}}
#      end

    when 'ready'
      response["Set-Cookie"] = "token=#{@account.eb_cookie}; Path=/;"
      @account.eb_cookie = nil
      @account.does_not_require_password = true
      @account.save

      render json: { status: :ok }
#      respond_to do |format|
#        format.json { render json: { status: :ok } }
#      end

    when 'error'
      # stop with error
      render json: { status: :error, message: "Something went wrong" }
#      respond_to do |format|
#        format.json { render json: { status: :error, message: "Something went wrong" }}
#      end

    end
  end


  private
  def account_params
    params.require(:account).permit(:name, :email, :password)
  end
end

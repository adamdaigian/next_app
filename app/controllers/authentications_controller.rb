class AuthenticationsController < ApplicationController

	def create
        logger.debug ">>>>>>>>>>>> OMNIAUTH CREATE >>>> "

        omniauth    = request.env["omniauth.auth"]
        #origin      = request.env['HTTP_REFERER'] # http://10.1.0.40:3000/signup
        origin      = request.env['omniauth.origin'] # http://10.1.0.40:3000/signup

        #logger.debug "ORIGIN>>>>>> #{origin}"
        #logger.debug "ORIGIN>>>>>> #{request.env}"

        authentication = Authentication.create_authentication_and_object(omniauth, origin)

        action_and_path = authentication.calculate_action_and_path(origin)

        action  = action_and_path[0]
        redirect_path = action_and_path[1]

        @invitation = authentication.invitation #|| Invitation.new
        @account = authentication.account
                
        if action == "redirect_to"
            respond_to do |format|
                format.html { redirect_to redirect_path }
            end

        else
            if redirect_path != "accounts/signup"
                respond_to do |format|
                    format.html { render redirect_path }
                end
            else
                respond_to do |format|
                    format.html { render redirect_path, layout: "splash" }
                end

            end
        end

	end

end

class CreateEBAccount
	@queue = :account

	def self.perform(account_id, options={})
		@account = Account.find(account_id)
		@account.password = options.try(:[], "password")

		if @account.create_tenant(options)

			AccountMailer.welcome_email(account_id).deliver
			
		end
		#raise "Oh no! Something when wrong #{args.inspect}" if failed?
	end

end
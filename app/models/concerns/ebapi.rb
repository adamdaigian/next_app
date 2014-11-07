module EBAPI
	require 'net/http'
	require 'json'

	def self.prepare_https(uri)
    	http = Net::HTTP.new(uri.host, uri.port)
    	http.use_ssl = true
    	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    	http	
	end


	def self.tenant_index
		uri = URI.parse("https://beta.elasticbox.com/services/admin/tenant/")

		http = prepare_https(uri)

    	req = Net::HTTP::Get.new(uri.to_s)
    	req.content_type = 'application/json'
    	req['X-AUTH-TOKEN'] = APP_CONFIG['eb_token']

    	response = http.request(req)
    	response
	end


	def self.create_tenant(payload)
		uri = URI.parse('https://beta.elasticbox.com/services/admin/tenant')

		http = prepare_https(uri)

    	req = Net::HTTP::Post.new(uri.to_s)
    	req.content_type = 'application/json'
    	req['X-AUTH-TOKEN'] = APP_CONFIG['eb_token']

    	req.body = payload

    	response = http.request(req)
    	response
	end


	def self.tenant_status(tenant_id)
		uri = URI.parse("https://beta.elasticbox.com/services/admin/tenant/#{tenant_id}")

		http = prepare_https(uri)

    	req = Net::HTTP::Get.new(uri.to_s)
    	req.content_type = 'application/json'
    	req['X-AUTH-TOKEN'] = APP_CONFIG['eb_token']

    	response = http.request(req)

    	response
	end


	def self.destroy_tenant(tenant_id)
		uri = URI.parse("https://beta.elasticbox.com/services/admin/tenant/#{tenant_id}")

		http = prepare_https(uri)

    	req = Net::HTTP::Delete.new(uri.to_s)
    	req.content_type = 'application/json'
    	req['X-AUTH-TOKEN'] = APP_CONFIG['eb_token']

    	response = http.request(req)

    	response
	end

end
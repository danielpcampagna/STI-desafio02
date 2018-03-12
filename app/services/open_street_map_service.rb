class OpenStreetMapService
	@@URL = "http://nominatim.openstreetmap.org"
	@@PATH = "/search"
	@@DEFAULT_PARAMS = "&format=json&polygon=1&addressdetails=1"
	

	def self.get(params)
		request_api = @@PATH + "?"
		request_api += URI.encode_www_form(params)
		request_api += @@DEFAULT_PARAMS
		
		url = URI.parse(@@URL)
		res = Net::HTTP.start(url.host, url.port) do |http|
			http.get(request_api)
		end
		return JSON.parse res.body
	end
end
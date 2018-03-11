class RioStationService
	@@URL = "http://dadosabertos.rio.rj.gov.br"
	@@PATH = "/apiTransporte/apresentacao/rest/index.cfm/estacoesBikeRio"
	@@DICTIONARY = {
		"BAIRRO" => "neighborhood",
		"ESTACAO" => "station",
		"CODIGO" => "code",
		"ENDERECO" => "address",
		"NUMERO" => "number",
		"LATITUDE" => "latitude",
		"LONGITUDE" => "longitude"
	}

	def self.DICTIONARY
		@@DICTIONARY
	end
	def self.get
		url = URI.parse(@@URL)
		res = Net::HTTP.start(url.host, url.port) do |http|
			http.get(@@PATH)
		end
		return JSON.parse res.body
	end


end
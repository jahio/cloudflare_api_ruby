#
# api_wrapper.rb
#
# A basic class for performing GET/POST requests utilizing Typhoeus
# (https://github.com/typhoeus/typhoeus) to the Cloudflare API.
#

class ApiWrapper

  # Cloudflare's documented endpoint. Docs are located at
  # http://www.cloudflare.com/docs/client-api.html
  ENDPOINT = "https://www.cloudflare.com/api_json.html"
  AUTH     = {tkn: ENV['cloudflare_api_key'], email: ENV['cloudflare_email']}

  #
  # ApiWrapper.get("stats", {z: "example.com", interval: 20})
  # Performs a GET request to the API with the given action, optionally
  # providing a hash of parameters for the request. Authentication is
  # handled automatically by this class.
  def self.get(action, params = {})
    response = Typhoeus::Request.new(
      ENDPOINT,
      method: :get,
      params: params.merge(AUTH).merge({a: action.to_s}).each do |k,v|
        # Force the value into a string, juuuuust in case...
        v = v.to_s
      end
    )
    return response.run
  end
end

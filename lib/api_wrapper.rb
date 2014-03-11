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
  AUTH     = {tkn: ENV['cloudflare_api_key'], email: URI.escape(ENV['cloudflare_email'])}

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

  #
  # ApiWrapper.post("rec_new", {z: "example.com", type: "A", name: "mysub",
  #                  content: "1.2.3.4"})
  #
  # Performs a POST request to the API for the action (first parameter) and with
  # the parameters in the supplied hash. As for what to send up, for that you
  # need the API docs: http://www.cloudflare.com/docs/client-api.html#s1.1
  # The example above adds a subdomain called "mysub" (which would resolve to
  # "mysub.example.com") with the IP address of "1.2.3.4".
  def self.post(action, params = {})
    response = Typhoeus::Request.new(
      ENDPOINT,
      method: :post,
      params: params.merge(AUTH).merge({a: action.to_s}).each do |k,v|
        # Force the value into a string, juuuuust in case...
        v = v.to_s
      end
    )
    return response.run
  end
  # Those of you reading the code, at this point, are probably wondering, "why
  # do you have two separate get/post methods that are identical?"
  # Answer: as a matter of basic design. I want to keep them separate *from
  # the get-go* so that if I need to change the behavior of one in the future,
  # we don't have anybody already used to throwing GET/POST requests around
  # interchangably, and hopefully have it ingrained that they are indeed
  # different methods with different purposes.
end

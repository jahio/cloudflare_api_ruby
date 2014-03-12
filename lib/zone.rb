require 'json'
#
# lib/zone.rb
#
# Sets up a small pseudo-model to create new DNS zone given an existing "zone",
# or root domain name.
#

class Zone
  attr_accessor :record_type, :destination, :name, :ttl
  attr_reader   :zone

  def initialize(zone)
    @zone = zone
  end

  # Retrieves a list of all known entries for the given zone.
  #
  # Example:
  #   foo = Zone.new("example.com")
  #   entries = foo.zone_entries
  #
  # WARNING: This method does not (yet) go beyond the Cloudflare API
  # limit of 180 records returned in a result set. You can use the "o"
  # parameter to give it an offset and start from there (ala pagination)
  #
  def zone_entries
    response = ApiWrapper.get("rec_load_all", {z: @zone})
    body = JSON.parse(response.body)
    if response.code == 200 && body['result'] && body['result'] == 'success'
      return body['response']['recs']['objs'] # body -> records -> objects
    else
      raise "Api Error: Operation unsuccessful. Response body: \n\n#{body}"
    end
  end


  # Creates a given subdomain on a domain.
  #
  # Example:
  #   foo = Zone.new("example.com")
  #   foo.add_subdomain("CNAME", "foo") # create foo.example.com as a CNAME to example.com
  #   foo.add_subdomain("A", "bar", "1.2.3.4") # create bar.example.com as an A record to 1.2.3.4
  #   foo.add_subdomain("A", "baz", "3.4.5.6", 120) # A record for baz.example.com with 120 second TTL
  #
  def add_subdomain(record_type, name, content = @zone, ttl = 1)
    # First, look to see if the zone already exists.
    zones = zone_entries
    if zones.any? { |x| x['name'].downcase == "#{name}.#{@zone}".downcase }
      raise DomainExistsError, "The zone #{name}.#{@zone} already exists."
    end

    @record_type = record_type
    @name        = name
    @content     = content
    @ttl         = ttl

    # Wrap this up in an API request and send to Cloudflare.
    result = ApiWrapper.post("rec_new", {z: @zone, type: @record_type,
      name: @name, content: @content, ttl: @ttl})

    body = JSON.parse(result.body)

    if result.code == 200 && body['result'] && body['result'] == 'success'
      return true
    else
      raise "Api Error: Operation unsuccessful. Response body: \n\n#{body}"
    end
  end
end

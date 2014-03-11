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


  # Creates a given subdomain on a domain.
  #
  # Example:
  #   foo = Subdomain.new("example.com")
  #   foo.create("CNAME", "foo") # create foo.example.com as a CNAME to example.com
  #   foo.create("A", "bar", "1.2.3.4") # create bar.example.com as an A record to 1.2.3.4
  #   foo.create("A", "baz", "3.4.5.6", 120) # A record for baz.example.com with 120 second TTL
  #
  def add_subdomain(record_type, name, content = @zone, ttl = 1)
    @record_type = record_type
    @name        = name
    @content     = content
    @ttl         = ttl

    # Wrap this up in an API request and send to Cloudflare.
    return result = ApiWrapper.post("rec_new", {z: @zone, type: @record_type,
      name: @name, content: @content, ttl: @ttl})
  end
end

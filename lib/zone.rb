require 'cloudflare'

#
# lib/zone.rb
#
# Sets up a small pseudo-model to create new DNS zone given an existing "zone",
# or root domain name.
#

class Zone
  attr_accessor :record_type, :destination, :ttl
  attr_reader   :zone_name, :cf, :zone_entries

  def initialize(zone_name)
    @zone_name = zone_name
    @cf = CloudFlare::connection(ENV['cloudflare_api_key'], ENV['cloudflare_email'])

    # Start by populating existing known zone entries
    populate_zone_entries
  end

  # For deleting a CNAME
  # Example:
  # z = Zone.new("example.com") # my domain name is example.com
  # z.delete_cname("foobar") # deletes subdomain foobar.example.com
  #
  # Where cname is the "displayed name" of the cname you want to get rid of,
  # WITHOUT the .example.com at the end. So don't pass foobar.example.com, just
  # pass in "foobar".
  # Will reload zone entries automatically after finishing.
  def delete_cname(cname)
    begin
      # Start by looking for it. If it doesn't exist, say something about it
      cname_id = (@zone_entries.select { |x| x['name'] == "#{cname}.#{@zone_name}" }).first['rec_id']
      res = @cf.rec_delete(@zone_name, cname_id)
      if res['result'] == 'success' # it worked
        return true
      else
        # API returned something other than success.
        STDOUT.puts("API request appears to have failed:\n\n#{res}")
      end
    rescue => e
      # Something weird happened, put it out on the screen.
      STDOUT.puts("Something funky happened.\n\n#{e}")
    ensure
      # End by refreshing the zone list.
      populate_zone_entries
    end
  end

  # A very simple method for adding CNAME subdomains. Uses default TTL. Look at
  # 'rec_new' options for more flexibility.
  def add_subdomain(subdom)
    # This just adds a subdomain going directly to the same place as the root
    # domain that you gave it when you queried CF.
    begin
      res = @cf.rec_new(@zone_name, "CNAME", subdom, @zone_name, 1)
      if res['result'] == 'success'
        return true
      else
        STDOUT.puts("API request appears to have failed:\n\n#{res}")
      end
    rescue => e
      STDOUT.puts("Something funky happened.\n\n#{e}")
    ensure
      populate_zone_entries
    end
  end

private

  # Grabs existing zone entries from Cloudflare and then sets the zone_entries
  # attribute on this object to equal the results.
  def populate_zone_entries
    begin
      @zone_entries = @cf.rec_load_all(@zone_name)['response']['recs']['objs']
    rescue => e
      STDOUT.puts e.message
    end
  end
end

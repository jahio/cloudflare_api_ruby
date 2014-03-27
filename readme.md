# cloudflare_api_ruby

This is basic tool to let you interface with the Cloudflare.com API using Ruby.
This isn't meant to be a perfectly tested library or anything - it's a quick
and dirty hack designed to let somebody do some one-off work easily. If you want
something with a bit more capability than this small script, check out one of
its dependencies,
[cloudflare gem](https://github.com/b4k3r/cloudflare) by
[Marcin Prokop](https://github.com/b4k3r). This is a fuller implementation of
Cloudflare's API functionality in a Ruby wrapper. This script just provides
an even easier interface for working with it.

I may or may not improve or maintain this code. It's mostly here for me and a
client to utilize as needed, but with the hope that somebody finds it useful
for a one-off project.

### STATUS: DEVELOPMENT
__Do NOT use for production purposes!__

## Dependencies
* [cloudflare](http://rubygems.org/gems/cloudflare)
* [bundler](http://rubygems.org/gems/bundler)
* [pry](http://rubygems.org/gems/pry)

## Crash Course

This tool is dead simple, so don't sweat most of this.

0. Make sure you have a properly configured Ruby environment and run ```bundle install```.
1. Open up config/creds_example.rb and substitute the examples with your account credentials.
2. Rename config/creds_example.rb to just config/creds.rb:
```bash
mv config/creds_example.rb config/creds.rb # on *nix systems including Mac OS X
rename config\creds_example.rb config\creds.rb # on Windows...I *think*...
```
3. Run the "control" file:
```bash
bundle exec ./control.rb # on *nix/Mac OS
bundle exec ruby control.rb # on Windows...I *think*...
```

### Adding a subdomain (example)

This will add a subdomain for the given domain that is a CNAME (not an A record)
to the same location as your actual given root domain, with a default TTL.

```ruby
zone = Zone.new("example.com")
zone.add_subdomain("blog") # blog.example.com will be added to Cloudflare
zone.zone_entries.select { |x| x['display_name'] == 'blog' } # show that blog now exists in the result set
```

Every time ```add_subdomain``` fires, it runs an ensure block to be certain that
the zone_entries list is re-populated with the latest data.

### Removing a CNAME (subdomain) record (example)

Say you want to remove a CNAME record from the zone. This is specifically built
to handle subdomains but could be extended to do more. Here's how you might
go about doing that.

```ruby
zone = Zone.new("example.com")

# Perhaps you want to batch the zones to delete? The following line will take
# the existing zone_entries array, run select on it, look for all elements where
# the hash key 'name' - returned by Cloudflare's API - matches the given
# argument (in this case, 'bad' - could be something like 'blog' or 'listserv')
# or whatever, and then that result set has map run on it to fetch out just
# the list of 'display_name' values.
#
# The difference, at this time of writing anyway, between 'name' and
# 'display_name' in Cloudflare's API is that 'name' is the FULL name of the
# record - e.g. blog.example.com. However, with that same example, the
# 'display_name' value would simply be 'blog'. That could change in the future,
# but for now that's how it works. So we're looking for a match against any
# element that has a name value (you could query display_name as well) of
# "bad", then fetching only the 'display_name', which leaves off the root
# domain, and returning that array to be operated on, since the delete_cname
# method is meant to operate on subdomains primarily.
bad_zones = (zone.zone_entries.select { |x| x['name'].match(/bad/i) }).map { |x| x['display_name']}
bad_zones.each { |zn| z.delete_cname(zn) } # run the loop
```

That will nuke all the records that have a name matching 'bad', for example.

### Adding multiple 'A' records

Say you have a bunch of subdomains you want pointing to a different IP address.
All you'd need to do is grab the list of those subdomains, then use
```Zone#add_a_record``` to add them inside a loop.

```ruby
z = Zone.new("example.com")
list = ['one', 'two', 'three']
list.each { |x| z.add_a_record('A', x, "1.2.3.4") }
end
```

The default value for the first argument is going to be 'A' anyway, so you could
actually skip that parameter if you wanted. A simpler example of the above might
be...

```ruby
z = Zone.new("example.com")
z.add_a_record('A', "blog", "1.2.3.4")
```

This would add a "blog" subdomain as an A record that points to the IP 1.2.3.4.

## If you get SSL warnings/errors...

If you get issues/errors with SSL when trying to use this tool, it's probably
that the ca cert bundle on your machine is out of date. This is a problem that
bites us all in the ass eventually and seriously needs a permanent fix. For now,
go download [homebrew](http://brew.sh/) and then run
```brew install curl-ca-bundle```. It should give you a path to where the CA
bundle is now installed. Next, run:

```
export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
```

Then try again. Ruby will look at that environment variable to find the latest
CA bundle before running things against OpenSSL. You should probably also add
that to your ~/.zshrc or ~/.bashrc as well. This is for Mac OS X - if you're
on Linux, see if your package manager has an update for your CA bundle. If not,
you may need to grab the latest by hand and update it on your own. Sorry dude.

A good article on this error can be located at
http://mislav.uniqpath.com/2013/07/ruby-openssl/

It's above but I'm going to say this again for the purposes of caution:

*THIS SOFTWARE IS NOT FINISHED AND NOT TESTED. IT WILL NOT BE CONSIDERED SO
UNTIL THIS MESSAGE IS REMOVED. DO NOT USE THIS FOR ANYTHING YOU ACTUALLY CARE
ABOUT. BY USING THIS SOFTWARE, YOU ABSOLVE ITS AUTHOR(S), ASSOCIATES, AND ALL
OTHER PARTIES CONNECTED THEREWITH FROM ANY AND ALL LIABILITY FROM NOW UNTIL HELL
FREEZES OVER, PIGS FLY, AND MICROSOFT ABANDONS DOS FOR A LINUX KERNEL AND EXT4
FILESYSTEM, ALL ON THE SAME DAY SANTA IS PROVEN TO BE REAL WITH PHOTOGRAPHIC
EVIDENCE OF HIM RIDING THE AFOREMENTIONED FLYING PIG.*

*...or, ya know, forever basically. Just don't sue anybody, k?*

License: MIT. http://opensource.org/licenses/MIT

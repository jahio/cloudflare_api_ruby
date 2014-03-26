# cloudflare_api_ruby

This is basic tool to let you interface with the Cloudflare.com API using Ruby.
This isn't meant to be a perfectly tested library or anything - it's a quick
and dirty hack designed to let somebody do some one-off work easily. If you want
something more "production ready" for bigger/better use cases, instead of a
scripted interface like this, check out the
[cloudflare gem](https://github.com/b4k3r/cloudflare) by
[Marcin Prokop](https://github.com/b4k3r).

I may or may not improve or maintain this code. It's mostly here for me and a
client to utilize as needed, but with the hope that somebody finds it useful
for a one-off project.

## STATUS: DEVELOPMENT
### Do NOT use for production purposes!

## Dependencies

- [typhoeus](https://github.com/typhoeus/typhoeus) (for making raw HTTP requests)
- [pry](https://github.com/pry/pry) (for basic debugging, feel free to remove from Gemfile and re-bundle)

## Crash Course

This tool is dead simple, so don't sweat most of this.

0. Make sure you have a properly configured Ruby environment and run ```bundle install```.
1. Open up config/creds_example.rb and substitute the examples with your account credentials.
2. Rename config/creds_example.rb to just config/creds.rb:
```
mv config/creds_example.rb config/creds.rb # on *nix systems including Mac OS X
rename config\creds_example.rb config\creds.rb # on Windows...I *think*...
```
3. Run the "control" file:
```
bundle exec ./control.rb # on *nix/Mac OS
bundle exec ruby control.rb # on Windows...I *think*...
```

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

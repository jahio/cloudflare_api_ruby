# cloudflare_api_ruby

This is basic tool to let you interface with the Cloudflare.com API using Ruby.

## STATUS: DEVELOPMENT
### Do NOT use for production purposes!

## Dependencies

- typhoeus (for making raw HTTP requests)
- pry (for basic debugging, feel free to remove from Gemfile and re-bundle)

## Crash Course

This tool is dead simple, so don't sweat most of this.

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

*THIS SOFTWARE IS NOT FINISHED AND NOT TESTED. IT WILL NOT BE CONSIDERED SO UNTIL
THIS MESSAGE IS REMOVED. DO NOT USE THIS FOR ANYTHING YOU ACTUALLY CARE ABOUT.
BY USING THIS SOFTWARE, YOU ABSOLVE ITS AUTHOR(S), ASSOCIATES, AND ALL OTHER PARTIES
CONNECTED THEREWITH FROM ANY AND ALL LIABILITY FOR NOW UNTIL THE END OF DAYS.*

License: MIT. http://opensource.org/licenses/MIT

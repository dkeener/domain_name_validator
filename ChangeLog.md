0.5 (TBD)

* By request, the gem now ignores leading/trailing whitespace when validating
  domain names. This includes ignoring newlines at the end of domain names.

* Remove timestamp from gemspec so Rubygems will calculate gem dates forus.

0.4 (2013-07-17)
----------------

* By request, added rudimentary TLD checking. A TLD, the right-most label of a
  domain name, should be either 2 or 3 characters, unless it's "aero", "arpa",
  "museum" or begins with "xn--" (for a normalized Unicode TLD). This check
  does not validate against a master list of TLD's, but basically just fails
  a domain name if the TLD basically could not be valid under any
  circumstances. This validation would, for example, reject a domain name
  such as "test.domain".

* (0.4.1 - 2013-07-17) Added "info" as a valid extra-long TLD. How I missed
  this one, I have no idea.

* (0.4.2 - 2013-07-17) Added a check for zero-length domain names, either
  empty strings or Ruby nil values being passed in. In practice, these edge
  cases were actually happening.

* (0.4.3 - 2013-08-01) For the TLD reality check, IANA (the Internet Assigned
  Numbers Authority) recognizes some long TLD's that were not on the original
  list for this gem, such as ".travel", ".jobs", etc. To reiterate, the gem
  does not validate against the full list of TLD's or effective TLD's, but 
  it does validate that the TLD length COULD be a valid TLD. As an example,
  a TLD of 14 characters would be rejected because there are no valid domains
  that could match that pattern.

* (0.4.3 - 2013-08-01) Added the "license" attribute to the gemspec. This is
  in response to an issue that was opened on GitHub.

* (0.4.4 - 2013-08-28) Fixed bug involving proper handling of domain names with
  capital letters. Reported by a user.

0.3 (2013-06-28)
----------------

* Added a check, because labels cannot begin with a period.
* Updated documentation, plus defined Road Map for future changes.

0.2 (2013-06-17)
----------------

First version built and deployed as a gem on a real project. Released on
Rubygems.org for the first time.

* Added more RSpec tests for improved test coverage.
* Enhanced documentation.


0.1 (2013-06-10)
----------------

Initial working version of the code, with minimal RSpec tests. Released on
GitHub for review, but not yet published as a gem to the Ruby community.

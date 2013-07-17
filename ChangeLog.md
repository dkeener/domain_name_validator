0.4 (2013-07-17)
----------------

* By request, added rudimentary TLD checking. A TLD, the right-most label of a
  domain name, should be either 2 or 3 characters, unless it's "aero", "arpa",
  "museum" or begins with "xn--" (for a normalized Unicode TLD). This check
  does not validate against a master list of TLD's, but basically just fails
  a domain name if the TLD basically could not be valid under any
  circumstances. This validation would, for example, reject a domain name
  such as "test.domain".

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

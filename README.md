domain_name_validator
=====================

Ever needed to validate a domain name? This gem will validate any domain name
represented in ASCII or UTF-8.

The scope of this gem is deliberately focused on validating domain names. It
simply answers the question: "Is this a real domain name?" Using this command,
you can make a realistic assessment about whether you want to store a domain
name or URL in your database. This gem will tell you 1) that a domain is or
is not valid, and 2) if it's not valid, what the errors are. 

There are other gems and libraries that parse domain names into their various
components, or parse URLS, or properly handle Unicode domain names, etc. Use
them; many of them are very good at their well-defined roles. But none of the
ones that I came across were very good at simply telling me whether a domain
names was valid.

How It Works
------------

To validate a domain name:

    v = DomainNameValidator.new
    if v.validate('keenertech.com')
      # Do something
    end

What about error messages? If a domain isn't valid, it's often desirable to
find out why the domain ewasn't valid. To do this, simply pass an array into
the "validate" message as the optional second argument.

    errs = []
    v = DomainNameValidator.new
    unless v.validate('keenertech.123', errs)
      puts("Errors: #{errs.inspect}")
    end

This generates the following output:

    Errors: ["The top-level domain (the extension) cannot be numerical"]

This gem should make it easy to validate domain names.

About Domain Names
------------------

Domain names provide a unique, memorizable name to represent numerically
addressable Internet resources. They also provide a level of abstraction that
allows the underlying Internet address to be changed while still referencing
a resource by its domain name. The domain name space is managed by the 
Internet Corporation for Assigned Names and Numbers (ICANN).

The right-most label of a domain name is referred to as the top-level domain,
or TLD. A limited set of top-level domain names, and two-character country
codes, have been standardized. The Internet Assigned Numbers Authority (IANA)
maintains an annotated list of top-level domains, as well as a list of
"special use," or reserved, top-level domain names.

* http://www.iana.org/domains/root/db/
* http://www.iana.org/assignments/special-use-domain-names/special-use-domain-names.xml

Domain names follow some very detailed rules:

* The maximum length of a domain name is 253 characters.

* A domain name is divided into "labels" separated by periods. The maximum
  number of labels is 127.

* The maximum length of any label within a domain name is 63 characters.

* No label, including TLDs, can begin or end with a dash.

* Top-level domain names cannot be all numeric.

* The right-most label must be either a recognized TLD or a 2-letter country
  code. The only exception is for international domain names, for which
  TLD checking is currently bypassed.


Internationalized Domain Names
------------------------------

What about internationalized domain names? ICANN approved the Internationalized
Domain Name (IDNA) system in 2003. This standard allows for Unicode domain
names to be encoded into ASCII using Punycode. Essentially, a label may contain
"xn--" as a prefix, followed by the Punycode representation of a Unicode string,
resulting in domain names such as xn--kbenhavn-54.eu. Note that there are also
some approved Unicode TLDs.

The process of rendering an internationalized domain name in ASCII via 
Punycode is called normalization. This gem will validate a normalized domain
name, but not a Unicode domain name. Note, however, that it currently does not
validate normalized TLDs against ICANN's list of valid TLDs.

It's also unclear whether the "xn--" prefix should count against the label
size limit of 63 characters. In the absence of specific guidelines, and because
I've never actually seen an overly long label, I have chosen to apply the limit
irregardless of the presence of the "xn--" prefix within a label.

Requirements
------------

This is a Ruby gem with no run-time dependencies on anything else. It's only
been tested under Ruby 1.9.3, but it should be compatible with all versions of
Ruby more recent than Ruby 1.8.6.

Install
-------

Installation doesn't get much simpler than this:

    gem install domain_name_validator

Author
------

David Keener

Many thanks also for the support of General Dynamics and the Department of
Homeland Security (DHS).

YOUR SUPPORT
------------

Please help me make this gem as useful as possible for its admittedly limited
purpose. If ICANN's rules change, a clearer rules interpretation becomes
available, or new valid TLDs are added, please help out by notifying me of
potentially useful changes, or by submitting a pull request via GitHub.

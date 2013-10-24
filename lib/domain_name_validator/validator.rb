# The purpose of this class is to provide a simple capability for validating
# domain names represented in ASCII, a feature that seems to be missing or
# obscured in other more wide-ranging domain-related gems.

class DomainNameValidator

  MAX_DOMAIN_LENGTH = 253
  MAX_LABEL_LENGTH = 63
  MAX_LEVELS = 127
  MAX_TLD_LENGTH = 3       # Except for "aero", "arpa", "info" and "museum"
  MIN_LEVELS = 2
  MIN_TLD_LENGTH = 2

  ERRS = {
    :bogus_tld =>
       'Malformed TLD: Could not possibly match any valid TLD',
    :illegal_chars =>
       'Domain label contains an illegal character',
    :illegal_start =>
       'No domain name may start with a period',
    :label_dash_begin =>
       'No domain label may begin with a dash',
    :label_dash_end =>
       'No domain label may end with a dash',
    :max_domain_size =>
       'Maximum domain length of 253 exceeded',
    :max_label_size =>
       'Maximum domain label length of 63 exceeded',
    :max_level_size =>
       'Maximum domain level limit of 127 exceeded',
    :min_level_size =>
       'Minimum domain level limit of 2 not achieved',
    :top_numerical =>
       'The top-level domain (TLD) cannot be numerical',
    :zero_size =>
       'Zero-length domain name'
    }

  # Validates the proper formatting of a normalized domain name, i.e. - a
  # domain that is represented in ASCII. Thus, international domain names are
  # supported and validated, if they have undergone the required IDN
  # conversion to ASCII. The validation rules are:
  #
  # 1. The maximum length of a domain name is 253 characters.
  # 2. A domain name is divided into "labels" separated by periods. The maximum
  #    number of labels (including the top-level domain as a label) is 127.
  # 3. The maximum length of any label within a domain name is 63 characters.
  # 4. No label, including top-level domains, can begin or end with a dash.
  # 5. Top-level names cannot be all numeric.
  # 6. A domain name cannot begin with a period.

  def validate(dn, errs = [])
    if dn.nil?
      errs << ERRS[:zero_size]
    else
      dn = dn.strip
      errs << ERRS[:zero_size] if dn.size == 0
    end

    if errs.size == 0
      errs << ERRS[:max_domain_size] if dn.size > MAX_DOMAIN_LENGTH
      parts = dn.downcase.split('.')
      errs << ERRS[:max_level_size] if parts.size > MAX_LEVELS
      errs << ERRS[:min_level_size] if parts.size < MIN_LEVELS
      parts.each do |p|
        errs << ERRS[:max_label_size] if p.size > MAX_LABEL_LENGTH
        errs << ERRS[:label_dash_begin] if p[0] == '-'
        errs << ERRS[:label_dash_end] if p[-1] == '-'
        errs << ERRS[:illegal_chars] unless p.match(/^[a-z0-9\-\_]+$/)
      end
      errs << ERRS[:top_numerical] if parts.last.match(/^[0-9]+$/)
      if parts.last.size < MIN_TLD_LENGTH || parts.last.size > MAX_TLD_LENGTH
        unless parts.last == 'arpa' ||
               parts.last == 'aero' ||
               parts.last == 'asia' ||
               parts.last == 'coop' ||
               parts.last == 'info' ||
               parts.last == 'jobs' ||
               parts.last == 'mobi' ||
               parts.last == 'museum' ||
               parts.last == 'name' ||
               parts.last == 'post' ||
               parts.last == 'travel' ||
               parts.last.match(/^xn--/)
          errs << ERRS[:bogus_tld]   
        end
      end
      errs << ERRS[:illegal_start] if parts.first[0] == '.'
    end

    errs.size == 0   # TRUE if valid, FALSE otherwise
  end

end

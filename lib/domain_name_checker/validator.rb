# The purpose of this class is to provide a simple capability for validating
# domain names represented in ASCII, a feature that seems to be missing from
# other more wide-ranging domain-related gems.

class DomainNameValidator

  MAX_DOMAIN_LENGTH = 253
  MAX_LABEL_LENGTH = 63
  MAX_LEVELS = 127
  MIN_LEVELS = 2

  ERR_MAX_DOMAIN_SIZE = 'Maximum domain length of 253 exceeded'
  ERR_MAX_LABEL_SIZE = 'Maximum domain label length of 63 exceeded'
  ERR_MAX_LEVEL_SIZE = 'Maximum domain level limit of 127 exceeded'
  ERR_MIN_LEVEL_SIZE = 'Minimum domain level limit of 2 not achieved'
  ERR_LABEL_DASH_BEGIN = 'No domain label may begin with a dash'
  ERR_LABEL_DASH_END = 'No domain label may end with a dash'
  ERR_TOP_NUMERICAL = 'The top-level domain (the extension) cannot be numerical'
  ERR_ILLEGAL_CHARS = 'Domain label contains an illegal character'

  # Validates the proper formatting of a normalized domain name, i.e. - a
  # domain that is represented in ASCII. Thus, international domain names are
  # supported and validated, if they have undergone the required IDN
  # conversion to ASCII. The validation rules are:
  #
  # 1. The maximum length of a domain name is 253 characters.
  # 2. A domain name is divided into "labels" seperated by periods. The maximum
  #    number of labels (including the top-level domain as a label) is 127.
  # 3. The maximum length of any label within a domain name is 63 characters.
  # 4. No label, including top-level domains, can begin or end with a dash.
  # 5. Top-level names cannot be all numeric.

  def validate(dn, errs = [])
    errs << ERR_MAX_DOMAIN_SIZE if dn.size > MAX_DOMAIN_LENGTH
    parts = dn.split('.')
    errs << ERR_MAX_LEVEL_SIZE if parts.size > MAX_LEVELS
    errs << ERR_MIN_LEVEL_SIZE if parts.size < MIN_LEVELS
    parts.each do |p|
      errs << ERR_MAX_LABEL_SIZE if p.size > MAX_LABEL_LENGTH
      errs << ERR_LABEL_DASH_BEGIN if p[0] == '-'
      errs << ERR_LABEL_DASH_END if p[-1] == '-'
      errs << ERR_ILLEGAL_CHARS unless p.match(/^[a-z0-9\-\_]+$/)
    end
    errs << ERR_TOP_NUMERICAL if parts.last.match(/^[0-9]+$/)

    errs.size == 0   # TRUE if valid, FALSE otherwise
  end

end

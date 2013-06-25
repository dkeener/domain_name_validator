require 'spec_helper'

describe DomainNameValidator do

  before(:each) do
    @validator = DomainNameValidator.new
  end

  describe 'Basic Validation' do

    it 'should pass a valid domain name' do
      response = @validator.validate('keenertech.com')
      response.should be == true
    end

    it 'should fail when it finds a numeric top-level extension' do
      response = @validator.validate('keenertech.123')
      response.should be == false
    end

    it 'should fail when the domain name max size is exceeded' do
      domain = "a"*250 + ".com"    # 254 chars; max is 253
      response = @validator.validate(domain)
      response.should be == false
    end

    it 'should fail when the max number of levels is exceeded' do
      domain = "a."*127 + "com"    # 128 levels; max is 127
      response = @validator.validate(domain)
      response.should be == false
    end

    it 'should fail when a label exceeds the max label length' do
      domain = "a"*64 + "b.c.com"    # 64 chars; max is 63 for a label
      response = @validator.validate(domain)
      response.should be == false
    end

    it 'should fail when a label begins with a dash' do
      domain = "a.-b.c.com"
      response = @validator.validate(domain)
      response.should be == false
    end

    it 'should fail when a TLD begins with a dash' do
      domain = "a.b.c.-com"
      response = @validator.validate(domain)
      response.should be == false
    end
  end

  describe 'Internationalized (normalized) domain names' do

    it 'should fail when a TLD begins with a dash' do
      domain = "xn--kbenhavn-54.eu"
      response = @validator.validate(domain)
      response.should be == true
    end

  end

  # TODO: (2013/06/24) TLD checking will be added soon....

  describe 'TLD Checking' do
  end

end

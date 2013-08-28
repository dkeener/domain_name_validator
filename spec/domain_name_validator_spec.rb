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

    it 'should pass a valid domain name with uppercase letters' do
      response = @validator.validate('KeenerTech.COM')
      response.should be == true
    end

    it 'should fail when it finds nil instead of a domain name' do
      response = @validator.validate(nil)
      response.should be == false
    end

    it 'should fail when it finds an empty string instead of a domain name' do
      response = @validator.validate("")
      response.should be == false
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

    it 'should fail when a domain name begins with a period' do
      domain = ".b.c.com"
      response = @validator.validate(domain)
      response.should be == false
    end
  end

  describe 'Internationalized (normalized) domain names' do

    it 'should pass with a normalized international domain name' do
      domain = "xn--kbenhavn-54.eu"
      response = @validator.validate(domain)
      response.should be == true
    end

  end

  describe 'Rudimentary TLD Checking' do

    it 'should fail if the TLD is too short' do
      domain = "test.a"
      response = @validator.validate(domain)
      response.should be == false
    end

    it 'should fail if the TLD is too long' do
      domain = "test.domain"
      response = @validator.validate(domain)
      response.should be == false
    end

    it "should succeed if the TLD is too long but equals 'aero'" do
      domain = "test.aero"
      response = @validator.validate(domain)
      response.should be == true
    end

    it "should succeed if the TLD is too long but equals 'info'" do
      domain = "test.info"
      response = @validator.validate(domain)
      response.should be == true
    end

    it "should succeed if the TLD is too long but equals 'arpa'" do
      domain = "test.arpa"
      response = @validator.validate(domain)
      response.should be == true
    end

    it "should succeed if the TLD is too long but equals 'museum'" do
      domain = "test.museum"
      response = @validator.validate(domain)
      response.should be == true
    end

    it "should succeed if the TLD is too long but matches 'xn--'" do
      domain = "test.xn--really-long-text"
      response = @validator.validate(domain)
      response.should be == true
    end

  end

end

require 'spec_helper'

describe DomainNameValidator do

  before(:each) do
    @validator = DomainNameValidator.new
  end


  describe 'Basic Validation' do

    it 'should pass valid a domain name' do
      response = @validator.validate('keenertech.com')
      response.should be == true
    end

    it 'should fail whenit finds a numeric top-level extension' do
      response = @validator.validate('keenertech.123')
      response.should be == false
    end
  end

end

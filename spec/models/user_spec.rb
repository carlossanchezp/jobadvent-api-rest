require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'email' do
    it "should be validate email" do
      expect(User.new(email: 'test1@test.org', password_digest:'test')).to be_valid
    end

    it 'should taken other email and be validate email' do
      expect(User.new(email: "other_wrong_email", password_digest:'test')).not_to be_valid
    end
  
    it 'should not be validate email' do    
      expect(User.new(email: 'test@test.org', password_digest:'test')).not_to be_valid
    end
  end
end

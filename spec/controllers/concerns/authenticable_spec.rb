RSpec.describe Authenticable, type: :controller do
  describe 'GET index' do

    before do
      @user = create :user
      @authentication = MockController.new
    end

    it 'when returns any resource for current user never buy' do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)
   
      expect(@authentication.current_user).not_to be nil  
      expect(@user.id).not_to be eq @authentication.current_user.id  

    end

    it 'should not get user from empty Authorization token' do
      @authentication.request.headers['Authorization'] = nil
      expect(@authentication.current_user).to be nil  
    end

       
  end


  class MockController 
    include Authenticable 
    attr_accessor :request

    def initialize
      mock_request = Struct.new(:headers) 
      self.request = mock_request.new({})
    end 
  end


end
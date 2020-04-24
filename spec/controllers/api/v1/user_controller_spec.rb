RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#update" do

    before do
      @user = create :user
      @user2 = create :user
      @request.headers["Authorization"] 

      @params = { user: 
                    { 
                      email: @user.email, 
                      password: '123456' 
                    } 
                }
    end  
    
    it 'should update user...' do
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @user.id)
      page.driver.put(api_v1_user_path(@user), @params)

      expect(page.status_code).to be 200
    end

    it 'should forbid update user...' do
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @user2.id)
      page.driver.put(api_v1_user_path(@user), @params)

      expect(page.status_code).to be 403
    end
  end

end

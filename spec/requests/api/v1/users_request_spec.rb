require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  before do
    #api_access
    @user = create :user
    @user2 = create :user
    @user3 = create :user
    @user4 = create :user
    @params = { user: 
                    { 
                      email: 'test@test.org', 
                      password: '123456' 
                    } 
              }
    @params_wrong = { user: 
                { 
                  email: 'test', 
                  password: '123456' 
                } 
          }
  end

  it 'should show user' do
    page.driver.header "Authorization", JsonWebToken.encode(user_id: @user.id)

    page.driver.get(api_v1_user_path(@user.id))
    
    data = JSON.parse(page.body)
    expect(page.status_code).to be(200) 
    expect(@user.email).to eq data["email"]
  end

  it 'should create user' do
    page.driver.post(api_v1_users_path, @params)

    expect(page.status_code).to be 201
  end

  it 'should not create user with taken a email' do
    page.driver.post(api_v1_users_path, @params_wrong)

    expect(page.status_code).to be 422
  end

  it 'should update user' do
    page.driver.header "Authorization", JsonWebToken.encode(user_id: @user3.id)
    page.driver.put(api_v1_user_path(@user3), { user: { email: @user3.email, password: '123456' } })

    expect(page.status_code).to be 200
  end

  it 'should not update user when invalid params are sent' do
    page.driver.header "Authorization", JsonWebToken.encode(user_id: @user3.id)
    page.driver.put(api_v1_user_path(@user3), { user: { email: 'bad_email', password: '123456' } })

    expect(page.status_code).to be 422
  end

  it 'should destroy a user' do
    page.driver.header "Authorization", JsonWebToken.encode(user_id: @user4.id)
    page.driver.delete(api_v1_user_path(@user4), { user: { email: @user4.email, password: '123456' } })

    expect(page.status_code).to be 204
  end

end

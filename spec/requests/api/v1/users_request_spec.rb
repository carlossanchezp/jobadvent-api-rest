require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  before do
    #api_access
    @user = create :user
    @user2 = create :user
    @user3 = create :user
    @user4 = create :user
  end

  it 'should show user' do
      page.driver.get(api_v1_user_path(@user.id))
      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)
      expect(page.status_code).to be(200)  
  end

  it 'should create user' do
    post api_v1_users_url, params: { user: { email: 'test@test.org', password: '123456' } }, as: :json     
    expect(response.status).to be 201
  end

  it 'should not create user with taken a email' do
    post api_v1_users_url, params: { user: { email: @user.email, password: '123456' } }, as: :json
    expect(response.status).to be 422
  end

  it 'should update user' do
    patch api_v1_user_url(@user3), params: { user: { email: @user.email, password: '123456' } }, as: :json 
    expect(response.status).to be 422
  end

  it 'should not update user when invalid params are sent' do
    patch api_v1_user_url(@user3), params: { user: { email:'bad_email', password: '123456' } }, as: :json
    expect(response.status).to be 422
  end

  it 'should destroy a user' do
    delete api_v1_user_url(@user4), as: :json    
    expect(response.status).to be 204
  end

end

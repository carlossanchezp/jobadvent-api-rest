require 'rails_helper'

RSpec.describe "Api::V1::Tokens", type: :request do
  before do
    #api_access
    @user = create :user
    @user2 = create :user
    @user3 = create :user
    @user4 = create :user
  end

  it "should get JWT token" do
    post api_v1_tokens_url, params: { user: { email: @user.email, password: 'g00d_pa$$' } }, as: :json    
    expect(response).to have_http_status(:success)
  end

  it "should not get JWT token" do
    post api_v1_tokens_url, params: { user: { email: @user.email, password: 'b@d_pa$$' } }, as: :json    
    expect(response).not_to have_http_status(:success)
  end

end

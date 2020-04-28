RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "#index" do
    before do
      @products = create_list(:product, 10)
      @request.headers["Authorization"] 
      @params = { user: 
                    { 
                      email: @products.first.user.email, 
                      password: '123456' 
                    } 
                }
    end  
    
    it 'should show a product...' do 
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @products.first.user.id)
      page.driver.get(api_v1_products_path, @params)

      expect(page.status_code).to be 200
    end
  end
 
 
  describe "#show" do
    before do
      @product = create :product
      @request.headers["Authorization"] 

      @params = { user: 
                    { 
                      email: @product.user.email, 
                      password: '123456' 
                    } 
                }
    end  
    
    it 'should show a product...' do
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @product.user.id)
      page.driver.get(api_v1_user_product_path(@product.user,@product), @params)

      expect(page.status_code).to be 200
    end
  end

  describe "#create" do
    before do
      @products = create_list(:product, 3)
      @request.headers["Authorization"] 
      @params = { 
                  product: { 
                    title: @products.first.title, 
                    price:@products.first.price, 
                    published: @products.first.published }
                }
    end  
    
    it 'should create a product...' do 
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @products.first.user.id)
      page.driver.post(api_v1_products_path, @params)

      expect(page.status_code).to be 201
    end

    it 'should create a product with other user...' do 
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @products.last.user.id)
      page.driver.post(api_v1_products_path, @params)
      expect(page.status_code).to be 201
    end

  end


  describe "#update" do
    before do
      @products = create_list(:product, 3)
      @request.headers["Authorization"] 
      @params = { 
                  product: { 
                    title: @products.first.title, 
                    price:@products.first.price, 
                    published: @products.first.published }
                }
    end  
    
    it 'should update a product...' do 
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @products.first.user.id)
      page.driver.put(api_v1_product_path(@products.first.id), @params)

      expect(page.status_code).to be 200
    end

    it 'should not update a product with other user...' do 
      page.driver.header "Authorization", JsonWebToken.encode(user_id: @products.last.user.id)
      page.driver.put(api_v1_product_path(@products.first.id), @params)
      
      expect(page.status_code).to be 403
    end

  end
end
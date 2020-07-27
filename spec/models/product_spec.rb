require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save sucessfully if all required fields are filled' do
      @category = Category.new(name: "Shoes")
      @product = Product.new ({
        name: 'Nike',
        description: 'These are shoes',
        category_id: @category,
        quantity: 1,
        image: nil,
        price: 13
    }
      )
      @product.save

      expect(@product).to be_present
    end 

    it "should show error 'Price is not a number' if price is nil" do
      @category = Category.new(name: "Shoes")
      @product = Product.new ({
        name: 'Nike',
        category_id: @category,
        quantity: 1,
        price: nil
    }
      )

      @product.save

      expect(@product.errors.full_messages).to include('Price is not a number')
    end

    it "should show error 'Name can't be blank' if name is nil" do
      @category = Category.new(name: "Shoes")
      @product = Product.new ({
        name: nil,
        category_id: @category,
        quantity: 1,
        price: 30
    }
      )

      @product.save
      
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should show error 'Quantity can't be blank' if quantity is nil" do
      @category = Category.new(name: "Shoes")
      @product = Product.new ({
        name: 'Nike',
        category_id: @category,
        quantity: nil,
        price: 13
    }
      )

      @product.save
      
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should show error 'Category can't be blank' if category is nil" do
      @category = Category.new(name: "Shoes")
      @product = Product.new ({
        name: 'Nike',
        category_id: nil,
        quantity: 1,
        price: 30
    }
      )

      @product.save
      
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

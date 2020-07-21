class Admin::DashboardController < ApplicationController
  def show
    @product = Product.count
    @catagory = Category.count
  end
end

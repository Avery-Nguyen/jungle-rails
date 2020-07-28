require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do

   # SETUP
   before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    user1 = User.create({
      first_name: "Bob",
      last_name: "Rob",
      email: "test@test.com",
      password: "123456",
      password_confirmation: "123456"
    })

  end

  scenario "They login in login page" do
    # ACT
    visit root_path
 
    page.find('a', :text => /\ALogin\z/).click
   

    # DEBUG / VERIFY
    
    expect(page).to have_content('Email:')
    page.find('input#email').set "test@test.com"
    page.find('input#password').set "123456"
    click_button 'Submit'

    expect(page).to have_content('Logout')
    
    save_screenshot
  end
end

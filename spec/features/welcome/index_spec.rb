require 'rails_helper'

RSpec.describe "Welcome Index" do
  it "welcomes" do
    visit root_path

    expect(page).to have_content("Welcome to Awesome Viewing Party!")
  end

  it "creates a new user" do
    visit root_path

    click_on "Register Here"

    expect(current_path).to eq(new_user_path)

    test_email = "idaolson@gmail.com"
    test_pass = "Bianca"
    test_name = "Ida"

    save_and_open_page
    fill_in 'user[name]', with: test_name
    fill_in 'user[email]', with: test_email
    fill_in 'user[password]', with: test_pass

    click_on "Register"

    expect(page).to have_content("Welcome to Viewing Party, #{test_name}!")
    expect(current_path).to eq(dashboard_index_path)
  end
end

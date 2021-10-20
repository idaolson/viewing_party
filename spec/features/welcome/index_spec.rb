require 'rails_helper'

RSpec.describe "Welcome Index" do
  it "welcomes" do
    visit root_path

    expect(page).to have_content("Welcome to Viewing Party!")
  end

  it "logs in existing user" do
    user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
    visit root_path

    expect(page).to have_field(:email)
    expect(page).to have_field(:password)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Welcome to Viewing Party, #{user.name}!")
  end

  it "doesn't allow login with bad credentials" do
    user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
    visit root_path

    fill_in :email, with: user.email
    fill_in :password, with: "Chibi"

    click_on "Log In"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Log in failed. Please try again.")
  end

  it 'allows a user to logout' do
    user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
    visit root_path

    expect(page).to have_field(:email)
    expect(page).to have_field(:password)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    visit root_path

    expect(page).to have_link('Log out')
    click_link 'Log out'

    expect(current_path).to eq(root_path)

    visit dashboard_index_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You must sign in or create an account to access site')
  end
end

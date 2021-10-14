require 'rails_helper'

RSpec.describe "User dashboard" do
  before :each do
    @user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
    @user2 = User.create!(name: "Kevin", email: "kevinmugele@gmail.com", password: "Colby")
    @user3 = User.create!(name: "Rachel", email: "rachelangela@gmail.com", password: "Cassio")
    @friendship1 = Friendship.create!(user_id: @user.id, friend_id: @user3.id)
    @event1 = Event.create!(user_id: @user.id, title: "Gladiator", day: "2021-10-10", time: "8:00:00", duration: 90)
    @event2 = Event.create!(user_id: @user2.id, title: "Mad Max Fury Road", day: "2021-12-10", time: "8:00:00", duration: 90)
    @invitation = Invitation.create!(event_id: @event2.id, user_id: @user.id)
    @invitation2 = Invitation.create!(event_id: @event2.id, user_id: @user3.id)
    @invitation3 = Invitation.create!(event_id: @event1.id, user_id: @user2.id)
    @invitation4 = Invitation.create!(event_id: @event1.id, user_id: @user3.id)

    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Log In"
  end

  it "welcomes user to the page" do
    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Welcome, #{@user.name}!")
  end

  it "has a link to the discover movies page" do
    expect(page).to have_button("Discover Movies")

    click_button "Discover Movies"

    expect(current_path).to eq(discover_path)
  end

  describe "has a friends section" do
    # it "displays that you have no friends" do
    #   within "#friends" do
    #     expect(page).to have_content("You currently have no friends.")
    #   end
    # end

    it "has a field to add a friend" do
      within "#friends" do
        expect(page).to have_field(:email)
        expect(page).to have_button("Add Friend")

        fill_in :email, with: @user2.email

        click_button "Add Friend"

        expect(page).to have_content(@user2.name)
      end
    end

    it "displays the user's friends" do
      within "#friends" do
        expect(page).to have_content(@user3.name)
      end
    end
  end

  it "shows user's upcoming viewing parties" do
    within "#events" do
      within "#host" do
        expect(page).to have_content(@event1.title)
        expect(page).to have_content(@event1.day)
        expect(page).to have_content(@event1.time)
        expect(page).to have_content("Hosting")
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@user3.name)
      end

      within "#invited" do
        expect(page).to have_content(@event2.title)
        expect(page).to have_content(@event2.day)
        expect(page).to have_content(@event2.time)
        expect(page).to have_content("Invited")
        expect(page).to have_content("Host: #{@user2.name}")
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user3.name)
      end
    end
  end
end

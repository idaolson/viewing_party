require 'rails_helper'

RSpec.describe "Movies Index page" do
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

  describe 'top rated movies' do
    it 'shows top rated movies' do
      visit movies_path
      #Need to find the proper way to test for stubbed API calls. Can we hardcode it?
      expect(page).to have_content("Cook With the Book")
    end
  end

  it "has a button for top rated movies" do
    visit movies_path

    expect(page).to have_button("Find Top Rated Movies")
    click_button("Find Top Rated Movies")

    expect(current_path).to eq(movies_path)
  end

  it 'has a search option to search for specific movies' do
    visit movies_path

    expect(page).to have_field("search")
    expect(page).to have_button("Find Movie")

    click_button("Find Movie")

    expect(current_path).to eq(movies_path)
  end

  it "searches for a user-entered movie title" do
    visit movies_path

    fill_in "search", with: "Die Hard"
    click_button("Find Movie")

    expect(current_path).to eq(movies_path)
    expect(page).to have_content("Die Hard")
    expect(page).to have_content("Die Hard 2")
    expect(page).to have_content("A Good Day to Die Hard")
    expect(page).to have_content("Live Free or Die Hard")
  end

  it "links each movie title to its show page" do
    visit movies_path

    fill_in "search", with: "Die Hard"
    click_button("Find Movie")

    expect(page).to have_link("Die Hard 2")

    click_link("Die Hard 2")

    expect(current_path).to eq(movie_path(1573))
  end
end

require 'rails_helper'

RSpec.describe "Movies Index page", :vcr do
  before :each do
    @user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
    @user2 = User.create!(name: "Kevin", email: "kevinmugele@gmail.com", password: "Colby")
    @user3 = User.create!(name: "Rachel", email: "rachelangela@gmail.com", password: "Cassio")
    @friendship1 = Friendship.create!(user_id: @user.id, friend_id: @user3.id)
    @event1 = Event.create!(user_id: @user.id, title: "Gladiator", day: "2021-10-10", time: "8:00:00", duration: 90, movie_id: 98)
    @event2 = Event.create!(user_id: @user2.id, title: "Mad Max Fury Road", day: "2021-12-10", time: "8:00:00", duration: 90, movie_id: 76341)
    @invitation2 = Invitation.create!(event_id: @event2.id, user_id: @user3.id)
    @invitation3 = Invitation.create!(event_id: @event1.id, user_id: @user2.id)
    @invitation4 = Invitation.create!(event_id: @event1.id, user_id: @user3.id)

    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Log In"

    visit movie_path(1573)
  end

  it "shows a movie's info" do
    expect(page).to have_content("Die Hard 2")
    expect(page).to have_content("2 hr 4 min")
    expect(page).to have_content(6.9)
    expect(page).to have_content("Off-duty cop John McClane is gripped with a feeling of déjà vu when, on a snowy Christmas Eve in the nation’s capital, terrorists seize a major international airport, holding thousands of holiday travelers hostage. Renegade military commandos led by a murderous rogue officer plot to rescue a drug lord from justice and are prepared for every contingency except one: McClane’s smart-mouthed heroics.")
    expect(page).to have_content("Action")
    expect(page).to have_content("Thriller")
  end

  it "shows a movie's cast info" do
    expect(page).to have_content("Bruce Willis")
    expect(page).to have_content("John McClane")
    expect(page).to have_content("Bonnie Bedelia")
    expect(page).to have_content("Holly McClane")
    expect(page).to have_no_content("Tom Bower")
    expect(page).to have_no_content("Marvin")
  end

  it "shows a movie's reviews" do
    expect(page).to have_content("talisencrw")
    expect(page).to have_content("Great fun re-watching this after checking out the original for the first time. One of the very best filmic franchises out there, to be sure.")
  end

  it "links to create a new viewing party" do
    expect(page).to have_button("Create Viewing Party for Movie")
    click_button("Create Viewing Party for Movie")
    expect(current_path).to eq(new_event_path)
  end
end

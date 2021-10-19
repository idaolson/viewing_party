require 'rails_helper'

RSpec.describe "events new page", :vcr do
  before :each do
    @user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
    @user2 = User.create!(name: "Kevin", email: "kevinmugele@gmail.com", password: "Colby")
    @user3 = User.create!(name: "Rachel", email: "rachelangela@gmail.com", password: "Cassio")
    @friendship1 = Friendship.create!(user_id: @user.id, friend_id: @user3.id)
    @event1 = Event.create!(user_id: @user.id, title: "Gladiator", day: "2021-10-10", time: "8:00:00", duration: 90, movie_id: 98)
    @event2 = Event.create!(user_id: @user2.id, title: "Mad Max Fury Road", day: "2021-12-10", time: "8:00:00", duration: 90, movie_id: 76341)
    @invitation = Invitation.create!(event_id: @event2.id, user_id: @user.id)
    @invitation2 = Invitation.create!(event_id: @event2.id, user_id: @user3.id)
    @invitation3 = Invitation.create!(event_id: @event1.id, user_id: @user2.id)
    @invitation4 = Invitation.create!(event_id: @event1.id, user_id: @user3.id)

    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Log In"

    visit movie_path(1573)
    click_button("Create Viewing Party for Movie")

  end

  it "has a form to create a new viewing party" do
    expect(page).to have_field(:duration)
    expect(page).to have_field(:date)
    expect(page).to have_field(:time)
    expect(page).to have_unchecked_field(:invitation[@user3.name])
    expect(page).to have_button("Create Viewing Party")

    fill_in :date, with: "2021/10/20"
    fill_in :time, with: "05:00 AM"
    check :invitation[@user3.name]
    click_button "Create Viewing Party"

    @user.reload

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Die Hard 2")
    expect(page).to have_content("10/20/2021")
    expect(page).to have_content("5:00 AM")
    expect(page).to have_content("Hosting")
    expect(page).to have_content(@user3.name)
  end

  it "sad path for new viewing party" do
    click_button "Create Viewing Party"

    expect(current_path).to eq(new_event_path)
    expect(page).to have_content("Viewing Party was not created. Try again.")
    expect(page).to have_field(:duration)
    expect(page).to have_field(:date)
    expect(page).to have_field(:time)
    expect(page).to have_unchecked_field(:invitation[@user3.name])
    expect(page).to have_button("Create Viewing Party")
  end
end

require 'rails_helper'

RSpec.describe "User dashboard", :vcr do
  before :each do
    @user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
    @user2 = User.create!(name: "Kevin", email: "kevinmugele@gmail.com", password: "Colby")
    @user3 = User.create!(name: "Rachel", email: "rachelangela@gmail.com", password: "Cassio")
    @event1 = Event.create!(user_id: @user.id, title: "Gladiator", day: "2021-10-10", time: "8:00:00", duration: 90, movie_id: 98)
    @event2 = Event.create!(user_id: @user2.id, title: "Mad Max Fury Road", day: "2021-12-10", time: "8:00:00", duration: 90, movie_id: 76341)
    @event3 = Event.create!(user_id: @user.id, title: "Die Hard 2", day: "2021-10-10", time: "8:00:00", duration: 90, movie_id: 1573)
    @invitation = Invitation.create!(event_id: @event2.id, user_id: @user.id)
    @invitation2 = Invitation.create!(event_id: @event2.id, user_id: @user3.id)
    @invitation3 = Invitation.create!(event_id: @event1.id, user_id: @user2.id)
    @invitation4 = Invitation.create!(event_id: @event1.id, user_id: @user3.id)
    @invitation5 = Invitation.create!(event_id: @event3.id, user_id: @user3.id)

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
    it "displays that you have no friends" do
      within "#friends" do
        expect(page).to have_content("You currently have no friends.")
      end
    end

    it "has a field to add a friend" do
      within "#friends" do
        expect(page).to have_field(:email)
        expect(page).to have_button("Add Friend")

        fill_in :email, with: @user2.email

        click_button "Add Friend"

        expect(page).to have_content(@user2.name)
      end
    end

    it "gives an error if friend doesn't exist" do
      within "#friends" do
        expect(page).to have_field(:email)
        expect(page).to have_button("Add Friend")

        fill_in :email, with: 'fake@gmail.com'

        click_button "Add Friend"
      end

    expect(page).to have_content("Friend not found.")
    expect(current_path).to eq(dashboard_index_path)
    end
  end

  it "shows user's upcoming viewing parties" do
    within "#events" do
      within "#host-#{@event1.id}" do
        expect(page).to have_content(@event1.title)
        expect(page).to have_content(@event1.day.strftime("%-m/%-d/%Y"))
        expect(page).to have_content(@event1.time.strftime("%l:%M %p"))
        expect(page).to have_content("Hosting")
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@user3.name)
      end

      within "#host-#{@event3.id}" do
        expect(page).to have_content(@event3.title)
        expect(page).to have_content(@event3.day.strftime("%-m/%-d/%Y"))
        expect(page).to have_content(@event3.time.strftime("%l:%M %p"))
        expect(page).to have_content("Hosting")
        expect(page).to have_content(@user3.name)
      end

      within "#invited-#{@event2.id}" do
        expect(page).to have_content(@event2.title)
        expect(page).to have_content(@event2.day.strftime("%-m/%-d/%Y"))
        expect(page).to have_content(@event2.time.strftime("%l:%M %p"))
        expect(page).to have_content("Invited")
        expect(page).to have_content("Host: #{@user2.name}")
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user3.name)
      end
    end
  end

  it "links to a movie's show page from viewing party" do
    within "#events" do
      within "#host-#{@event3.id}" do
        expect(page).to have_link(@event3.title)
        click_link @event3.title
      end
    end
    expect(current_path).to eq(movie_path(1573))
    expect(page).to have_content("Die Hard 2")
    expect(page).to have_content("2 hr 4 min")
    expect(page).to have_content(6.9)
    expect(page).to have_content("Off-duty cop John McClane is gripped with a feeling of déjà vu when, on a snowy Christmas Eve in the nation’s capital, terrorists seize a major international airport, holding thousands of holiday travelers hostage. Renegade military commandos led by a murderous rogue officer plot to rescue a drug lord from justice and are prepared for every contingency except one: McClane’s smart-mouthed heroics.")
    expect(page).to have_content("Action")
    expect(page).to have_content("Thriller")
  end
end

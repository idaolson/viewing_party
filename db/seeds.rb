# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Friendship.destroy_all
Event.destroy_all
Invitation.destroy_all
@user = User.create!(name: "Ida", email: "idaolson@gmail.com", password: "Bianca")
@user2 = User.create!(name: "Kevin", email: "kevinmugele@gmail.com", password: "Colby")
@user3 = User.create!(name: "Rachel", email: "rachelangela@gmail.com", password: "Cassio")
@friendship1 = Friendship.create!(user_id: @user.id, friend_id: @user3.id)
@event1 = Event.create!(user_id: @user.id, title: "Gladiator", day: "2021-10-10", time: "8:00:00", duration: 90, movie_id: 98)
@event2 = Event.create!(user_id: @user2.id, title: "Mad Max Fury Road", day: "2021-12-10", time: "8:00:00", duration: 90, movie_id: 76341)
@event3 = Event.create!(user_id: @user.id, title: "Die Hard 2", day: "2021-10-10", time: "8:00:00", duration: 90, movie_id: 1573)
@invitation = Invitation.create!(event_id: @event2.id, user_id: @user.id)
@invitation2 = Invitation.create!(event_id: @event2.id, user_id: @user3.id)
@invitation3 = Invitation.create!(event_id: @event1.id, user_id: @user2.id)
@invitation4 = Invitation.create!(event_id: @event1.id, user_id: @user3.id)
@invitation5 = Invitation.create!(event_id: @event3.id, user_id: @user3.id)

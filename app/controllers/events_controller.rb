class EventsController < ApplicationController
  def new
    @user = current_user
    @event = Event.new
    movie_facade = MovieFacade.new
    @movie = movie_facade.search_by_id(params[:movie_id])
  end

  def create
    @user = current_user
    @event = @user.events.new(movie_id: params[:movie_id], title: params[:movie_title], day: params[:date],
                              time: params[:time], duration: params[:duration])
    if @event.save
      if params['invitation']
        params['invitation'].each do |email, v|
          next unless v == '1'

          new_user = User.find_by(email: email)
          Invitation.create(user_id: new_user.id, event_id: @event.id)
        end
      end
      redirect_to dashboard_index_path
    else
      flash[:error] = 'Viewing Party was not created. Try again.'
      redirect_to new_event_path(movie_id: params[:movie_id])
    end
  end
end

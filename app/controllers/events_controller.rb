class EventsController < ApplicationController
  def new
    @user = current_user
    @event = Event.new
    movie_facade = MovieFacade.new
    @movie = movie_facade.search_by_id(params[:movie_id])
  end

  def create
    @user = current_user
    @event = @user.events.new(movie_id: params[:movie_id], title: params[:movie_title], day: params[:day], time: params[:time], duration: params[:duration])
    if @event.save
      params["invitation"].each do |k,v|
        next unless v == "1"
        new_user = User.find_by(email: k)
        Invitation.create(user_id: new_user.id, event_id: @event.id)
      end
      redirect_to dashboard_index_path
    else
      flash[:error] = "Viewing Party was not created. Try again."
      render :new
    end
  end
end

class EventsController < ApplicationController
  def index
    @trip = Trip.find_by_unique_id(params[:trip_id])
    @events = @trip.wcities_results.events.event

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end
end

class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.json
  def index
    @trip = Trip.find_by_unique_id(params[:trip_id])
    @activities = @trip.viator_results.body.data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    @trip = Trip.find_by_unique_id(params[:trip_id])
    @activity = @trip.activities.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @trip, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @trip = Trip.find_by_unique_id(params[:trip_id])
    @activity = @trip.activities.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to trip_url(@trip) }
      format.json { head :no_content }
    end
  end
end

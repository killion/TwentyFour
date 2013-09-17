require 'spec_helper'

describe "trips/edit" do
  before(:each) do
    @trip = assign(:trip, stub_model(Trip,
      :latitude => 1.5,
      :longitude => 1.5,
      :destination => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit trip form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", trip_path(@trip), "post" do
      assert_select "input#trip_latitude[name=?]", "trip[latitude]"
      assert_select "input#trip_longitude[name=?]", "trip[longitude]"
      assert_select "input#trip_destination[name=?]", "trip[destination]"
      assert_select "input#trip_user_id[name=?]", "trip[user_id]"
    end
  end
end

require 'spec_helper'

describe "trips/index" do
  before(:each) do
    assign(:trips, [
      stub_model(Trip,
        :latitude => 1.5,
        :longitude => 1.5,
        :destination => "Destination",
        :user_id => 1
      ),
      stub_model(Trip,
        :latitude => 1.5,
        :longitude => 1.5,
        :destination => "Destination",
        :user_id => 1
      )
    ])
  end

  it "renders a list of trips" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Destination".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

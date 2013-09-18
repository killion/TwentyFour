require 'spec_helper'

describe "activities/show" do
  before(:each) do
    @activity = assign(:activity, stub_model(Activity,
      :trip_id => 1,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Title/)
  end
end

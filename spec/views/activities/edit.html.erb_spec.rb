require 'spec_helper'

describe "activities/edit" do
  before(:each) do
    @activity = assign(:activity, stub_model(Activity,
      :trip_id => 1,
      :title => "MyString"
    ))
  end

  it "renders the edit activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", activity_path(@activity), "post" do
      assert_select "input#activity_trip_id[name=?]", "activity[trip_id]"
      assert_select "input#activity_title[name=?]", "activity[title]"
    end
  end
end

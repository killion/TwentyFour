require 'spec_helper'

describe "activities/new" do
  before(:each) do
    assign(:activity, stub_model(Activity,
      :trip_id => 1,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", activities_path, "post" do
      assert_select "input#activity_trip_id[name=?]", "activity[trip_id]"
      assert_select "input#activity_title[name=?]", "activity[title]"
    end
  end
end

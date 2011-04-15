require 'spec_helper'

describe "conferences/edit.html.erb" do
  before(:each) do
    @conference = assign(:conference, stub_model(Conference,
      :name => "MyString",
      :speaker => "MyString",
      :seats => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit conference form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => conferences_path(@conference), :method => "post" do
      assert_select "input#conference_name", :name => "conference[name]"
      assert_select "input#conference_speaker", :name => "conference[speaker]"
      assert_select "input#conference_seats", :name => "conference[seats]"
      assert_select "textarea#conference_description", :name => "conference[description]"
    end
  end
end

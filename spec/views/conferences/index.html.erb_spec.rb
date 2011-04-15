require 'spec_helper'

describe "conferences/index.html.erb" do
  before(:each) do
    assign(:conferences, [
      stub_model(Conference,
        :name => "Name",
        :speaker => "Speaker",
        :seats => 1,
        :description => "MyText"
      ),
      stub_model(Conference,
        :name => "Name",
        :speaker => "Speaker",
        :seats => 1,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of conferences" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Speaker".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

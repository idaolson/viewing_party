require 'rails_helper'

RSpec.describe "Welcome Index" do
  it "welcomes" do
    visit root_path

    expect(page).to have_content("HELLO AWESOME VIEWERS")
  end
end

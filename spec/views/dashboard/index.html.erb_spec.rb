# frozen_string_literal: true
require 'spec_helper'

describe 'dashboard/index.html.erb', type: :view do
  let(:join_date) { 5.days.ago }

  before do
    allow(view).to receive(:signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(stub_model(User, user_key: 'mjg'))
    assign(:user, stub_model(User, user_key: 'cam156', created_at: join_date))
    @ability = instance_double("Ability")
    allow(controller).to receive(:current_ability).and_return(@ability)
    allow(@ability).to receive(:can?).with(:admin_stats, User).and_return(false)
    assign(:followers, [])
    assign(:following, [])
    assign(:trophies, [])
    assign(:events, [])
    assign(:activity, [])
    assign(:notifications, [])
  end

  it "draws transfers" do
    render
    page = Capybara::Node::Simple.new(rendered)
    expect(page).to have_selector("#transfers.panel .panel-body .row .col-xs-12.col-sm-3 a", text: 'Select files to transfer')
    expect(page).to have_content "You haven't transferred any files"
    expect(page).to have_content "You haven't received any file transfer requests"
  end
end

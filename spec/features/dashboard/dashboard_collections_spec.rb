# frozen_string_literal: true
require 'feature_spec_helper'

include Selectors::Dashboard

describe 'Dashboard Collections:', type: :feature do
  let!(:jill_collection) { create(:collection, title: "Jill's Collection", depositor: jill.login) }
  let!(:collection)      { create(:collection, depositor: current_user.login) }

  let(:current_user) { create(:user) }
  let(:jill)         { create(:jill) }

  before do
    sign_in_with_js(current_user)
    go_to_dashboard_collections
  end

  specify 'tab title and buttons' do
    expect(page).to have_content("My Collections")
    within('#sidebar') do
      expect(page).to have_content("Upload")
      expect(page).to have_content("Create Collection")
    end
    expect(page).not_to have_selector(".batch-toggle input[value='Delete Selected']")
  end

  specify 'collections are displayed in the Collections list' do
    expect(page).to have_content collection.title
    expect(page).not_to have_content jill_collection.title
  end

  specify 'toggle displays additional information' do
    first('i.glyphicon-chevron-right').click
    expect(page).to have_content(collection.description)
    expect(page).to have_content(current_user)
  end

  specify 'additional information is hidden' do
    expect(page).not_to have_content(collection.description)
    expect(page).not_to have_content(current_user)
  end

  specify "toggle addtitional actions" do
    expect(page).not_to have_content("Edit Collection")
    expect(page).not_to have_content("Delete Collection")
    within('#documents') do
      first('.dropdown-toggle').click
    end
    expect(page).to have_content("Edit Collection")
    expect(page).to have_content("Delete Collection")
  end

  specify 'collections are not displayed in the File list' do
    go_to_dashboard_files
    expect(page).not_to have_content collection.title
  end

  describe 'facets,' do
    specify "displays the correct totals for each facet" do
      within("#facets") do
        click_link('Object Type')
        expect(page).to have_content('Collection (1)')
        click_link('Creator')
        expect(page).to have_content("#{collection.creator.first} (1)")
      end
    end
  end
end

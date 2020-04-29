# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Search form', type: :feature do
  scenario 'User visits home page' do
    visit '/'

    expect(page).to have_css('input[name="search"]')
    expect(page).to have_button('Search')
  end
end

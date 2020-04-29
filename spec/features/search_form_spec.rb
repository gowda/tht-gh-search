# frozen_string_literal: true

require 'rails_helper'

# Assumptions (support/mocks/octokit.rb)
# GitHub responds with 15 results for any query
# - each page has 10 queries
# - second page has no 'next'
# - first page has no 'prev'
RSpec.feature 'Search form', type: :feature do
  before(:each) { setup_octokit_mocks! }

  scenario 'User visits home page' do
    visit '/'

    expect(page).to have_css('input[name="q"]')
    expect(page).to have_button('Search')
  end

  scenario 'User submits blank form' do
    visit '/'
    click_on('Search')

    expect(page).to have_text('Please enter a search term')
    expect(page).to have_css('input[name="q"]')
    expect(page).to have_button('Search')
  end

  scenario 'User submits form with content' do
    visit '/'
    fill_in('search', with: 'rails')
    click_on('Search')

    expect(page).not_to have_text('Please enter a search term')
    expect(page).to have_css('input[name="q"][value="rails"]')
    expect(page).to have_content(/Found \d+ repositories on GitHub/)

    expect(page).to have_css('.repo.list-group-item', count: 10)
  end

  scenario 'First page of search results' do
    visit '/'
    fill_in('search', with: 'rails')
    click_on('Search')

    expect(page).to have_link('Next')
    expect(page).to have_link('Prev', class: 'disabled')
  end

  scenario 'Second page of search results' do
    visit '/'
    fill_in('search', with: 'rails')
    click_on('Search')
    click_link('Next')

    expect(page).to have_link('Next')
    expect(page).not_to have_link('Prev', class: 'disabled')
    expect(page).to have_link('Prev')
    expect(page).to have_css('.repo.list-group-item', count: 5)
  end

  scenario 'To first page from second page of search results' do
    visit '/'
    fill_in('search', with: 'rails')
    click_on('Search')
    click_link('Next')
    click_link('Prev')

    expect(page).to have_link('Next')
    expect(page).to have_link('Prev', class: 'disabled')
  end
end

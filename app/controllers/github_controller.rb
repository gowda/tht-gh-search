# frozen_string_literal: true

class GithubController < ApplicationController
  include GithubAccessor

  before_action :validate_query!, only: :search

  def index
  end

  def search
    @results = gh_search(params[:q], session.fetch(params[:page]) { nil })
    session[:next] = gh_next_page_url
    session[:prev] = gh_prev_page_url
  end

  private

  def validate_query!
    return true unless params[:q].blank?

    flash[:danger] = 'Please enter a search term'
    redirect_to action: :index
  end
end

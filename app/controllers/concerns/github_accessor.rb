# frozen_string_literal: true

module GithubAccessor
  include ActiveSupport::Concern

  def gh_client
    @gh_client ||= Octokit::Client.new(
      access_token: Rails.application.secrets.gh_access_token
    )
  end

  def gh_last_response
    @gh_last_response ||= gh_client.last_response
  end

  def gh_next_page_url
    gh_last_response.rels[:next]&.href
  end

  def gh_prev_page_url
    gh_last_response.rels[:prev]&.href
  end

  def gh_search(query, page)
    return gh_client.get(page) if page

    gh_client.search_repositories(query)
  end
end

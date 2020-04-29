# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength

module Mocks
  module Octokit
    Response = Struct.new(:rels)
    Rel = Struct.new(:href)
    Repo = Struct.new(
      :html_url,
      :full_name,
      :description,
      :forks,
      :stargazers_count,
      :open_issues_count,
      :watchers_count,
      :language,
      :updated_at,
      keyword_init: true
    )
    Result = Struct.new(:total_count, :items, keyword_init: true)

    def setup_octokit_mocks!
      mock_client = double('Mocks::Octokit::Client')

      mock_response_1 = Response.new({ next: Rel.new('next') })
      mock_response_2 = Response.new({ prev: Rel.new('prev') })
      allow(mock_client).to receive(:last_response).and_return(
        *[mock_response_1, mock_response_2].cycle.take(8)
      )

      mock_repos = 15.times.to_a.map do |i|
        Repo.new(
          html_url: '#',
          full_name: "owner-#{i}/repo-#{i}",
          description: "test description #{i}",
          forks: rand(100),
          stargazers_count: rand(1000),
          open_issues_count: rand(100),
          watchers_count: rand(100),
          language: ['ruby', 'javascript', nil].sample,
          updated_at: Time.now
        )
      end
      mock_results_1 = Result.new(
        total_count: mock_repos.length, items: mock_repos.take(10)
      )
      mock_results_2 = Result.new(
        total_count: mock_repos.length, items: mock_repos.drop(10)
      )
      allow(mock_client).to receive(:search_repositories)
        .and_return(mock_results_1)

      allow(mock_client).to receive(:get)
        .with('next').and_return(mock_results_2)
      allow(mock_client).to receive(:get)
        .with('prev').and_return(mock_results_1)

      mock_client_class = class_double('Octokit::Client').as_stubbed_const
      allow(mock_client_class).to receive(:new).and_return(mock_client)
    end
  end
end

RSpec.configure do |config|
  config.include Mocks::Octokit
end

# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

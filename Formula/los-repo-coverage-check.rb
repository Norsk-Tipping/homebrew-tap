class LosRepoCoverageCheck < Formula
  desc "Skanner alle GitHub-repoer i Norsk-Tipping-organisasjonen som eies av **Team LOS**"
  homepage "https://github.com/Norsk-Tipping/los-common-utilities"
  version "0.1.0"

  module GitHubHelper
    def self.token
      github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
      raise "HOMEBREW_GITHUB_API_TOKEN is not set" if github_token.nil? || github_token.empty?
      github_token
    end

    def self.release_asset_url(tag, name)
      require "json"
      require "net/http"
      require "uri"

      resp = Net::HTTP.get(
        URI.parse("https://api.github.com/repos/Norsk-Tipping/los-common-utilities/releases/tags/#{tag}"),
        {
"Accept" => "application/vnd.github+json",
"Authorization" => "Bearer #{token}",
"X-GitHub-Api-Version" => "2022-11-28"
        }
      )

      release = JSON.parse(resp)
      release["assets"].find { |asset| asset["name"] == name }["url"]
    end
  end

  url "#{GitHubHelper.release_asset_url("los-repo-coverage-check/v0.1.0", "los-repo-coverage-check-0.1.0.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "f621fd371f32fba10ef1539deb76f32414afc5d3ef3f22a2e7a1924391811277"

  def install
    bin.install "los-repo-coverage-check.sh" => "los-repo-coverage-check"
  end

  test do
    system "#{bin}/los-repo-coverage-check", "--help"
  end
end

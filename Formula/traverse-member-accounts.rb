class TraverseMemberAccounts < Formula
  desc "Dette skriptet kjører samme kommando som FORHØYET ADMINISTRATOR i alle kontoer i landingssonen."
  homepage "https://github.com/Norsk-Tipping/los-common-utilities"
  version "0.1.2"

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

  url "#{GitHubHelper.release_asset_url("traverseMemberAccounts/v0.1.2", "traverseMemberAccounts-0.1.2.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "8d83e2d3469792eabd65b15a89cda06d27912e55ee584a2cc36f3523cb9c3241"

  def install
    bin.install "templateTraverseAccounts.sh" => "traverseMemberAccounts"
  end

  test do
    system "#{bin}/traverseMemberAccounts", "--help"
  end
end

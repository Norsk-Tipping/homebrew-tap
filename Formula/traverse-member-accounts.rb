class TraverseMemberAccounts < Formula
  desc "Dette skriptet kjører samme kommando som FORHØYET ADMINISTRATOR i alle kontoer i landingssonen."
  homepage "https://github.com/Norsk-Tipping/los-common-utilities"
  version "0.1.3"

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

  url "#{GitHubHelper.release_asset_url("traverseMemberAccounts/v0.1.3", "traverseMemberAccounts-0.1.3.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "1059af2449633e4079b255956a1e5e4c0cc20ce7a5ba14023a00349f304435ed"

  def install
    bin.install "templateTraverseAccounts.sh" => "traverseMemberAccounts"
  end

  test do
    system "#{bin}/traverseMemberAccounts", "--help"
  end
end

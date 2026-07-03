class AwsCodepipelineStatus < Formula
  desc "Vis status for alle AWS CodePipelines i kontoen din, med fargekodet output, filtrering og watch-modus."
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

  url "#{GitHubHelper.release_asset_url("aws-codepipeline-status/v0.1.2", "aws-codepipeline-status-0.1.2.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "8c86983e5373694cc8cb04312f16265734baf4f02bf1e999d34cd9192c934b38"

  def install
    bin.install "aws-codepipeline-status" => "aws-codepipeline-status"
  end

  test do
    system "#{bin}/aws-codepipeline-status", "--help"
  end
end

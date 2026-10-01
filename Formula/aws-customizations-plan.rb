class AwsCustomizationsPlan < Formula
  desc "Kjør `terraform plan` lokalt mot AFT-tilpasninger (account customizations og global customizations) uten å pushe kode gjennom hele CI/CD-pipelinen."
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

  url "#{GitHubHelper.release_asset_url("aws-customizations-plan/v0.1.2", "aws-customizations-plan-0.1.2.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "f4a156b5fd34f7295a7d9e7ebeb908be26979684f3864d555dc9499f7d10e4b1"

  def install
    bin.install "" => "aws-customizations-plan"
  end

  test do
    system "#{bin}/aws-customizations-plan", "--help"
  end
end

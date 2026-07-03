class AwsCustomizationsRun < Formula
  desc "Trigger AFT (Account Factory for Terraform) customization-pipelines for valgte AWS-kontoer, med interaktiv kontovalg, OU-filtrering og fargekodet output."
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

  url "#{GitHubHelper.release_asset_url("aws-customizations-run/v0.1.0", "aws-customizations-run-0.1.0.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "a2248a7d7eab4569224d21c5421611d8e9f447920daabb4c388485af89dac91d"

  def install
    bin.install "aws-customizations-run" => "aws-customizations-run"
  end

  test do
    system "#{bin}/aws-customizations-run", "--help"
  end
end

class CheckCertificateSwitchInCloudFront < Formula
  desc "Hovedspørsmål:"
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

  url "#{GitHubHelper.release_asset_url("checkCertificateSwitchInCloudFront/v0.1.3", "checkCertificateSwitchInCloudFront-0.1.3.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "180949fa91418517a75d55d0cd51dbe2fa98abdefe92799f44236070aaaeaced"

  def install
    bin.install "checkCertificateSwitch.sh" => "checkCertificateSwitchInCloudFront"
  end

  test do
    system "#{bin}/checkCertificateSwitchInCloudFront", "--help"
  end
end

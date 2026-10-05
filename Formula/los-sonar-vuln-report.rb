class LosSonarVulnReport < Formula
  desc "Lager en prioritert rapport over åpne **SonarCloud-sårbarheter** (og uvurderte security hotspots) for Team LOS sine prosjekter: alle Sonar-prosjekter med taggene `devex`, `o11y` eller `landingzone`, gruppert på team via taggen."
  homepage "https://github.com/Norsk-Tipping/los-common-utilities"
  version "0.1.5"

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

  url "#{GitHubHelper.release_asset_url("los-sonar-vuln-report/v0.1.5", "los-sonar-vuln-report-0.1.5.tar.gz")}",
    headers: [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{GitHubHelper.token}",
      "X-GitHub-Api-Version: 2022-11-28"
    ]
  sha256 "7c3aa3d0a1f8885aa6f8548047642b887c5d0104a15c4fd82225e5739d690b6b"

  def install
    bin.install "" => "los-sonar-vuln-report"
  end

  test do
    system "#{bin}/los-sonar-vuln-report", "--help"
  end
end

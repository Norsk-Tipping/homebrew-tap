# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class GhaCli < Formula
  desc ""
  homepage ""
  version "1.0.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Norsk-Tipping/gha-cli/releases/download/v1.0.4/gha-cli-1.0.4-darwin-amd64.tar.gz"
      sha256 "e33e6a490fb8bbd11f57f08f8f4ed8e85ec94b0f22132ef7ded8af5c3bdc50a4"

      def install
        bin.install "gha-cli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Norsk-Tipping/gha-cli/releases/download/v1.0.4/gha-cli-1.0.4-darwin-arm64.tar.gz"
      sha256 "1860cf4565fcf0549d172738920c4185c7ff51fa98669d199ce4355596037525"

      def install
        bin.install "gha-cli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Norsk-Tipping/gha-cli/releases/download/v1.0.4/gha-cli-1.0.4-linux-arm64.tar.gz"
      sha256 "c7dbcc403ba8dd17ffd27727b50cce730966d6ebffda4cbe4a7b9e23d2824450"

      def install
        bin.install "gha-cli"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/Norsk-Tipping/gha-cli/releases/download/v1.0.4/gha-cli-1.0.4-linux-amd64.tar.gz"
      sha256 "f2bca472aa657697ac6a19df884dffb0c66e79a1157b4531a5376d916a7d2934"

      def install
        bin.install "gha-cli"
      end
    end
  end
end

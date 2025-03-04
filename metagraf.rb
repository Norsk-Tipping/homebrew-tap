# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Metagraf < Formula
  desc ""
  homepage ""
  version "0.1.25"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Norsk-Tipping/metagraf/releases/download/v0.1.25/mg-0.1.25-darwin-amd64.tar.gz"
      sha256 "a7f6a5a9a6bf028d372d226107fcd44f6bc809445bd7f90f4974fc3f258c944c"

      def install
        bin.install "mg"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Norsk-Tipping/metagraf/releases/download/v0.1.25/mg-0.1.25-darwin-arm64.tar.gz"
      sha256 "695b17636ec4ded2c732ce9533c774e59c09152b54ded230e3051b096130c135"

      def install
        bin.install "mg"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/Norsk-Tipping/metagraf/releases/download/v0.1.25/mg-0.1.25-linux-amd64.tar.gz"
        sha256 "0bf3718f22c1a96a80427f47431abc3adbcf2e22d5361661d7ad803fb998a8cf"

        def install
          bin.install "mg"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/Norsk-Tipping/metagraf/releases/download/v0.1.25/mg-0.1.25-linux-arm64.tar.gz"
        sha256 "71a2b5240d4e62a8ef97cff52f54e22c654a0df2e0e5c860724306c189f27b0d"

        def install
          bin.install "mg"
        end
      end
    end
  end
end

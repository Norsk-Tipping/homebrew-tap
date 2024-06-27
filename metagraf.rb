# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Metagraf < Formula
  desc ""
  homepage ""
  version "0.1.20"

  on_macos do
    url "https://github.com/Norsk-Tipping/metagraf/releases/download/v0.1.20/mg-0.1.20-darwin-amd64.tar.gz"
    sha256 "9a75a006753f666fb5e57126fa17693c453d0dcdcf7f108656949679b46bda58"

    def install
      bin.install "mg"
    end

    on_arm do
      def caveats
        <<~EOS
          The darwin_arm64 architecture is not supported for the Metagraf
          formula at this time. The darwin_amd64 binary may work in compatibility
          mode, but it might not be fully supported.
        EOS
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/Norsk-Tipping/metagraf/releases/download/v0.1.20/mg-0.1.20-linux-amd64.tar.gz"
        sha256 "33db2ac1929f95115ca91684dd8162023114ce945ffb60eef070c3fafc61af4e"

        def install
          bin.install "mg"
        end
      end
    end
  end
end

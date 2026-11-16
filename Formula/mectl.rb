class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.15.1"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.15.1/mectl_0.15.1_darwin_arm64.tar.gz"
      sha256 "43aef5e3cc61b76620f6806f181f8e3d33e05e63d0f547c0c414606e6d8fba8f"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.15.1/mectl_0.15.1_darwin_amd64.tar.gz"
      sha256 "518a950a35850c5842aabeb9c38297396bfa482fa02bc85c56926ff907bd44b7"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.15.1/mectl_0.15.1_linux_amd64.tar.gz"
      sha256 "a62b1355788e385ef07ce444b6f01cd58b160cdf8bca76a17b0f6855cf9f798d"
    end
  end

  def install
    supported = (OS.mac? && (Hardware::CPU.arm? || Hardware::CPU.intel?)) ||
                (OS.linux? && Hardware::CPU.intel?)
    odie "mectl supports macOS arm64/amd64 and Linux amd64 only" unless supported
    bin.install "mectl"
		doc.install "THIRD_PARTY_NOTICES.txt"
  end

  test do
    ENV["HOME"] = testpath.to_s
    ENV["XDG_CONFIG_HOME"] = (testpath/"config").to_s
    assert_equal "mectl version #{version}", shell_output("#{bin}/mectl version").lines.first.chomp
		assert_path_exists doc/"THIRD_PARTY_NOTICES.txt"
		refute_empty (doc/"THIRD_PARTY_NOTICES.txt").read
  end
end

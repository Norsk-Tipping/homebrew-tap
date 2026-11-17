class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.16.0"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.16.0/mectl_0.16.0_darwin_arm64.tar.gz"
      sha256 "a5d19323a5a2330c2a42e8a6cb81e8c32bd3c9b157ac2dca52bc7f5ba9eaedde"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.16.0/mectl_0.16.0_darwin_amd64.tar.gz"
      sha256 "05ad1efaa3ff57117132f0745201f6879cb4f57957a2e774026db105f8b27298"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.16.0/mectl_0.16.0_linux_amd64.tar.gz"
      sha256 "384848a17daaf08479d255add42ade5289ead3b81b06ede028c37b9624592d9a"
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

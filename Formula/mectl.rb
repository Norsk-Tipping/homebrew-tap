class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.14.1"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.14.1/mectl_0.14.1_darwin_arm64.tar.gz"
      sha256 "646db722a09b6c88291535df30dd7f6a3dba9f6c00a976a0348f0d62e8423d77"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.14.1/mectl_0.14.1_darwin_amd64.tar.gz"
      sha256 "a8bd51d3c8826b703d2a7614c36ac44c15e5186472e30ed9c62a866f8279c17f"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.14.1/mectl_0.14.1_linux_amd64.tar.gz"
      sha256 "8e5a88e10e2a8b07bd42a759a6bb73f461a0dba248864f37eb55301a19954237"
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

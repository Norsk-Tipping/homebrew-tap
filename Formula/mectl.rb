class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.13.0"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.13.0/mectl_0.13.0_darwin_arm64.tar.gz"
      sha256 "fc0a50f6762a55d31e4adbd9bfc897ed17badb9dade10ee8ac2d5f7dbc6e40d0"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.13.0/mectl_0.13.0_darwin_amd64.tar.gz"
      sha256 "718e7477be9183e0e2003ee26025465e5d13f5d13dc9d148fbe61c675a46a7ba"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.13.0/mectl_0.13.0_linux_amd64.tar.gz"
      sha256 "9d027e00ece5b2d09d89342173af7dacce77bc5f6ab259a0641c0980a5692940"
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

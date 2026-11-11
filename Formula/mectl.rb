class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.12.0"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.12.0/mectl_0.12.0_darwin_arm64.tar.gz"
      sha256 "fea3a15b38b3f18c48a8cf294fe26b76c85e947856d654232461912dd7aa80f3"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.12.0/mectl_0.12.0_darwin_amd64.tar.gz"
      sha256 "fd485506592c19835d90194910e0d5b4a6ab0b9ddedd3baf6f4324f0806716d0"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.12.0/mectl_0.12.0_linux_amd64.tar.gz"
      sha256 "8ea76496cef82a6b52e761132d198d3104bd95e096d214423516e973379908c8"
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

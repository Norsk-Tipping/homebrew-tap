class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.11.0"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.11.0/mectl_0.11.0_darwin_arm64.tar.gz"
      sha256 "291574caa17d03d815c42564b2f30870e72a1968dbf3bf636509ae41ff6077fd"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.11.0/mectl_0.11.0_darwin_amd64.tar.gz"
      sha256 "9579bee66939965f08322172f24ba216f4aaeffc99b4e3db0598cb631fc38d34"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.11.0/mectl_0.11.0_linux_amd64.tar.gz"
      sha256 "eea23f3ef1831f34c84b13c519fe7b94fec125721f5a8b4301291cbe26e416d9"
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

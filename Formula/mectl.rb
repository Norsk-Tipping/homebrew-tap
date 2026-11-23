class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.16.1"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.16.1/mectl_0.16.1_darwin_arm64.tar.gz"
      sha256 "d1c202c42a7dd7382bd9069cf96cbad28fd7056cb78adaab8bc2ff0d0dc2ad52"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.16.1/mectl_0.16.1_darwin_amd64.tar.gz"
      sha256 "470dd2dc86ee81be633121291295103f513f79fcabcedfcf4b06708039d54d7d"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.16.1/mectl_0.16.1_linux_amd64.tar.gz"
      sha256 "8b5e05960db0d6b1a17d1b5447ce70b8c4e9e36f3e557739b1ebfa3ea4da0357"
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

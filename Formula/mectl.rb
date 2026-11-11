class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.10.16"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.16/mectl_0.10.16_darwin_arm64.tar.gz"
      sha256 "5c07815c855d4542895035fabe0603b4bb3290f8f3f0f6c34451938536c817fe"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.16/mectl_0.10.16_darwin_amd64.tar.gz"
      sha256 "565fae0d25850b369930332677d294d430f3ba779d153d5173d3aed93f9a94e1"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.16/mectl_0.10.16_linux_amd64.tar.gz"
      sha256 "4ba723e4be019bd60827e670f3f67651ab44eabdb38445f47760c3d538df7f05"
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

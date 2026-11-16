class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.14.0"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.14.0/mectl_0.14.0_darwin_arm64.tar.gz"
      sha256 "1fb5d7a859c4ae0c1fde9b085fdec921bcf46be6160c18c98da749654246d22f"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.14.0/mectl_0.14.0_darwin_amd64.tar.gz"
      sha256 "3e1d7cee0797fb86454629bb6202bdb1ada420672ead7b2940e276f52341ec70"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.14.0/mectl_0.14.0_linux_amd64.tar.gz"
      sha256 "f74199dfa27e87759f4f0aa6a70e5ba5212d6836ac1b5f1781bad55a023e6bc5"
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

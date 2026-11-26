class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.17.0"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.17.0/mectl_0.17.0_darwin_arm64.tar.gz"
      sha256 "45d8716e32a60f3e2aa063655cbdf09d6e6752fdf8372fad31d0c10ccb6c6d89"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.17.0/mectl_0.17.0_darwin_amd64.tar.gz"
      sha256 "c952f5b7e6a8e0d8c931933da15d82da300c76e1de8b90fbd5e144d75c731308"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.17.0/mectl_0.17.0_linux_amd64.tar.gz"
      sha256 "326428f31092bcbbd88420b90297d1b7585af74ba2fcdd94e967fa9a7e199838"
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

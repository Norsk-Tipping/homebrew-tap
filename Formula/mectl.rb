class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.10.15"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.15/mectl_0.10.15_darwin_arm64.tar.gz"
      sha256 "5951b67ad1546859888b1a5fa221a1e9283b1c526d9af1e65eb5afbb0fa986cb"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.15/mectl_0.10.15_darwin_amd64.tar.gz"
      sha256 "0a5e0bbf0bf807304f34c63c1fc7d3b22ace976f1b5294900f71228824c3a5d8"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.15/mectl_0.10.15_linux_amd64.tar.gz"
      sha256 "ff1cc7d6bd056d11cc85900c4d7ccf0115e3061f823038a244c1a35db8d99545"
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

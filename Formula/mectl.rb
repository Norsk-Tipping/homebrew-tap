class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.10.13"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.13/mectl_0.10.13_darwin_arm64.tar.gz"
      sha256 "4234104848f82b353a585a3a210e1c333b49196e8e26a446d8c4a12abfcb5045"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.13/mectl_0.10.13_darwin_amd64.tar.gz"
      sha256 "b4592e833d6eba377cf340eb287ec061739206e302933e24e0ccdf9aecbbc006"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.13/mectl_0.10.13_linux_amd64.tar.gz"
      sha256 "96fdad8d2788df7eac59b3136c82d619c7a95fa892aa27a8d614fbe9a44081d3"
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

class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.10.14"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.14/mectl_0.10.14_darwin_arm64.tar.gz"
      sha256 "3c55a5f6a685cd49553ba0e48f3314c1696ecd0abee6ae09a99567b0584844b7"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.14/mectl_0.10.14_darwin_amd64.tar.gz"
      sha256 "7b4f44db781c8eb458295983e5f13651b2a9e311c48ff970b70af3c88a9ef727"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.14/mectl_0.10.14_linux_amd64.tar.gz"
      sha256 "02ff8ce22dbf055812515d3735980244318592ccffe460c0e609ac0834b83660"
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

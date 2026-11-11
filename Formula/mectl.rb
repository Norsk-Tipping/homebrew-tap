class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.11.1"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.11.1/mectl_0.11.1_darwin_arm64.tar.gz"
      sha256 "cb1e2095eca6396e662ba05aaca759cb9732fca06ce8ea5cc552486224733a59"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.11.1/mectl_0.11.1_darwin_amd64.tar.gz"
      sha256 "88fe99d09712b46131548b5c6221e9e76fcbafff09b12046084c47bc403370cc"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.11.1/mectl_0.11.1_linux_amd64.tar.gz"
      sha256 "a6b241ab8a9166c58ce6d8811a628f2d54979f63be7c552a1d5cd9bf1fe1e560"
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

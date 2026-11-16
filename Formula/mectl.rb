class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.15.2"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.15.2/mectl_0.15.2_darwin_arm64.tar.gz"
      sha256 "606eeaee5c4f66074b8eab6780131d5980248214e17a8349d86fb08196b125e9"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.15.2/mectl_0.15.2_darwin_amd64.tar.gz"
      sha256 "d547b1c915ce794527a273ad7a1cecab93f2940c936aebb6d29ecbfcb5a06601"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.15.2/mectl_0.15.2_linux_amd64.tar.gz"
      sha256 "be1054300ef1abd9edbc57e9600bf86b16d1fcfa55a5771669a316a360d219e9"
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

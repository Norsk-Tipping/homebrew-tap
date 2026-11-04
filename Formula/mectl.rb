class Mectl < Formula
  desc "MiddlEarth command-line client"
  homepage "https://github.com/janfonas/mectl-releases"
  version "0.10.12"

  on_macos do
    on_arm do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.12/mectl_0.10.12_darwin_arm64.tar.gz"
      sha256 "f405e034bc154389651f447d346c24ccefc8fa3e2120bf6e6d20ce06b3bd171e"
    end
    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.12/mectl_0.10.12_darwin_amd64.tar.gz"
      sha256 "2cf96c8b2973bdeb00c354c14b8b078aa9de1e862fa5853c23121d8757d8f571"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/janfonas/mectl-releases/releases/download/v0.10.12/mectl_0.10.12_linux_amd64.tar.gz"
      sha256 "9c019a82abb99c01de6b7396ae7171b16f6c3c6691335e6113ba6bf7e1706805"
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

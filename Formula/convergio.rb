class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "5.0.0"
  license "MIT"

  on_macos do
    on_arm do
      # Note: Tarball uses arm64-apple-darwin naming convention (not darwin-arm64)
      url "https://github.com/Roberdan/convergio-cli/releases/download/v5.0.0/convergio-5.0.0-arm64-apple-darwin.tar.gz"
      sha256 "86f74a89a835ca34f483e50a76f64548b0887a4bb12ef6d0b50dfac48530fbb9"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio"
  end

  def caveats
    <<~EOS
      Convergio has been installed!

      To get started, run:
        convergio setup

      This will configure your Anthropic API key securely in macOS Keychain.

      Quick start:
        convergio              # Start interactive session with Ali
        convergio --help       # Show all options
        convergio update       # Check for and install updates

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio --version")
  end
end

class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "3.0.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v3.0.11/convergio-3.0.11-darwin-arm64.tar.gz"
      sha256 "f028602b2c2f0a9bb65a97f77359fd4bcd75ee20d6e89e178d744295995f32c4"
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

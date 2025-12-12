class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "3.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v3.0.0/convergio-3.0.0-arm64-apple-darwin.tar.gz"
      sha256 "2d6617a9af0efb74d1fd124da9e9163f5a18759f204c3f30fb22c48d5966e9a5"
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

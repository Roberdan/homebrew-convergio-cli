class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.0.0/convergio-6.0.0-arm64-apple-darwin.tar.gz"
      sha256 "24995873794356027154c53048be562cf0e06161475c1e6914e5a6ff3573e8b1"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio"
    # Install Metal shaders for GPU acceleration
    if File.exist?("default.metallib")
      (share/"convergio").install "default.metallib"
    end
  end

  def caveats
    <<~EOS
      Convergio v6.0.0 has been installed!

      To get started, run:
        convergio setup

      This will configure your API keys securely in macOS Keychain.

      Quick start:
        convergio              # Start interactive session with Ali
        convergio --help       # Show all options
        convergio update       # Check for updates

      Other editions available:
        convergio-edu          # Education Edition (Scuola 2026)
        convergio-biz          # Business Edition
        convergio-dev          # Developer Edition

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio --version")
  end
end

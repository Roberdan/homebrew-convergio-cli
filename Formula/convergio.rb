class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "5.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v5.0.0/convergio-5.0.0-arm64-apple-darwin.tar.gz"
      sha256 "5133cf7e1c10f4052e6efcebec2179e1355d88c59858b67f621bdb89843f2faf"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio"
  end

  def caveats
    <<~EOS
      Convergio v5.0.0 has been installed!

      NEW IN v5.0.0:
        - Anna Executive Assistant with native todo management
        - MLX Local AI for 100% offline inference
        - MCP integration for extensible tools
        - Latest AI models (Dec 2025)

      To get started, run:
        convergio setup

      This will configure your API keys securely in macOS Keychain.

      Quick start:
        convergio              # Start interactive session with Ali
        convergio --local      # Use local AI (no API needed)
        convergio --help       # Show all options

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio --version")
  end
end

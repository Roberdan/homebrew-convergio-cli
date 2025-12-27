class ConvergioBiz < Formula
  desc "Convergio Business Edition - AI agents for sales, marketing & strategy"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.3.0/convergio-biz-6.3.0-arm64-apple-darwin.tar.gz"
      sha256 "12fbfc38d7bddccfcb7cf5262f6cb4e01ff794a163df5fb8a371a2bb47352285"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-biz"
  end

  def caveats
    <<~EOS
      Convergio Business has been installed!

      To get started, run:
        convergio-biz setup

      This will configure your Anthropic API key securely.

      Features:
        - 10 business-focused AI agents
        - Sales & pipeline management (Fabio)
        - Customer success (Andrea)
        - Marketing strategy (Sofia)
        - Market analysis (Fiona)
        - Financial planning (Amy CFO)

      Quick start:
        convergio-biz              # Start interactive session
        convergio-biz --help       # Show all options

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio-biz --version")
  end
end

class ConvergioBiz < Formula
  desc "Convergio Business Edition - AI agents for sales, marketing & strategy"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.2.0/convergio-biz-6.2.0-arm64-apple-darwin.tar.gz"
      sha256 "841948547c57b0a3165822950032ef525311686552847661c2adba35cbf4d9fc"
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

class ConvergioDev < Formula
  desc "Convergio Developer Edition - AI agents for code review, DevOps & security"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.3.0/convergio-dev-6.3.0-arm64-apple-darwin.tar.gz"
      sha256 "980de92edd98cdb617fe11a3df31d758cca8854f5028dd509b1a45cda0be983d"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-dev"
  end

  def caveats
    <<~EOS
      Convergio Developer has been installed!

      To get started, run:
        convergio-dev setup

      This will configure your Anthropic API key securely.

      Features:
        - 11 developer-focused AI agents
        - Code review (Rex)
        - Best practices enforcement (Paolo)
        - Architecture design (Baccio)
        - Debugging assistance (Dario)
        - Performance optimization (Otto)
        - DevOps & CI/CD (Marco)
        - Security analysis (Luca)

      Quick start:
        convergio-dev              # Start interactive session
        convergio-dev --help       # Show all options

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio-dev --version")
  end
end

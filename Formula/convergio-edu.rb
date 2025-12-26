class ConvergioEdu < Formula
  desc "Convergio Education Edition - AI Maestri teachers for K-12 students"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.1.0/convergio-edu-6.1.0-arm64-apple-darwin.tar.gz"
      sha256 "fa54e64344e678652324082de0f1d27a1573007aa38161a102a7affddd637a7f"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-edu"
  end

  def caveats
    <<~EOS
      Convergio Education has been installed!

      To get started, run:
        convergio-edu setup

      This will configure your Azure OpenAI API key (GDPR-compliant).

      Features:
        - 17 AI Maestri teachers (Math, Physics, History, etc.)
        - Socratic teaching methodology
        - Age-appropriate content (6-19 years)
        - GDPR-compliant (Azure OpenAI only)

      Quick start:
        convergio-edu              # Start interactive session
        convergio-edu --help       # Show all options

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio-edu --version")
  end
end

class ConvergioEdu < Formula
  desc "Convergio Education Edition - AI Maestri teachers for K-12 students"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.3.0/convergio-edu-6.3.0-arm64-apple-darwin.tar.gz"
      sha256 "e0a9f2089fc86e6577c0eebd966386358fff1e748744bdef768c14ce26a7da0b"
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

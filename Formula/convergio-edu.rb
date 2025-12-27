class ConvergioEdu < Formula
  desc "Convergio Education Edition - AI Maestri teachers for K-12 students"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.4.0/convergio-edu-6.4.0-arm64-apple-darwin.tar.gz"
      sha256 "8c13e2a3d572836fba7f784a7c622f46dc83e506f4420b252379747cf1f66aac"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-edu"
    # Install Metal libraries for MLX local models
    if File.exist?("mlx.metallib")
      bin.install "mlx.metallib"
    end
    if File.exist?("default.metallib")
      bin.install "default.metallib"
    end
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

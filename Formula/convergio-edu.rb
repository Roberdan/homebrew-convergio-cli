class ConvergioEdu < Formula
  desc "Convergio Education Edition - AI Maestri teachers for K-12 students"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.4.1/convergio-edu-6.4.1-arm64-apple-darwin.tar.gz"
      sha256 "463642eca855d0d9f2c2e6dd0286ca723d035f299aae150ea11cf5d787cf8eaf"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-edu"
    # Install Metal libraries to shared lib directory
    # This allows multiple editions to coexist without conflicts
    (lib/"convergio").mkpath
    # MLX Metal libraries (for local LLM inference)
    if File.exist?("mlx.metallib")
      (lib/"convergio").install "mlx.metallib"
    end
    if File.exist?("default.metallib")
      (lib/"convergio").install "default.metallib"
    end
    # NOUS Metal shaders (for GPU-accelerated similarity search)
    if File.exist?("similarity.metallib")
      (lib/"convergio").install "similarity.metallib"
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

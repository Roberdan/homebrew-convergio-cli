class ConvergioBiz < Formula
  desc "Convergio Business Edition - AI agents for sales, marketing & strategy"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.4.1/convergio-biz-6.4.1-arm64-apple-darwin.tar.gz"
      sha256 "53bc3d21f014bcd47bff12cea6a8dde23451f1aeb0e4b323abee900cc7729203"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-biz"
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

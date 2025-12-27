class ConvergioBiz < Formula
  desc "Convergio Business Edition - AI agents for sales, marketing & strategy"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.4.0/convergio-biz-6.4.0-arm64-apple-darwin.tar.gz"
      sha256 "3d2f9871308ffffb89323c14096dd9e8a26b79e268c4ee2fc3dfd99062f51cfc"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-biz"
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

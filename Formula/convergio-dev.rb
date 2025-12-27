class ConvergioDev < Formula
  desc "Convergio Developer Edition - AI agents for code review, DevOps & security"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.4.0/convergio-dev-6.4.0-arm64-apple-darwin.tar.gz"
      sha256 "10d9a8f764edd11df761e447e1353c0ad036314b0b7e61a02ef885d7fc87ee6d"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio-dev"
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

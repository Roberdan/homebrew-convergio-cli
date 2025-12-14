class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  url "https://github.com/Roberdan/convergio-cli/archive/refs/tags/v5.0.0.tar.gz"
  sha256 "b4ffb38b3317630e2665b382177f0945e815a2ca938c46487fa8712018013dad"
  license "MIT"
  head "https://github.com/Roberdan/convergio-cli.git", branch: "main"

  depends_on :macos
  depends_on arch: :arm64
  depends_on "cjson"
  depends_on "readline"
  depends_on xcode: ["16.0", :build]

  def install
    system "make", "clean"
    system "make"
    bin.install "build/bin/convergio"
    # Install metal library if present
    lib.install "build/bin/default.metallib" if File.exist?("build/bin/default.metallib")
  end

  def caveats
    <<~EOS
      Convergio v5.0.0 has been installed!

      NEW IN v5.0.0:
        - Anna Executive Assistant with native todo management
        - MLX Local AI for 100% offline inference
        - MCP integration for extensible tools
        - Latest AI models (Dec 2025)

      To get started, run:
        convergio setup

      Quick start:
        convergio              # Start interactive session with Ali
        convergio --local      # Use local AI (no API needed)
        convergio --help       # Show all options

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio --version")
  end
end

class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.0.2/convergio-6.0.2-arm64-apple-darwin.tar.gz"
      sha256 "392341d26046e6dfaae37688dceeeb80246dd7e455abc713ea6bb2141dde556e"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio"
    # Install notification helper app if included in release
    if File.directory?("ConvergioNotify.app")
      prefix.install "ConvergioNotify.app"
    end
  end

  def post_install
    # Symlink notification helper to /Applications for system-wide access
    notify_app = prefix/"ConvergioNotify.app"
    if notify_app.exist?
      target = Pathname.new("/Applications/ConvergioNotify.app")
      target.rmtree if target.exist?
      FileUtils.cp_r(notify_app, target)
      # Register with Launch Services
      system "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister", "-f", target
    end
  end

  def caveats
    <<~EOS
      Convergio has been installed!

      To get started, run:
        convergio setup

      This will configure your Anthropic API key securely in macOS Keychain.

      Quick start:
        convergio              # Start interactive session with Ali
        convergio --help       # Show all options
        convergio update       # Check for and install updates

      Notifications:
        The notification helper (ConvergioNotify.app) has been installed to
        /Applications for reminder notifications with the Convergio icon.
        You may need to allow notifications in System Settings > Notifications.

      Documentation: https://github.com/Roberdan/convergio-cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/convergio --version")
  end
end

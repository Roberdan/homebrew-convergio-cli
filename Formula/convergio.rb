class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.3.0/convergio-6.3.0-arm64-apple-darwin.tar.gz"
      sha256 "6e92025d2cc66b9b10a8e12848ccc6def7e9cad35f8efd54111cea35c3941cca"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio"
    # Install Metal libraries for MLX local models
    if File.exist?("mlx.metallib")
      bin.install "mlx.metallib"
    end
    if File.exist?("default.metallib")
      bin.install "default.metallib"
    end
    # Install notification helper app if included in release
    if File.directory?("ConvergioNotify.app")
      prefix.install "ConvergioNotify.app"
    end
  end

  def post_install
    # Symlink notification helper to /Applications for system-wide access
    notify_app = prefix/"ConvergioNotify.app"
    if notify_app.exist?
      begin
        target = Pathname.new("/Applications/ConvergioNotify.app")
        # Remove existing if present (may require permissions)
        if target.exist?
          FileUtils.rm_rf(target) rescue nil
        end
        # Copy to /Applications
        FileUtils.cp_r(notify_app, target) rescue nil
        # Register with Launch Services if copy succeeded
        if target.exist?
          system "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister", "-f", target
        end
      rescue => e
        opoo "Could not install ConvergioNotify.app to /Applications: #{e.message}"
        opoo "You can manually copy it from #{notify_app}"
      end
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

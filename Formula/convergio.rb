class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.1.0/convergio-6.1.0-arm64-apple-darwin.tar.gz"
      sha256 "3351da35c27187721a66879ba701d7f686a55735b3fb5cd223c7af9b63bf8e52"
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

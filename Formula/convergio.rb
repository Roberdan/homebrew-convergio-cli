class Convergio < Formula
  desc "Multi-agent AI orchestration CLI for Apple Silicon"
  homepage "https://github.com/Roberdan/convergio-cli"
  version "6.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Roberdan/convergio-cli/releases/download/v6.4.1/convergio-6.4.1-arm64-apple-darwin.tar.gz"
      sha256 "73cac91f9b68c57302786ca80d5a9c028eac21fbbe4ba5b90351b37fa4acf2d9"
    end
  end

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "convergio"
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

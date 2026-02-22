class Decant < Formula
  desc "Clean noisy HTML into compact markdown for LLM context"
  homepage "https://github.com/mtrifilo/decant"
  license "MIT"
  version "0.6.0"

  url "https://github.com/mtrifilo/decant/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "9d292e3e95afe061cc84fb5f4b338595f5fde64654e4c4b59a7fa3b146b9c5c4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mtrifilo/decant/releases/download/v0.6.0/decant-darwin-arm64"
      sha256 "a976a3a3de26dd7a3c8f49871df697a9bbc3a3e3875f8e0b99a59ab588874e4d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/mtrifilo/decant/releases/download/v0.6.0/decant-linux-x64"
      sha256 "9e92ef88710c27441fccfaa7a7db457fd46665e69538ca28cb2c09cc90cb183c"
    end
  end

  def install
    binary_name =
      if OS.mac? && Hardware::CPU.arm?
        "decant-darwin-arm64"
      elsif OS.linux? && Hardware::CPU.intel?
        "decant-linux-x64"
      else
        odie <<~EOS
          Prebuilt binaries are currently available for:
            - macOS arm64
            - Linux x64
            - Windows x64 (via Scoop/installer)

          For unsupported platforms, use source install:
            bun install
            bun link
        EOS
      end

    bin.install binary_name => "decant"
  end

  test do
    assert_match "Usage: decant", shell_output("#{bin}/decant --help")
  end
end

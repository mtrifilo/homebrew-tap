class Decant < Formula
  desc "Clean noisy HTML into compact markdown for LLM context"
  homepage "https://github.com/mtrifilo/decant"
  license "MIT"
  version "0.6.1"

  url "https://github.com/mtrifilo/decant/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "76ada0365ecb98b5b98adb1d1cad51b2cb5129ce6dae8e34578a2ffa00b62286"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mtrifilo/decant/releases/download/v0.6.1/decant-darwin-arm64"
      sha256 "7c2eb5100d362f98092f5896db956929b80ca203939d95a82d0b1e14b0e5d631"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/mtrifilo/decant/releases/download/v0.6.1/decant-linux-x64"
      sha256 "301c34add05bb9a860646297551e2ff81c5f5881c3b263a3c50ccf258b8babb6"
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

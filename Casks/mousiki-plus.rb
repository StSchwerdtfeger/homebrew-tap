cask "mousiki-plus" do
  arch arm: "arm64", intel: "universal"

  version "5.1.0"
  sha256 arm:   "1d61f345a6c18597d70068c59105a07304cbd3c4b84dc44b3a39996966840f0f",
         intel: "abbbb7d1073237f45b38425602ff292c5954d6c361f41953ebdf6fa789f7405a"

  url "https://github.com/StSchwerdtfeger/mousiki-plus/releases/download/v#{version}/Mousiki-#{version}-macos-#{arch}-portable.zip"
  name "Mousiki Plus"
  desc "Terminal music, internet radio and audio book player with oscilloscope and spectrogram"
  homepage "https://github.com/StSchwerdtfeger/mousiki-plus"

  conflicts_with cask: "mousiki-plus-universal"

  depends_on formula: "ffmpeg"   # decoding, radio streams, recordings, cutting audio books
  depends_on formula: "sdl2"     # scope and spectrogram windows

  binary "Mousiki-#{version}/mousiki"
  binary "Mousiki-#{version}/lala"

  postflight do
    # The zip is the portable version: without this file settings go to ~/.config/mousiki
    # (and survive upgrades) instead of a data/ folder inside the Caskroom.
    FileUtils.rm_f "#{staged_path}/Mousiki-#{version}/portable.txt"
    # The binaries are not notarized; without this, Gatekeeper blocks them on first start.
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/Mousiki-#{version}"]
  end

  zap trash: [
    "~/.cache/mousiki",
    "~/.config/mousiki",
  ]
end

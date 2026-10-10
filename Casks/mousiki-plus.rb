cask "mousiki-plus" do
  version "3.1.0"
  sha256 "e51018e40ad2447435b88864d7ac48cfde018d820bfd109f630a4d1c80bace3d"

  url "https://github.com/StSchwerdtfeger/mousiki-plus/releases/download/v#{version}/Mousiki-#{version}-macos-universal-portable.zip"
  name "Mousiki Plus"
  desc "Terminal music player and internet radio with oscilloscope and spectrogram"
  homepage "https://github.com/StSchwerdtfeger/mousiki-plus"

  depends_on formula: "ffmpeg"   # decoding, radio streams, recordings
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

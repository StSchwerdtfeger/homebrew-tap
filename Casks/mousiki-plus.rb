cask "mousiki-plus" do
  version "4.0.0"
  sha256 "2906540a55adfb3fa7f0018e36675588407632bc772f88774029fab78cfa453b"
  
  url "https://github.com/StSchwerdtfeger/mousiki-plus/releases/download/v#{version}/Mousiki-#{version}-macos-universal-portable.zip"
  name "Mousiki Plus"
  desc "Terminal UI music and internet radio player"
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

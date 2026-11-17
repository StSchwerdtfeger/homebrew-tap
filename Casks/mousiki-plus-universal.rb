cask "mousiki-plus-universal" do
  version "5.1.0"
  sha256 "abbbb7d1073237f45b38425602ff292c5954d6c361f41953ebdf6fa789f7405a"

  url "https://github.com/StSchwerdtfeger/mousiki-plus/releases/download/v#{version}/Mousiki-#{version}-macos-universal-portable.zip"
  name "Mousiki Plus (universal)"
  desc "Terminal music, internet radio and audio book player (universal Intel + Apple silicon build)"
  homepage "https://github.com/StSchwerdtfeger/mousiki-plus"

  conflicts_with cask: "mousiki-plus"

  depends_on formula: "ffmpeg"
  depends_on formula: "sdl2"

  binary "Mousiki-#{version}/mousiki"
  binary "Mousiki-#{version}/lala"

  postflight do
    FileUtils.rm_f "#{staged_path}/Mousiki-#{version}/portable.txt"
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/Mousiki-#{version}"]
  end

  zap trash: [
    "~/.cache/mousiki",
    "~/.config/mousiki",
  ]
end

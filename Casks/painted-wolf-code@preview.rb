cask "painted-wolf-code@preview" do
  version "1.0.0-rc.2"
  sha256 "4143cbd8c7b1fd87696b98e11b8aa73f593fc4ad86b7763727bf6fde369ae155"

  url "https://downloads.paintedwolf.dev/releases/v#{version}/painted-wolf-code_v#{version}_darwin-aarch64.dmg"
  name "Painted Wolf Code"
  desc "Local-first AI coding agent"
  homepage "https://paintedwolf.ai"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Painted Wolf Code.app"

  postflight do
    marker_dir = File.join(Dir.home, ".config", "paintedwolf")
    system_command "/bin/mkdir", args: ["-p", marker_dir]
    system_command "/bin/sh",
                   args: [
                     "-c",
                     "umask 077; printf '%s\\n' '{\"install_source\":\"homebrew_cask\",\"release_channel\":\"preview\"}' > \"$1/install-source.json\"",
                     "--",
                     marker_dir,
                   ]
  end

  uninstall_postflight do
    system_command "/bin/rm",
                   args: ["-f", File.join(Dir.home, ".config", "paintedwolf", "install-source.json")]
  end

  zap trash: "~/.config/paintedwolf"
end

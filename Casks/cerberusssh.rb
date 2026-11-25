cask "cerberusssh" do
  version "0.3.5"
  sha256 "72ecd7ea3da23ffb8bdc8ba15a35981fe9f78e0d58cfed8f729e27e9727dbc42"

  url "https://github.com/L4mbd4W0lf/cerberus-ssh/releases/download/v#{version}/CerberusSSH-#{version}.zip"
  name "CerberusSSH"
  desc "Native SSH client with a local-first vault"
  homepage "https://github.com/L4mbd4W0lf/cerberus-ssh"

  depends_on macos: :tahoe

  app "CerberusSSH.app"

  zap trash: [
    "~/Library/Application Support/CerberusSSH",
    "~/Library/Preferences/com.cerberusssh.plist",
    "~/Library/Saved Application State/com.cerberusssh.savedState",
  ]

  caveats <<~EOS
    CerberusSSH is not notarised yet, so macOS will refuse to open it.
    After installing (and after each upgrade), clear the quarantine flag once:

      xattr -dr com.apple.quarantine #{appdir}/CerberusSSH.app
  EOS
end

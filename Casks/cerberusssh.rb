cask "cerberusssh" do
  version "0.3.4"
  sha256 "e0c98a92ad44d305a00bed6c01f882ffb30255b02345cbfca2125fbe56245cc1"

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

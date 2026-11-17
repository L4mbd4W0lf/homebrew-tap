# Homebrew Tap

A Homebrew tap for my macOS applications and command-line tools. More formulae and casks will be added over time.

## Available software

| Name | Type | Description |
| :--- | :--- | :--- |
| `mydumper` | Formula | Source-built MyDumper and MyLoader, linked against Homebrew's `mysql-client`. |
| `cerberusssh` | Cask | [CerberusSSH](https://github.com/L4mbd4W0lf/cerberus-ssh), a native macOS SSH client with a local-first vault. Not notarised yet (see [Apps that are not notarised](#apps-that-are-not-notarised)). |

## Getting started

Homebrew loads formulae and casks only from taps you have trusted. Trust this tap once, before installing anything from it:

```sh
brew trust L4mbd4W0lf/tap
```

## Installation

Install a formula or a cask directly from the tap:

```sh
brew install L4mbd4W0lf/tap/<formula>
brew install --cask L4mbd4W0lf/tap/<cask>
```

Or add the tap once, then install by name:

```sh
brew tap L4mbd4W0lf/tap
brew install <formula>
brew install --cask <cask>
```

Upgrade and uninstall as with any Homebrew package:

```sh
brew upgrade <formula>
brew upgrade --cask <cask>
brew uninstall --cask <cask>
```

### Replacing an app installed outside Homebrew

If an app is already in Applications, for example from a disk image, Homebrew will not overwrite it. Add `--force` to replace it with the Homebrew copy, which Homebrew then upgrades and uninstalls for you:

```sh
brew install --cask --force L4mbd4W0lf/tap/<cask>
```

Only the app is replaced. Its settings and data, which are stored outside the app, are kept.

### Apps that are not notarised

macOS refuses to open an app that is not notarised by Apple until its quarantine flag is cleared. Such casks say so when installed (`brew info --cask <cask>` shows it again). After installing, and after each upgrade, run once:

```sh
xattr -dr com.apple.quarantine /Applications/<App>.app
```

## Notes

- **mydumper:** Homebrew installs the default configuration at `$(brew --prefix)/etc/mydumper.cnf`. If needed, pass its location explicitly, for example `mydumper --defaults-file="$(brew --prefix)/etc/mydumper.cnf" --version`.

## Troubleshooting

If an installation or update fails, update Homebrew and refresh the tap before retrying:

```sh
brew update
brew reinstall <formula>
brew reinstall --cask <cask>
```

If Homebrew refuses to load something from this tap, check that you have trusted it (see [Getting started](#getting-started)).

For general Homebrew help, see the [Homebrew Documentation](https://docs.brew.sh).

## Maintainers

### Updating a formula or cask

A new release needs its `version` (or `url`) and `sha256` updated in `Formula/<name>.rb` or `Casks/<name>.rb`. Check the change before committing:

```sh
brew style Formula/<name>.rb Casks/<name>.rb
brew audit --online L4mbd4W0lf/tap/<name>
```

Audit warnings about notability, pre-releases or Gatekeeper apply to Homebrew's official repositories and do not block installing from this tap.

### Helper scripts

`update_mydumper_formula.sh` updates `Formula/mydumper.rb` from a tagged upstream source archive URL: it downloads the archive, calculates its SHA-256, updates the URL and checksum, then runs `brew style`. Run it from the tap root:

```sh
./update_mydumper_formula.sh https://github.com/mydumper/mydumper/archive/refs/tags/v1.0.19-1.tar.gz
```

It expects an archive URL whose filename ends in `.zip`, `.tar.gz`, or `.tgz` and whose tag is in the `/refs/tags/` path. It requires `curl`, `shasum`, Python 3, and Homebrew.

For CerberusSSH, set `version` and `sha256` in `Casks/cerberusssh.rb` to what the CerberusSSH release script prints.

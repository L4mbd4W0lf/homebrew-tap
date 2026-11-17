# Homebrew Tap

A Homebrew tap for my macOS applications and command-line tools. More formulae and casks will be added over time.

## Available software

| Name | Type | Description |
| :--- | :--- | :--- |
| `mydumper` | Formula | Source-built MyDumper and MyLoader, linked against Homebrew's `mysql-client`. |
| `cerberusssh` | Cask | [CerberusSSH](https://github.com/L4mbd4W0lf/cerberus-ssh), a native macOS SSH client with a local-first vault. |

## Installation

Install a formula directly from the tap:

```sh
brew install L4mbd4W0lf/tap/mydumper
```

Or add the tap once, then install formulae by name:

```sh
brew tap L4mbd4W0lf/tap
brew install mydumper
```

Install a cask the same way, with `--cask`:

```sh
brew install --cask L4mbd4W0lf/tap/cerberusssh
```

## CerberusSSH

CerberusSSH requires macOS 26 or later. It is not notarised yet, so macOS refuses to open it until the quarantine flag is cleared. After installing, and after each upgrade, run once:

```sh
xattr -dr com.apple.quarantine /Applications/CerberusSSH.app
```

To update the cask for a new release, set `version` and `sha256` in `Casks/cerberusssh.rb` to what the CerberusSSH release script prints.

## MyDumper

The formula builds [`mydumper`](https://github.com/mydumper/mydumper) and `myloader` from source. Homebrew installs the default configuration at `$(brew --prefix)/etc/mydumper.cnf`. If needed, pass its location explicitly:

```sh
mydumper --defaults-file="$(brew --prefix)/etc/mydumper.cnf" --version
myloader --defaults-file="$(brew --prefix)/etc/mydumper.cnf" --version
```

## Troubleshooting

If an installation or update fails, update Homebrew and refresh the tap before retrying:

```sh
brew update
brew reinstall mydumper
```

For general Homebrew help, see the [Homebrew Documentation](https://docs.brew.sh).

## Update the formula (maintainers)

Run the helper from the tap root with a tagged upstream source archive URL. It downloads the archive, calculates its SHA-256, updates the URL and checksum in `Formula/mydumper.rb`, then runs `brew style`:

```sh
./update_mydumper_formula.sh https://github.com/mydumper/mydumper/archive/refs/tags/v1.0.19-1.tar.gz
```

Review the changes before committing:

```sh
git diff -- Formula/mydumper.rb
git add Formula/mydumper.rb
git commit -m "Update MyDumper"
```

The helper expects an archive URL whose filename ends in `.zip`, `.tar.gz`, or `.tgz` and whose tag is in the `/refs/tags/` path. It requires `curl`, `shasum`, Python 3, and Homebrew.

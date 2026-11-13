# Homebrew Tap

A Homebrew tap for my macOS applications and command-line tools. More formulae and casks will be added over time.

## Available software

| Name | Type | Description |
| :--- | :--- | :--- |
| `mydumper` | Formula | Source-built MyDumper and MyLoader, linked against Homebrew's `mysql-client`. |

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

When casks are added, they can be installed directly with `brew install --cask L4mbd4W0lf/tap/<cask-name>` or by tapping first and running `brew install --cask <cask-name>`.

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

Run the helper from the tap root with a tagged upstream source archive URL. It downloads the archive, calculates its SHA-256, updates the URL, version, and checksum in `Formula/mydumper.rb`, then runs `brew audit`:

```sh
./update_mydumper_formula.sh https://github.com/mydumper/mydumper/archive/refs/tags/v1.0.11-1.zip
```

Review the changes before committing:

```sh
git diff -- Formula/mydumper.rb
git add Formula/mydumper.rb
git commit -m "Update MyDumper"
```

The helper expects an archive URL whose filename ends in `.zip`, `.tar.gz`, or `.tgz` and whose tag is in the `/refs/tags/` path. It requires `curl`, `shasum`, Python 3, and Homebrew.

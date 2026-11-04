# homebrew-tap
Shared repository to hold Homebrew recipes.

## Installation
`brew tap norsk-tipping/tap`

## mectl

```sh
brew install norsk-tipping/tap/mectl
mectl version
```

Supports Apple Silicon and Intel macOS, and Linux x86-64. Versioned binaries and
Windows downloads are hosted in [mectl releases](https://github.com/janfonas/mectl-releases).
Application source remains private; using mectl requires company network access and credentials.

For an existing `janfonas/tap` installation, run `brew tap norsk-tipping/tap` before
`brew update`, then `brew upgrade mectl`. If Homebrew requests manual migration,
run `brew reinstall norsk-tipping/tap/mectl`. Application configuration is unchanged.
If Homebrew requests trust, run `brew trust --formula norsk-tipping/tap/mectl` and
retry; this trusts only mectl, not the entire company tap.

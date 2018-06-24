# clean-my-mac
A Shell script that cleans your Mac OSX with no pain, zero dependency.

## Getting Started

### Prerequisites

#### **Disclaimer**: Clean-My-Mac only works on Mac OSX, don't use it on other unix-like systems or Linux

- `curl` or `wget` should be installed
- `git` should be installed
- a _shell_ variable, `sh`, `bash` or `zsh`

### Basic Installation

Clean My Mac can be installed by running through one of the two commands, `wget` or `curl`.

**via curl**
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/aaronoah/clean-my-mac/master/tools/install.sh)"
```

**via wget**
```
sh -c "$(wget https://raw.githubusercontent.com/aaronoah/clean-my-mac/master/tools/install.sh -O -)"
```

### Using Clean My Mac

After installation completes, whenever you want to clear off junk files from your Mac, simply open up the terminal and type one single command
```
clean_my_mac
```
Then, you're all set! :sparkles:

If you need an upgrade, run
```
upgrade_clean_my_mac
```

## License

Clean My Mac is released under the [MIT License](../LICENSE)

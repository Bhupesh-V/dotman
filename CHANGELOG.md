# Changelog

All notable changes to this project will be documented in this file.

## [0.3.0] - Oct , 2020

### Changed
- How changes are pulled, dotman no longer pulls from `master` branch, your default branch is automatically determined. By **[Prajeshpuri](https://github.com/Bhupesh-V/dotman/pull/18)** 🙌
- Switch to stable version on install through `install.sh`.
- Other minor improvements.

### Fixed
- First time setup issues.
- _"No names found, cannot describe anything."_ error while running `dotman version`.
- Double exported aliases when installing dotman again.


## [0.2.0] - Aug 25, 2020

### Changed
- Now, Manage menu option numbers appear in **bold**.
- Rename options in `manage` menu.
- Minor tooling 🔧 updates.
  - `install.sh` now only installs tagged releases by default.

### Fixed
- Bug where "_No Changes in dotfiles_" was printed twice when using option **[2]**.
- Compatibility issues for MacOS, remove instances of `echo -e`.
- dotman logo printing errors, [#2](https://github.com/Bhupesh-V/dotman/issues/2). Now compatible with Bash 3 (& MacOS).
- Bug 🐛 where `$DOT_REPO` variable was not exported. By **[tadomaitis](https://github.com/Bhupesh-V/dotman/pull/5)** 🙌


## [0.1.0] - July 18, 2020
- Initial Release

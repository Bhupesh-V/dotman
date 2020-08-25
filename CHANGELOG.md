# Changelog

All notable changes to this project will be documented in this file.

## [0.2.0] - July x , 2020

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

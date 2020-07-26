<p align="center">
   <img src="https://github.com/Bhupesh-V/dotman/blob/master/assets/dotman-logo.png?raw=true" height="250">
</p>

<p align="center">
  <a href="https://github.com/Bhupesh-V/dotman/actions">
    <img alt="shellcheck" src="https://github.com/Bhupesh-V/dotman/workflows/shellcheck/badge.svg?branch=master">
  </a>
  <a href="https://github.com/Bhupesh-V/dotman/blob/master/LICENSE">
    <img alt="License: MIT" src="https://img.shields.io/github/license/Bhupesh-V/dotman" />
  </a>
  <a href="https://github.com/Bhupesh-V/dotman/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/Bhupesh-V/dotman?color=blueviolet" />
  </a>
  <a href="https://github.com/ellerbrock/open-source-badges">
    <img alt="bashit" src="https://badges.frapsoft.com/bash/v1/bash.png?v=103">
  </a>
  <a href="https://bhupesh.codes/dotman">
    <img alt="Website Status dotman" src="https://img.shields.io/website?url=https%3A%2F%2Fbhupesh.codes%2Fdotman">
  </a>
  <a href="https://twitter.com/bhupeshimself">
    <img alt="Twitter: bhupeshimself" src="https://img.shields.io/twitter/follow/bhupeshimself.svg?style=social" target="_blank" />
  </a>
</p>


<samp>
  <h3 align="center">
    <a href="https://www.freecodecamp.org/news/build-your-own-dotfiles-manager-from-scratch/">✨ Learn how I made d○tman from scratch ✨</a>
  </h3>
</samp>


## Demo 🔥

<p align="center">
  <img alt="dotman-demo" src="https://user-images.githubusercontent.com/34342551/87691530-4d16e280-c7a8-11ea-8f5e-77f50b9635c3.gif">
</p>

## 🌠 Features

* Single file
* No config file for dotman (No `.dotrc` 🤦)
* No useless arguments (single command 😎)
* Easy to use
* Extendable ⚒, _Available as a Template_
* Fewer Dependencies
  - `Git`
  - `Bash`


## 💠 Installation

### via curl ➰

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-v/dotman/master/tools/install.sh)"
```

### via wget 📥

```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/Bhupesh-v/dotman/master/tools/install.sh)"
```

### via httpie 🥧

```shell
sh -c "$(http --download https://raw.githubusercontent.com/Bhupesh-v/dotman/master/tools/install.sh)"
```

> **dotman** is installed by default in `/home/username/dotman`. Your `$HOME` directory.

### Manually ❓

1. Just grab **dotman.sh** from [Releases 🔼](https://github.com/Bhupesh-V/dotman/releases) and store it anywhere on your system.
2. Change file mode to be 🏃 executable.
  ```bash
  chmod +x dotman.sh
  ```
3. Set alias for dotman _(optional)_. Alternatively modify your `.bash_aliases` file. 
  ```bash
  alias $(pwd)/dotman.sh=dotman
  ```
4. Run **dotman**.
  ```bash
  ./dotman.sh
  ```


## Usage

Just run **`dotman`** anywhere in your terminal 🖖.

```bash
dotman
```
Leave the rest to it.


## What else 👀

dotman exports 2 variables in your default shell config (`bashrc`, `zshrc` etc):

1. `DOT_DEST`: used for finding the location of dotfiles repository in your local system.
2. `DOT_REPO`: the url to the remote dotfile repo.

You can change these manually if any one of the info changes.

## Author

🤓 **Bhupesh Varshney**

- Web : [bhupesh.codes](https://bhupesh.codes)
- Twitter : [@bhupeshimself](https://twitter.com/bhupeshimself)
- DEV : [bhupesh](https://dev.to/bhupesh)

[![forthebadge](https://forthebadge.com/images/badges/ages-12.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

## ☺️ Show your support

Support me by giving a ⭐️ if this project helped you! or just [![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FBhupesh-V%2Fdotman%2F)](https://twitter.com/intent/tweet?url=https://github.com/Bhupesh-V/dotman&text=dotman%20via%20@bhupeshimself)

<a href="https://www.patreon.com/bhupesh">
  <img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>

## 📝 License

Copyright © 2020 [Bhupesh Varshney](https://github.com/Bhupesh-V).<br />
This project is [MIT](https://github.com/Bhupesh-V/dotman/blob/master/LICENSE) licensed.

## 👋 Contributing

Please read the [CONTRIBUTING](CONTRIBUTING.md) file for the process of submitting pull requests to us.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/fpitters"><img src="https://avatars2.githubusercontent.com/u/1129222?v=4" width="100px;" alt=""/><br /><sub><b>fpitters</b></sub></a><br /><a href="https://github.com/Bhupesh-V/dotman/issues?q=author%3Afpitters" title="Bug reports">🐛</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

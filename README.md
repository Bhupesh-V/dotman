<p align="center">
   <img src="https://github.com/Bhupesh-V/dotman/blob/master/assets/dotman-logo.png?raw=true" height="230">
</p>

<p align="center">
  <a href="https://github.com/Bhupesh-V/dotman/actions">
    <img alt="build status badge" src="https://github.com/Bhupesh-V/dotman/workflows/build/badge.svg?branch=master">
  </a>
  <a href="https://github.com/Bhupesh-V/dotman/blob/master/LICENSE">
    <img alt="License: MIT" src="https://img.shields.io/github/license/Bhupesh-V/dotman" />
  </a>
  <a href="">
    <img alt="platform: linux and macos" src="https://img.shields.io/badge/platform-GNU/Linux %7C MacOS-blue">
  </a>
  <a href="https://github.com/ellerbrock/open-source-badges">
    <img alt="bash love" src="https://raw.githubusercontent.com/ellerbrock/open-source-badges/master/badges/bash-v1/bash.png">
  </a>
  <a href="https://bhupesh-v.github.io/dotman">
    <img alt="Website Status dotman" src="https://img.shields.io/website?url=https%3A%2F%2Fbhupesh-v.github.io%2Fdotman">
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

* **Single file manager** (Portable)
* **No config files for dotman** (No `.dotrc` 🤦)
* **No useless arguments** (single command 😎)
* **Easy to use**
* **Extendable ⚒**, _Available as a Template_
* **Fewer Dependencies**
  - **`Git`**
  - **`Bash>=3`**


## Wait! it's not written in a fancy language

And it doesn't have to be. Why?

- Your focus should be on your **dot files & scripts** rather than on a dotfiles manager or how to use it.(_Wait I forgot what was the command to push files? Is it `dt push` or `dt --push`_)
- Creating a overly-complex solution for something simple should not be the goal.


## 💠 Installation

### via `curl` ➰

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-v/dotman/master/tools/install.sh)"
```

### via `wget` 📥

```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/Bhupesh-v/dotman/master/tools/install.sh)"
```

### via `httpie` 🥧

```shell
sh -c "$(http --download https://raw.githubusercontent.com/Bhupesh-v/dotman/master/tools/install.sh)"
```

> **dotman** is installed by default in `/home/username/dotman`, your `$HOME` directory.

Now run **`dotman`** for 1st time set-up.

1. Enter repository URL (without `.git`).
2. Enter folder name to where this repo be cloned (relative to `/home/username/`).
3. Open up new terminal 🚀.

### Manually (you ok ?)

1. Just grab **dotman.sh** from [Releases 🔼](https://github.com/Bhupesh-V/dotman/releases) and store it anywhere on your system.
2. Change file permissions to be 🏃 executable.
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

[Web](https://bhupesh-v.github.io) | [Twitter: @bhupeshimself](https://twitter.com/bhupeshimself) | [DEV: bhupesh](https://dev.to/bhupesh)

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

## ☺️ Show your support

Support me by giving a ⭐️ if this project helped you! or just [![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FBhupesh-V%2Fdotman%2F)](https://twitter.com/intent/tweet?url=https://github.com/Bhupesh-V/dotman&text=dotman%20via%20@bhupeshimself)

<a href="https://liberapay.com/bhupesh/donate">
  <img title="librepay/bhupesh" alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg" width="100">
</a>
<a href="https://ko-fi.com/bhupesh">
  <img title="ko-fi/bhupesh" alt="Support on ko-fi" src="https://user-images.githubusercontent.com/34342551/88784787-12507980-d1ae-11ea-82fe-f55753340168.png" width="185">
</a>


## 📝 License

Copyright © 2020 [Bhupesh Varshney](https://github.com/Bhupesh-V).<br />
This project is [MIT](https://github.com/Bhupesh-V/dotman/blob/master/LICENSE) licensed.

## 📝 Changelog

See the [CHANGELOG.md](CHANGELOG.md) file for details.

## 👋 Contributing

Please read the [CONTRIBUTING](CONTRIBUTING.md) file for the process of submitting pull requests to us.

## ✨ Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/fpitters"><img src="https://avatars2.githubusercontent.com/u/1129222?v=4" width="100px;" alt=""/><br /><sub><b>fpitters</b></sub></a><br /><a href="https://github.com/Bhupesh-V/dotman/issues?q=author%3Afpitters" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/tadomaitis"><img src="https://avatars3.githubusercontent.com/u/20560225?v=4" width="100px;" alt=""/><br /><sub><b>Thiago Adomaitis</b></sub></a><br /><a href="https://github.com/Bhupesh-V/dotman/issues?q=author%3Atadomaitis" title="Bug reports">🐛</a> <a href="https://github.com/Bhupesh-V/dotman/commits?author=tadomaitis" title="Code">💻</a></td>
    <td align="center"><a href="http://scott.menzer.org"><img src="https://avatars1.githubusercontent.com/u/624392?v=4" width="100px;" alt=""/><br /><sub><b>Scott</b></sub></a><br /><a href="https://github.com/Bhupesh-V/dotman/issues?q=author%3Asmenzer" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://prajeshpuri.tech/"><img src="https://avatars3.githubusercontent.com/u/34602781?v=4" width="100px;" alt=""/><br /><sub><b>Prajeshpuri</b></sub></a><br /><a href="https://github.com/Bhupesh-V/dotman/commits?author=Prajeshpuri" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

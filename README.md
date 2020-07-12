<h1 align="center">d○tman</h1>

<p align="center">
  <a href="https://github.com/Bhupesh-V/dotman/actions">
    <img alt="Lint" src="https://github.com/Bhupesh-V/dotman/workflows/Lint/badge.svg?branch=master">
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
  <a href="">
    <img alt="Website Status" src="https://img.shields.io/website?down_color=red&down_message=down&up_color=darkgreen&up_message=up&url=https%3A%2F%2Fwebsite.com" />
  </a>
  <a href="https://twitter.com/bhupeshimself">
    <img alt="Twitter: bhupeshimself" src="https://img.shields.io/twitter/follow/bhupeshimself.svg?style=social" target="_blank" />
  </a>
</p>

<pre align="center">
<b>
      _       _                         
     | |     | |                        
   __| | ___ | |_ _ __ ___   __ _ _ __  
  / _` |/ _ \| __| '_ ` _ \ / _` | '_ \ 
 | (_| | (_) | |_| | | | | | (_| | | | |
  \__,_|\___/ \__|_| |_| |_|\__,_|_| |_|

</b>
</pre>

<blockquote>
  <h3 align="center">
    d○tman is a simple & elegant (dot)file (man)ager
  </h3>
</blockquote>

<code>
  <p align="center">
    <h3 align="center">
    <a href="">✨ Learn how I made d○tman from scratch ✨</a>
    </h3>
  </p>
</code>

## 🌠 Features

* Single file
* No config file for dotman (No `.dotrc` 🤦)
* No useless arguments (single command 😎)
* Easy to use
* Extendable ⚒, _Available as a Template_
* Fewer Dependencies
  1. `Git`
  2. `curl`_*_


## 💠 Installation

#### via curl ➰

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-v/dotman/master/install.sh)"
```

#### via wget 📥

```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/Bhupesh-v/dotman/master/install.sh)"
```

#### via httpie 🥧

```shell
sh -c "$(http --download https://raw.githubusercontent.com/Bhupesh-v/dotman/master/install.sh)"
```

> **dotman** is installed by default in `/home/username/.dotman`

#### Manually ❓

1. Just grab **dotman.sh** from [Releases 🔼](https://github.com/Bhupesh-V/dotman/releases) and store it anywhere on your system.
2. Make it 🏃 executable.
  ```bash
  chmod +x dotman.sh
  ```
3. Set alias for dotman _(optional)_. 
  ```bash
  alias $(pwd)/dotman.sh=dotman
  ```

> Note: If you install manually, updates to dotman will not be automatically available. You would have to download it from releases in case of any changes. 


## Usage

Just run **`dotman`** anywhere in your terminal 🖖.

```bash
dotman
```
Leave the rest to it.


## What else ?

dotman exports 2 variables in your default shell config (`bashrc`, `zshrc` etc):

1. `DOT_DEST`: used for finding the location of repository in your local system.
2. `DOT_REPO`: the url to the remote dotfile repo.

You can change these manually if any one of the info changes.

## Author

:bust_in_silhouette: **Bhupesh Varshney**

- Web : [bhupesh.codes](https://bhupesh.codes)
- Twitter : [@bhupeshimself](https://twitter.com/bhupeshimself)
- DEV : [bhupesh](https://dev.to/bhupesh)

[![forthebadge](https://forthebadge.com/images/badges/ages-18.svg)](https://forthebadge.com)
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

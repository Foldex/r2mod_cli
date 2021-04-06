# r2mod_cli

| [Features](#features) | [Requirements](#requirements) | [Usage](#usage) | [Changelog](#changelog) |
|---|---|---|---|

A simple mod manager written in Bash for Linux users.

![Screen](https://raw.githubusercontent.com/Foldex/r2mod_cli/master/img/screen.png)

## Features

- Simple No-Nonsense Usage
- Setup BepInEx and R2API
- Install and Update Mods
- Hold Specific Mods Back from Updating
- Enable/Disable Mods
- Edit Mod Configs
- Check for Updates for itself
- Supports Importing/Exporting r2modman profile codes
- Supports Flatpak Steam Installs
- Tab Completion

## Requirements

The following programs should be installed:

### Arch

`sudo pacman -S curl gawk jq p7zip sed`

### Fedora

`sudo dnf install curl gawk jq p7zip sed`

### Ubuntu

`sudo apt-get install curl gawk jq p7zip-full sed`

## Usage

### Install

Extract the zip and run `sudo make install` inside its directory.

### First Setup

It is heavily recommended to run `r2mod setup` to create a new install.

Some empty folders will be placed in the `BepInEx/plugins` dir, do not remove them.

They are used to track updates for certain mods.

#### Custom Install Location

The default install directories for Steam/Flatpak should automatically be handled.

If you've installed Risk of Rain 2 to a different location, please export the environment variable

`$R2MOD_INSTALL_DIR` in your bash profile and point it to your install directory:

`export R2MOD_INSTALL_DIR="$HOME/custom/dir/Risk of Rain 2"`

### Command List

Accepts shorthand for command names.

```
r2mod ch(eck): Check for Script Updates
r2mod dis(able): Disable All Mods
r2mod ed(it) ConfigName: Edit Mod Configs
r2mod en(able): Enable All Mods
r2mod exp(ort) ProfileName: Export r2modman mod profile
r2mod hol(d): Toggle Mod Updates
r2mod imp(ort) ProfileCode: Install r2modman mod profile
r2mod ins(tall) Thunderstore-Dependency-String: Install New Mod
r2mod li(st) (count): List or Count Installed Mods
r2mod ref(resh): Force Refresh Package Cache
r2mod run: Launch Risk of Rain
r2mod sea(rch): Search for Mods
r2mod set(up): Install a Fresh BepInEx Setup
r2mod un(install) Thunderstore-Dependency-String: Uninstall Mod
r2mod upd(ate): Update All Exisiting Mods
r2mod ver(sion): Print Version
```

### Installing a Mod

Use `r2mod install ontrigger-ItemStatsMod-2.0.0` to install a mod.

If the version number is left out, the most recent version will be installed.

`r2mod install ontrigger-ItemStatsMod`

Multiple mods can also be installed

`r2mod install ontrigger-ItemStatsMod MagnusMagnuson-BiggerBazaar`

### Uninstalling a Mod

Use `r2mod uninstall ontrigger-ItemStatsMod-2.0.0` to install a mod.

If the version number is left out, any version of that mod will be uninstalled.

`r2mod uninstall ontrigger-ItemStatsMod`

Multiple mods can also be uninstalled

`r2mod uninstall ontrigger-ItemStatsMod MagnusMagnuson-BiggerBazaar`

### Editing Configs

`$EDITOR` environment variable is used to determine which editor to use.

`r2mod edit` will open all BepInEx config files in your editor

`r2mod edit name` will open all matching configs (case insensitive, incomplete names are fine)

### Holding

Mods can be prevented from being auto updated by running `r2mod hold ModName`.

Run again to remove the hold.

### Files

All Files, Old Versions, and Backups can be found in `/tmp/r2mod`

## Todo

- Resolve and Install Dependencies for mods.

## Changelog

### 1.0.7
- Support R2API v3
- Allow Custom Steam Compat Dir
- Add Completion for `import preview`
- Fix mod installs with patchers
- Avoid running update check twice

### 1.0.6

- Fix some mods zips extracting without folders
- Improved setup logic
- `list` now uses color=auto
- Added `list count` command
- Added `ls` alias

### 1.0.5

- Add Search Command
- Alias `remove` for uninstall
- Automatically override winhttp on setup (bgkillas)

### 1.0.4

- Allow Custom Install Locations
- Improved ZSH Tab Completion
- Added run Command to Launch Game

### 1.0.3

- Added Hold Command
- Auto Check for R2Mod Updates
- Added profile_import preview option
- Fallback to previous cache if package cache update fails

### 1.0.2

- Added Tab Completion

### 1.0.1

- Fixed Update Check

### 1.0.0

- Initial Release

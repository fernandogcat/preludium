<div align="center">
  <img src="Art/icon.png" width="120">
</div>

# Preludium

## What is this?

Preludium is game template project for Godot to make it easier to bootstrap new games with some common features already implemented and best practices applied.

🚨 This still a work in progress project and is still pending some more features and better documentation.

# Main features

- [Load Scene Manager](Autoloads/load_scene_manager.gd) with [loading screen](Components/UI/Screens/LoadingScreen/loading_screen.gd)
- Main menu, settings and pause sample screens
- [Game Configuration](Components/GameConfiguration/game_configuration.gd) resource to hold common game configurations
- [Settings Manager](Components/SettingsManager/settings_manager.gd) to persist user settings
- [Window Helper](addons/window_helper/window_helper.gd) to have a custom window tool for handy dev shorcuts
- [Tests](Tests/) with [GUT](https://github.com/bitwes/Gut)
- Github Actions to:
    - [Run tests](.github/workflows/reusable_run_tests.yml)
    - [Build and deploy to itch.io](.github/workflows/build_and_deploy.yml)
- ...

# WIP / Pending documentation

## Change Github Settings
- [ ] set repostitory secrets for Github Actions
    - [ ] set write permissios (Settings > Actions > General) to be able to create version commit
- ...
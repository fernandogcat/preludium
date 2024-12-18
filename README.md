<div align="center">
  <img src="Art/icon.png" width="120">
</div>

# Preludium

## What is this?

Preludium is game template project for Godot to make it easier to bootstrap new games with some common features already implemented and best practices applied.

🚨 This still a work in progress project and is still pending some more features and better documentation.

# Main features

- [Load Scene Manager](Autoloads/load_scene_manager.gd) and [loading screen](Components/UI/Screens/LoadingScreen/loading_screen.gd) to be shown when changing between game scenes
- UI sample screens and modal screens
    - [Screens](Components/UI/Screens): loading, main menu and game screen
    - [Modal screens](Components/UI/ModalScreens): pause and settings 
- [Game Configuration](Components/GameConfiguration/game_configuration.gd) resource to hold common game and developer configurations
- [Settings Manager](Components/SettingsManager/settings_manager.gd) to persist user settings
- [Window Helper](addons/window_helper/window_helper.gd) to have a custom window tool for handy developer shorcuts like to quickly change between game screens
- [Main theme](Themes/main_theme.tres) to have a common style across UI elements
- [Tests](Tests/) with [GUT](https://github.com/bitwes/Gut)
- Github Actions to:
    - [Run tests](.github/workflows/reusable_run_tests.yml)
    - [Build and deploy to itch.io](.github/workflows/build_and_deploy.yml)
        - If tests fail, the build will not be deployed
        - Automatically detect and updates project version based on git tags
- ...

# WIP

## Improve documentation

- [ ] scene lifecycle (game_entrypoint -> initial_bootstrap -> main_menu -> game)
- [ ] required settings in github project
    - [ ] set repostitory secrets for Github Actions
    - [ ] set write permissios (Settings > Actions > General) to be able to create version commit
- ...

## Next features to implement

- [ ] add linter as a precommit and also to CI (if linter fails, the build will not be deployed)
- [ ] audio buses for music and sfx + persist to user settings
- [ ] custom logger
- [ ] seed manager
- [ ] object pool
- [ ] integration with discord
- ...
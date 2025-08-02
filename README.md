<div align="center">
  <img src="icon.png" width="120">
</div>

# Preludium

## What is this?

Preludium is game template project for Godot to make it easier to bootstrap new games with some common features already implemented and best practices applied.

🚨 This still a work in progress project and is still pending some more features and better documentation.

# Main features

- [Load Scene Manager](autoloads/load_scene_manager.gd) and [loading screen](components/ui/screens/loading_screen/scripts/loading_screen.gd) to be shown when changing between game scenes
- UI sample screens and modal screens
    - [Screens](components/ui/screens): loading, main menu and game screen
    - [Modal screens](components/ui/modal_screens): pause and settings 
- [Game Configuration](components/game_configuration/scripts/game_configuration.gd) resource to hold common game and developer configurations
- [Settings Manager](components/settings_manager/scripts/settings_manager.gd) to persist user settings
- [Window Helper](addons/window_helper/window_helper.gd) to have a custom window tool for handy developer shorcuts like to quickly change between game screens
- [Main theme](themes/main_theme.tres) to have a common style across UI elements
- [Linter](https://github.com/Scony/godot-gdscript-toolkit/wiki/3.-Linter) configured [.gdlint](.gdlintrc) file to check for errors and warnings in the code using `gdlint` command in the terminal
- [Tests](tests/) with [GUT](https://github.com/bitwes/Gut)
- Github Actions to:
    - [Run tests](.github/workflows/reusable_run_tests.yml)
    - [Build and deploy to itch.io](.github/workflows/build_and_deploy.yml)
        - If tests fail, the build will not be deployed
        - Automatically detect and updates project version based on git tags
- ...

# WIP

## Next TODO

- [ ] ..

## Improve documentation

- [ ] scene lifecycle (game_entrypoint -> initial_bootstrap -> main_menu -> game)
- [ ] required settings in github project
    - [ ] set repostitory secrets for Github Actions
    - [ ] set write permissios (Settings > Actions > General) to be able to create version commit
- folder structure
- ...

## Next features to implement

- [ ] check error logs in tests (e.g. `ERROR: Node not found: "%CloseModalButton"`)
- [ ] check if Popup node could replace ModalScreen
- [ ] add linter as a precommit and also to CI (if linter fails, the build will not be deployed)
- [ ] audio buses for music and sfx + persist to user settings
- [ ] custom logger
- [ ] seed manager
- [ ] object pool
- [ ] integration with discord
- ...

# To do after cloning the project

- [ ] update `project.godot`
    - [ ] config/name
    - [ ] config/version
- [ ] update `export_presets.cfg` export_path's
- [ ] look for other `preludium` text references if any
- [ ] update icon and splash screen: `icon.png` and `boot_splash.png`
- [ ] update this README.md to remove non game relevant information (whatever is before this section)
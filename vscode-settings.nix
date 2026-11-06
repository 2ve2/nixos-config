# VS Code settings in Nix: each rebuild installs this as a writable
# settings.json and backs up the previous file first.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  flake = "/home/lord2ve/nixos-config";
  ignoredDirs = [
    ".direnv"
    "node_modules"
    "result"
    "target"
    ".zig-cache"
  ];
  ignored = builtins.listToAttrs (
    map (dir: {
      name = "**/${dir}";
      value = true;
    }) ignoredDirs
  );
  unwatched = builtins.listToAttrs (
    map (dir: {
      name = "**/${dir}/**";
      value = true;
    }) ignoredDirs
  );

  settings = (pkgs.formats.json { }).generate "vscode-settings" {
    "workbench.activityBar.location" = "top";
    "workbench.sideBar.location" = "right";
    "workbench.layoutControl.enabled" = false;
    "workbench.navigationControl.enabled" = false;
    "workbench.startupEditor" = "none";
    "window.commandCenter" = false;
    "window.menuBarVisibility" = "toggle";
    "window.titleBarStyle" = "custom";
    "window.zoomLevel" = 0.5;
    "chat.commandCenter.enabled" = false;
    "editor.fontFamily" = "'JetBrains Mono', 'Noto Color Emoji', monospace";
    "editor.fontSize" = 14;
    "editor.fontLigatures" = true;
    "editor.minimap.enabled" = false;
    "editor.renderWhitespace" = "boundary";
    "editor.guides.bracketPairs" = "active";
    "editor.smoothScrolling" = true;
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.cursorBlinking" = "smooth";
    "editor.linkedEditing" = true;
    "editor.stickyScroll.enabled" = true;
    "editor.tabSize" = 2;
    "editor.insertSpaces" = true;
    "editor.formatOnSave" = true;
    "files.autoSave" = "afterDelay";
    "files.autoSaveDelay" = 1000;
    "files.trimTrailingWhitespace" = true;
    "files.insertFinalNewline" = true;
    "files.trimFinalNewlines" = true;
    "files.exclude" = ignored // {
      "**/__pycache__" = true;
    };
    "files.watcherExclude" = unwatched;
    "search.exclude" = ignored;
    "terminal.integrated.fontFamily" = "'JetBrains Mono'";
    "terminal.integrated.fontSize" = 14;
    "terminal.integrated.defaultProfile.linux" = "zsh";
    "explorer.sortOrder" = "type";
    "explorer.compactFolders" = false;
    "git.autofetch" = true;
    "git.enableCommitSigning" = true;
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
    "nix.serverSettings".nixd = {
      formatting.command = [ "${pkgs.nixfmt}/bin/nixfmt" ];
      # Option completion for NixOS and Home Manager.
      options = {
        nixos.expr = "(builtins.getFlake \"${flake}\").nixosConfigurations.nixos.options";
        home-manager.expr = "(builtins.getFlake \"${flake}\").nixosConfigurations.nixos.options.home-manager.users.type.getSubOptions []";
      };
    };
    "[javascript]"."editor.defaultFormatter" = "biomejs.biome";
    "[javascriptreact]"."editor.defaultFormatter" = "biomejs.biome";
    "[typescript]"."editor.defaultFormatter" = "biomejs.biome";
    "[typescriptreact]"."editor.defaultFormatter" = "biomejs.biome";
    "[json]"."editor.defaultFormatter" = "biomejs.biome";
    "[jsonc]"."editor.defaultFormatter" = "biomejs.biome";
    "[markdown]" = {
      "editor.wordWrap" = "on";
      "files.trimTrailingWhitespace" = false;
    };
    "tailwindCSS.classAttributes" = [
      "class"
      "className"
      "ngClass"
      "class:list"
    ];
    # The package and extensions update through Nix, never from within Code.
    "update.mode" = "none";
    "extensions.autoCheckUpdates" = false;
    "extensions.autoUpdate" = false;

    "json.schemaDownload.trustedDomains" = {
      "https://schemastore.azurewebsites.net/" = true;
      "https://raw.githubusercontent.com/microsoft/vscode/" = true;
      "https://raw.githubusercontent.com/devcontainers/spec/" = true;
      "https://www.schemastore.org/" = true;
      "https://json.schemastore.org/" = true;
      "https://json-schema.org/" = true;
      "https://developer.microsoft.com/json-schemas/" = true;
      "https://biomejs.dev" = true;
    };
    # Midnight Ink v2.
    "workbench.colorCustomizations" = {
      "editor.background" = "#0f0f0f";
      "editor.foreground" = "#e4e4e4";
      "editor.lineHighlightBackground" = "#191919";
      "editor.selectionBackground" = "#252525";
      "editorCursor.foreground" = "#358ee9";
      "editorLineNumber.foreground" = "#808080";
      "editorLineNumber.activeForeground" = "#a4a4a4";
      "sideBar.background" = "#0f0f0f";
      "sideBar.border" = "#252525";
      "activityBar.background" = "#0f0f0f";
      "activityBar.border" = "#252525";
      "activityBar.activeBorder" = "#358ee9";
      "activityBarBadge.background" = "#358ee9";
      "titleBar.activeBackground" = "#0f0f0f";
      "titleBar.border" = "#252525";
      "statusBar.background" = "#0f0f0f";
      "statusBar.border" = "#252525";
      "editorGroupHeader.tabsBackground" = "#191919";
      "tab.activeBackground" = "#0f0f0f";
      "tab.inactiveBackground" = "#191919";
      "tab.activeBorderTop" = "#358ee9";
      "tab.border" = "#252525";
      "panel.background" = "#0f0f0f";
      "panel.border" = "#252525";
      "terminal.background" = "#0f0f0f";
      "focusBorder" = "#358ee9";
      "list.activeSelectionBackground" = "#252525";
      "list.hoverBackground" = "#191919";
      "button.background" = "#358ee9";
      "button.foreground" = "#0f0f0f";
    };
    "editor.tokenColorCustomizations" = {
      "comments" = "#808080";
      "keywords" = "#d1b6ff";
      "strings" = "#86d779";
      "numbers" = "#f07fbf";
      "functions" = "#358ee9";
      "types" = "#f5eb7f";
      "variables" = "#e4e4e4";
    };
  };
  settingsPath = "${config.xdg.configHome}/Code/User/settings.json";
  backupRoot = "${config.xdg.stateHome}/nixos";
in
{
  # Home Manager's userSettings option links settings.json into the read-only
  # store. Extensions write to that file, so install a writable Nix baseline
  # after Home Manager removes the previous generation's managed symlink.
  home.activation.vscodeWritableSettings = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    target=${lib.escapeShellArg settingsPath}
    if [ -v DRY_RUN ]; then
      echo "Would install writable VS Code settings at $target after linking"
    else
      if [ -L "$target" ] || { [ -e "$target" ] && [ ! -f "$target" ]; }; then
        echo "VS Code settings path is not a regular file: $target" >&2
        exit 1
      fi

      if [ ! -f "$target" ] || ! cmp -s ${settings} "$target"; then
        mkdir -p "$(dirname "$target")"
        if [ -f "$target" ]; then
          mkdir -p ${lib.escapeShellArg backupRoot}
          backupDir="$(mktemp -d ${lib.escapeShellArg "${backupRoot}/vscode-settings.XXXXXXXX"})"
          cp -p "$target" "$backupDir/settings.json"
          echo "Backed up previous VS Code settings to $backupDir/settings.json"
        fi
        tmp="$(mktemp "$(dirname "$target")/.settings.json.XXXXXXXX")"
        cp ${settings} "$tmp"
        chmod 600 "$tmp"
        mv -f "$tmp" "$target"
      fi
      chmod 600 "$target"
    fi
  '';
}

# Two-line Starship prompt with Midnight Ink colors.
_: {
  programs.starship.settings = {
    add_newline = false;
    palette = "midnight";
    # base16 roles, matching the Ghostty and Niri colors.
    palettes.midnight = {
      base00 = "#0f0f0f";
      base03 = "#808080";
      base04 = "#a4a4a4";
      red = "#f46e56";
      orange = "#f07fbf";
      yellow = "#f5eb7f";
      green = "#86d779";
      cyan = "#0dbdbe";
      blue = "#358ee9";
      purple = "#d1b6ff";
    };
    # A quiet second line keeps long paths and Git details off the input line.
    format = "[╭─](fg:base03)$username$hostname$directory$git_branch$git_status$git_state$nix_shell$nodejs$python$rust$cmd_duration$jobs$status$line_break[╰─](fg:base03)$character";
    directory = {
      format = "[ $path ]($style)";
      style = "bold fg:base00 bg:blue";
      truncation_length = 3;
    };
    username.format = "[$user]($style)";
    hostname = {
      ssh_only = true;
      format = "[@$hostname]($style) ";
    };
    git_branch = {
      format = "[ ⎇ $branch]($style)";
      style = "bold purple";
      truncation_length = 20;
      truncation_symbol = "…";
    };
    git_status = {
      format = "([ $all_status$ahead_behind]($style))";
      style = "bold yellow";
    };
    git_state = {
      format = "[ $state( $progress_current/$progress_total)]($style)";
      style = "bold orange";
    };
    nix_shell = {
      format = "[ nix:$state]($style)";
      style = "bold cyan";
    };
    nodejs = {
      format = "[ node:$version]($style)";
      style = "green";
    };
    python = {
      format = "[ py:$version]($style)";
      style = "yellow";
    };
    rust = {
      format = "[ rs:$version]($style)";
      style = "orange";
    };
    cmd_duration = {
      min_time = 2000;
      format = "[ took $duration]($style)";
      style = "base04";
    };
    jobs = {
      format = "[ bg:$number]($style)";
      number_threshold = 1;
      style = "cyan";
    };
    status = {
      disabled = false;
      format = "[ exit:$status]($style)";
      style = "bold red";
    };
    character = {
      success_symbol = "[❯](bold green) ";
      error_symbol = "[❯](bold red) ";
    };
  };
}

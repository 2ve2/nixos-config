# Pi base and coding profiles from yzua; pi-home is not installed.
_: {
  imports = [ ./pi-coding ];

  # yzua passes this through flake.nix; same value here.
  _module.args.setup.pi.webSearch = {
    provider = "codex-lb";
    model = "gpt-5.6-sol";
  };
}

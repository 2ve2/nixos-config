# Run Codex-LB (ChatGPT account proxy) on this computer only.
{ codexLbPackage, lib, ... }:
{
  home.packages = [ codexLbPackage ];

  systemd.user.services.codex-lb = {
    Unit.Description = "Codex-LB ChatGPT account proxy";
    Service = {
      ExecStart = "${lib.getExe codexLbPackage} --host 127.0.0.1 --port 2455";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "default.target" ];
  };
}

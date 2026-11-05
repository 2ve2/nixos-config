_:

{
  # Keep remote administration available after the temporary bootstrap exits.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "lord2ve" ];
    };
  };
}

{ lib, ... }:

{
  # Numtide cache: prebuilt AI coding tools from llm-agents.nix
  nix.settings.substituters = lib.mkAfter [ "https://cache.numtide.com" ];
  nix.settings.trusted-public-keys = [
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
  ];
}

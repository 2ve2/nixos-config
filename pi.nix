# Pi base, coding and RE profiles; pi-home is not installed.
{ pkgs, ... }:
let
  setup = {
    pi = {
      webSearch = {
        provider = "codex-lb";
        model = "gpt-5.6-sol";
      };
      research = {
        maxConcurrent = 2;
        defaultTimeoutSeconds = 600;
        maxTimeoutSeconds = 1800;
      };
    };
    androidLab = {
      acceptLicense = true;
      apiLevel = "35";
      imageType = "google_apis";
      abi = "x86_64";
      avdName = "pi-re-api35";
      port = 5580;
      cores = 4;
      memoryMiB = 4096;
      bootTimeoutSeconds = 180;
      gpuMode = "swangle";
      hardwareVideoDecoder = false;
      display = {
        width = 720;
        height = 1600;
        density = 320;
      };
      proxyPort = 8089;
    };
  };
in
{
  imports = [
    ./pi-coding
    ./pi-re
  ];

  _module.args = {
    inherit setup;
    androidTools = import ./packages/android-re-toolchain {
      inherit pkgs;
      inherit (setup) androidLab;
    };
    reaTools = import ./packages/rea { inherit pkgs; };
  };
}

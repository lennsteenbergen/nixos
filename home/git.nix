{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    signing = {
      key = "D097C4C349922AC4";
      signByDefault = true;
    };

    settings = {
      user.name = "Lenn Steenbergen";
      user.email = "ltjst@proton.me";
      pull.rebase = true;
      init.defaultBranch = "main";

      credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";

      "credential \"https://github.com\"".username = "lennsteenbergen";
      "credential \"https://git.lennsteenbergen.dev\"".username = "lennsteenbergen";
    };
  };
}

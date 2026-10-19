{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull; # plain pkgs.git is enough unless you need extras like gitk or send-email

    signing = {
      key = "D097C4C349922AC4";
      signByDefault = true;
    };

    settings = {
      user.name = "Lenn Steenbergen";
      user.email = "ltjst@proton.me";
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}

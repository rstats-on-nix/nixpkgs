let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/refs/heads/r-daily.tar.gz") {};
 system_packages = builtins.attrValues {
  inherit (pkgs) R quarto glibcLocalesUtf8 nix;
};
 r_packages = builtins.attrValues {
  inherit (pkgs.rPackages)
    ALDEx2
     Boom
     cubature
     FlexReg
     OpenMx
    VariantAnnotation
    arrow
    cbq
    data_table
    duckdb
    glmmrBase
    mlpack
    multinma
    networkscaleup
    psBayesborrow
    qeML
     rJava
     readxl
    rts2
    s2
    seqtrie
    tidyverse
    Rcpp
    blavaan
    codetools
    collapse
     devtools
     fixest
     geos
     gpboost
     httr
     igraph
     jsonlite
     knitr
     mikropml
     quarto
     rmarkdown
     rstanarm
     sf
     stars
     stringi
     sys
    terra
    testthat
    vapour
;
};
 wrapped_pkgs = pkgs.rstudioWrapper.override {
  packages = [  r_packages ];
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ system_packages r_packages wrapped_pkgs ];

  }

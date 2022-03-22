{
  description = ''A cure for the lack of package-level visibility in Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-package_visible_types-master.flake = false;
  inputs.src-package_visible_types-master.owner = "zah";
  inputs.src-package_visible_types-master.ref   = "master";
  inputs.src-package_visible_types-master.repo  = "nim-package-visible-types";
  inputs.src-package_visible_types-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-package_visible_types-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-package_visible_types-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
with (import <nixpkgs> {});
with (import <nixos> {});

{inherit 
    # nixie automatically inserts things 
    # between the comments \BEGIN_NIXIE_MANAGED
    # and \END_NIXIE_MANAGED. (without leading slashes)

    # BEGIN_NIXIE_MANAGED
    # END_NIXIE_MANAGED
;}

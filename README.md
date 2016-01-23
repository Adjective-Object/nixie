# nixie
A bash script for managing a nix user-env file in a semi-stateless way

# Installation
copy the example-packags.nix file to `~/.nixpkgs/packages.nix`. Optionally
you can change the location of this file by setting the `NIXIE_PACKAGES_FILE`
environemnt variable 

# Usage

`nixie install <packagename>` : adds a package to the user's packages file
and tries to install it. On failure it reverts any changes to the packages
file

`nixie install` : reinstalls the user's packages file

`nixie remove <packagename>` / 
`nixie delete <packagename>` /`
 nixie uninstall <packagename>` : Tries to remove a package from the user's
 packages file. If the package is not found, it removes it

 `nixie list` : lists the installed packages

## User Packages File
Nixie keeps track of the user's installed packages in a packages file,
with the format

    with (import <nixpkgs> {});
    with (import <nixos> {});
    ...
    {inherit
        # a list of packages managed by nixie
        # this is the only area of the file that running
        # nixie should edit
        # BEGIN_NIXIE_MANAGED
        gnumake
        gnutls
        ...
        # END_NIXIE_MANAGED

        # manually installed packages go here   
    ;}

nixie uses direct text manipulation to insert/remove package names
between the `NIXIE_MANAGED` comments, and tries to install the
environment with `nix-env -f <NIXIE_PACKAGES_FILE> -i`. On failue
it reverts any changes it makes.

to change the location of your user packages file, you must set the
environment variable `$NIXIE_PACKAGES_FILE`. It defaults to 
`$HOME/.nixpkgs/packages.nix`

# Known Shortcomings
 - nixie relies on direct text manipulation so it can't
 - because of the format of the user packages file, nixie cannot
    automatically install by attribute path. In this situation you should
    install manually outside the BEGIN_NIXIE_MANAGED and 
    END_NIXIE_MANAGED fences using a name binding, i.e.

            let pyton27_webSocket_Client =
                    (python27Packages.websocket_client);
            in {inherit 
                ...
            ;}



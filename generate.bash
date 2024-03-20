#!/bin/bash
TINYTEX_VERSION="2024.03.13"
TEXDIR="vtex"

TINYTEX_URL="https://github.com/rstudio/tinytex-releases/releases/download/v$TINYTEX_VERSION/TinyTeX-0-v$TINYTEX_VERSION"

# download and extract TinyTeX
rm -rf "$TEXDIR"
wget --progress=dot:giga -O- "${TINYTEX_URL}.tar.gz" | tar -xzC "./"
mv ".TinyTeX" "$TEXDIR"

# add TinyTeX to PATH
cd $TEXDIR/bin/*/
export PATH="$(pwd):$PATH"
cd -

# update self
tlmgr update --self

# install requred
tlmgr install latex-bin tools kvoptions etoolbox pdftexcmds infwarerr everysel parskip hyperref geometry sectsty ragged2e enumitem fontawesome xifthen ifmtarg inter xkeyval fontaxes greek-fontenc ly1 cbfonts ec

# package into final archive
tar -czf "vtex.tar.gz" "${TEXDIR}" && echo "vtex.tar.gz generated (exit: $?)" || echo "vtex.tar.gz generation failed (exit: $?)"

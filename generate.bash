#!/bin/bash
TINYTEX_VERSION="2025.12"
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
tlmgr install latex-bin tools fontspec kvoptions etoolbox pdftexcmds infwarerr parskip hyperref geometry sectsty ragged2e enumitem fontawesome xifthen ifmtarg inter xkeyval

# generate font names database for lualatex (speedup generation later)
luaotfload-tool --update && echo "LuaLaTeX font database generated (exit: $?)" || echo "LuaLaTeX font database generation failed (exit: $?)"

# package into final archive
tar -czf "vtex.tar.gz" "${TEXDIR}" && echo "vtex.tar.gz generated (exit: $?)" || echo "vtex.tar.gz generation failed (exit: $?)"

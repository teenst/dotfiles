#!/bin/sh

cd `dirname $0`
DOTFILEDIR=`pwd`

FILES=".emacs.d .gitconfig .gitignore .screenrc .zshrc"

for f in $FILES; do
    ln -s ${DOTFILEDIR}/${f} ${HOME}/${f}
done

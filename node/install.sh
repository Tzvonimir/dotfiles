if test ! $(which spoof)
then
  if test $(which npm)
  then
    sudo npm install spoof -g
  fi
fi
if test ! $(which intelephense)
then
  if test $(which npm)
  then
    sudo npm install intelephense -g
  fi
fi

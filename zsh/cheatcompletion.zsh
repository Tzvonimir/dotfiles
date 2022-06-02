# cheat autocompletion;
_cmpl_cheat() {
reply=($(cheat -l | cut -d' ' -f1))
}
compctl -K _cmpl_cheat cheat

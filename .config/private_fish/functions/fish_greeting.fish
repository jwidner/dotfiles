# MOTD
function fish_greeting
set_color brblack
printf "c-f  Move forward\n"
printf "c-b  Move backward\n"
printf "c-p  Move up\n"
printf "c-n  Move down\n"
printf "c-a  Jump to beginning of line\n"
printf "c-e  Jump to end of line\n"
printf "c-d  Delete forward\n"
printf "c-h  Delete backward\n"
printf "c-k  Delete forward to end of line\n"
printf "c-u  Delete entire line\n"
set_color normal
end

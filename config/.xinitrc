# Magic for now
xrdb -merge ~/.Xresources

# Set the key repeat delay and Hz
# 250 ms delay
# 30 Hz key repeat
xset r rate 250 30

# Start my bg
~/.fehbg

# Set input clicks
xinput set-prop "ASUE120A:00 04F3:319B Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "ASUE120A:00 04F3:319B Touchpad" "libinput Natural Scrolling Enabled" 1

# Start my wm
exec i3


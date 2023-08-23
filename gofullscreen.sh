#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
emergfile=$SCRIPT_DIR/gofullscreen.txt
echo "Gofullscreen active, delete this file to stop" > $emergfile
echo "Getting focused window in 5 seconds for autofullscreen"
echo "Please focus the desired window"
sleep 5
#windowls=$(xprop -root | awk '/NET_CLIENT_LIST_STACKING\(WINDOW\)/ {gsub(",",""); for(i=5;i<=NF;i++){printf "%s\n", strtonum( $i )}}')
#desktop=$(echo "$windowls" | head -1)
fullscreenwin=$(xdotool getactivewindow)
echo "Detected window with id $fullscreenwin"
echo "Window Title \"$(xdotool getwindowname $fullscreenwin)\""
echo "Going into fullscreen loop press Crtl+C to exit"
echo "-----------------------------------------------"
echo ""
fuller=0
while true
do
    xdotool getwindowname $fullscreenwin > /dev/null
    if [[ $? == 1 || ! -f $emergfile ]]
    then
        exit
    fi
    if [[ $(xprop -id $(echo $fullscreenwin | awk '{printf("0x%x\n",$1)}') | awk '/_NET_WM_STATE_FULLSCREEN/ {print $3}') ]]
    then
        echo -ne ""
    else
        if [[ $fuller -lt 2 ]]
        then
            fuller=3
        else
            fuller=$((fuller+101))
        fi
        echo Going fullscreen for $fullscreenwin
        icords=$(xdotool getwindowgeometry $(xdotool getactivewindow) | awk '/Position/ || /Geometry/ {gsub(","," ");gsub("x"," ");printf $2 " " $3 " "}')
        clickx=$(echo $icords | awk '{print $1+($3/2)}')
        clicky=$(echo $icords | awk '{print $2+($4/2)}')
        xdotool mousemove $clickx $clicky click --repeat 2 --delay 200 1 # Dobble clicks on video player to make it go into fullscreen
    fi
    if [[ $fuller == 1 ]] #This runs if going fullscreen was successful
    then
        echo "Going into fullscreen on $fullscreenwin was a success"
        stat=$(playerctl status)
        playme=0
        while [[ $stat != "Playing" ]] # check if the player starts autoplay
        do
            echo "Trying to play $fullscreenwin"
            xdotool mousemove $clickx $clicky click 1 # if there is no autoplay or is not working click once to start the media player
            sleep 1
            xdotool getwindowname $fullscreenwin > /dev/null
            if [[ $? == 1 || ! -f $emergfile ]]
            then
                exit
            fi
            playme=$((playme+1))
            if [[ $playme -gt 20 ]]
            then
                echo "Found nothing to play, skipping autoplay"
                break
            fi
            stat=$(playerctl status)
        done
        echo "Starting media player on $fullscreenwin was a success"
        acords=$(xdotool getwindowgeometry $(xdotool getactivewindow) | awk '/Position/ || /Geometry/ {gsub(","," ");gsub("x"," ");printf $2 " " $3 " "}')
        movex=$(echo $acords | awk '{print $1+$3}')
        movey=$(echo $acords | awk '{print $2+($4/2)}') #Half of window hight to avoid common pannels
        xdotool mousemove $movex $movey # move mouse out of the way
        xdotool windowactivate $fullscreenwin # window to make pannels go invisible (might not be nessesary on some setups)
        echo "Focused window and moved mouse out of the way"
        echo ""
        fuller=0
    elif [[ $fuller -gt 1 ]]
    then
        if [[ $fuller == 2 ]]
        then
            fuller=1
        elif [[ $fuller -lt 102 ]]
        then
            fuller=2
        else
            fuller=$((fuller-100))
        fi
        if [[ $fuller == 10 ]]
        then
            echo "Video player unresponsive, reloading with F5"
            xdotool key F5
            sleep 3
        elif [[ $fuller == 20 ]]
        then
            echo "Video player unresponsive, reloading with F5"
            xdotool key F5
            sleep 3
        elif [[ $fuller == 40 ]]
        then
            echo "Video player unresponsive, reloading with F5"
            xdotool key F5
            sleep 3
        elif [[ $fuller -gt 70 ]]
        then
            echo "User left pc exiting"
            exit
            fuller=70
        fi
    fi
    sleep 1
done

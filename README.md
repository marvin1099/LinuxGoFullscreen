# LinuxGoFullscreen Main
https://codeberg.org/marvin1099/LinuxGoFullscreen  
https://codeberg.org/marvin1099/LinuxGoFullscreen#description  
https://codeberg.org/marvin1099/LinuxGoFullscreen#install  
https://codeberg.org/marvin1099/LinuxGoFullscreen#important  

# LinuxGoFullscreen Backup
https://github.com/marvin1099/LinuxGoFullscreen  
https://github.com/marvin1099/LinuxGoFullscreen#description  
https://github.com/marvin1099/LinuxGoFullscreen#install  
https://github.com/marvin1099/LinuxGoFullscreen#important  

# Description
A other simple script that was just sitting on my drive.  
It will auto full screen a browser video player,  
on a window you focused at the start of the script,  
by double clicking on it.   

# Install
Get the script from  
https://codeberg.org/marvin1099/LinuxGoFullscreen/releases  
Or get it from  
https://github.com/marvin1099/LinuxGoFullscreen/releases  
Put the "gofullscreen.sh" script anywhere you want  
Then you just run it in a terminal window so you can easily close it.  
The script will wait 5 seconds,  
then get the active window and   
try to double click on it to make it go into fullscreen.  
On successful fullscreen the script will check if media is playing.  
If no media is playing it will click once more to make it start playing.  

# Important
The script might take away your controls.  
That is why you should ran the script in the terminal so you can easily close it.  
If you cant get to the terminal or accidentally ran the script in the backround,  
than you can also delete the emergency file "gofullscreen.txt",  
the script will create that file in the script directory at script startup and   
will close as soon as this file has gone missing.  


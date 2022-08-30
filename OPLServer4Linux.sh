#!/bin/sh

#                @%*+=:.                 
#                @@@@@@@@*=.             
#                @@@@@#*%@@@%-           
#                @@@@@+  #@@@@=          
#                @@@@@+  #@@@@@          
#                @@@@@+  #@@@@@          
#                @@@@@+  #@@@@+          
#                @@@@@+  .+**-           
#        :=+*#%= @@@@@+   .:-=+++=-.     
#   .=*%@@@@@%#- @@@@@+ %@@@@@%#*%@@%+.  
#  +@@@@#-:.   . @@@@@+ +=:.    :=#@@@%  
#  =@@@@@%%%@@@+ @@@@@=   :-+#@@@@%*=:   
#    .-=+++++=-. @@@@@=.%@@@@%*=:        
#                 :=*%=.*+-.       
#
#	      OPLServer4Linux
#

wine=false
wget=false
tar=false

tmp=/tmp/oplserver4linux
serverdir=$HOME/.local/share/oplserver4linux
prefix=$HOME/.local/share/oplserver4linux/wineprefix
autostart=$HOME/.config/autostart
applications=$HOME/.local/share/applications
icons=$HOME/.local/share/icons/hicolor/64x64/apps

desktop="[Desktop Entry]\nVersion=1.1\nType=Application\nName=OPLServer\nIcon=icon64\nExec=$HOME/.local/share/oplserver4linux/opl.sh\nActions=\nCategories=Game;\nStartupWMClass=oplserver.exe"

executable='#!/bin/sh \nIsRunning=$( ps -d | grep -c OPLServer.exe ) \nif [ $IsRunning -ne 0 ]; then \nzenity --info --text="O OPLServer já está em execução" \nelse \nserverdir=$HOME/.local/share/oplserver4linux \nprefix=$HOME/.local/share/oplserver4linux/wineprefix \nWINEPREFIX=$prefix wine $serverdir/OPLServer.exe /SILENT /HIDE /NOLOG /START\nfi'

#Verificar comandos
cmdtest() {
	cmdexist=$( command -v $1 )
	if [ $cmdexist ]; then
	   echo "$1 installed"
	else
	   echo "$1 is not installed."
	fi
}

#Verificar se as dependencias estão instaladas

cmdtest wine
cmdtest wget
cmdtest tar

 activity=$(zenity --list \
  --title="OPLServer4Linux" \
  --radiolist="Activities" --column="" --column="" \
    1 "Install" \
    2 "Enable Autostart" \
    3 "Disable Autostart" \
    4 "Remove" \
)

case "$activity" in

    "Install")
    mkdir $tmp
    cd $tmp
    wget "https://github.com/elmariolo/OPL-Server/releases/download/v2.0/v2.0.2022-08-24.tar"
    wget -P $icons "https://raw.githubusercontent.com/elmariolo/OPL-Server/master/OPL_Server/OPLServer/icon64.png"
    
    if [ $? -eq 0 ]; then
    	mkdir $serverdir
    	tar -xf v2.0.2022-08-24.tar -C $serverdir
    	
    	if [ $? -eq 0 ]; then
    		WINEPREFIX=$prefix winepath
    		rm $applications/OPLServer4Linux.desktop
    		mkdir $applications
    		echo -e $executable >> $serverdir/opl.sh
    		chmod +x $serverdir/opl.sh
    		echo -e $desktop >> $applications/OPLServer4Linux.desktop
    		xdg-icon-resource forceupdate
    		zenity --info --text="OPLServer4Linux instalado com sucesso."
    		#WINEPREFIX=$prefix wine $serverdir/OPLServer.exe
    	else
    		zenity --info --text="Falha na extração do aquivo"
    	fi
    	
    else
    	zenity --info --text="Falha no download do OPLServer"
    fi
    ;;
    
    "Enable Autostart")
    rm $autostart/OPLServer4Linux.desktop
    mkdir $autostart
    echo -e $desktop >> $autostart/OPLServer4Linux.desktop
    zenity --info --text="OPLServer4Linux autostart enabled."
    ;;
    
    "Disable Autostart")
    rm $autostart/OPLServer4Linux.desktop
    zenity --info --text="OPLServer4Linux autostart disabled."
    ;;
    
    "Remove")
    pkill OPLServer.exe
    rm -R $tmp
    rm -R $serverdir
    rm $autostart/OPLServer4Linux.desktop
    rm $applications/OPLServer4Linux.desktop
    rm $icons/icon64.png
    zenity --info --text="OPLServer4Linux Removido com sucesso."
    ;;
    
esac

#echo fim

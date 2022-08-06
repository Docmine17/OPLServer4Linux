#!/bin/bash
                         
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
cd '/mnt/Disco (D)/Aplicativos/Roms/Sony - PS2/'
Xvfb :9 -screen 0 1024x768x16 | DISPLAY=:9 flatpak run --env='WINEPREFIX=/mnt/Disco (D)/Aplicativos/Roms/Sony - PS2/.wine4opl' org.winehq.Wine '/mnt/Disco (D)/Aplicativos/Roms/Sony - PS2/OPLServer.exe' /START /NOLOG

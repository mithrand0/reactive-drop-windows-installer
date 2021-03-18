;NSIS Modern User Interface
;Multilingual Script

!pragma warning error all

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

  !define MUI_ICON "assets/logo.ico"
  !define MUI_HEADERIMAGE_BITMAP "assets/logo.bmp"

;--------------------------------
;General

  ;Properly display all languages (Installer will not work on Windows 95, 98 or ME!)
  Unicode true

  ;Show details by default
  ShowInstDetails show

  ;Name and file
  !define APPNAME "Dedicated Server"
  !define COMPANYNAME "Reactive Drop"
  !define DESCRIPTION "Alien Swarm: Reactive Drop - Dedicated Server"
  !define VERSIONMAJOR 1
  !define VERSIONMINOR 0
  !define VERSIONBUILD 0
  !define INSTALLSIZE 4194304

  Name "${COMPANYNAME} - ${APPNAME}"
  OutFile "RD-Server-Installer.exe"

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\Reactive-Drop-Server"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Reactive Drop Dedicated Server" ""

  ;Request application privileges for Windows Vista and higher
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

  ;Show all languages, despite user's codepage
  !define MUI_LANGDLL_ALLLANGUAGES

  ; file reservation
  ReserveFile "options.ini"

  Var name
  Var port
  Var players
  Var spectators

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU"
  !define MUI_LANGDLL_REGISTRY_KEY "Software\Reactive Drop Dedicated Server"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "assets\steam-license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  Page custom SetCustom ValidateCustom ": Intallation Options"
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_LICENSE "assets\steam-license.txt"
  !insertmacro MUI_UNPAGE_COMPONENTS
  !insertmacro MUI_UNPAGE_DIRECTORY
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English" ; The first language is the default language
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Spanish"
  !insertmacro MUI_LANGUAGE "SpanishInternational"
  !insertmacro MUI_LANGUAGE "SimpChinese"
  !insertmacro MUI_LANGUAGE "TradChinese"
  !insertmacro MUI_LANGUAGE "Japanese"
  !insertmacro MUI_LANGUAGE "Korean"
  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "Swedish"
  !insertmacro MUI_LANGUAGE "Norwegian"
  !insertmacro MUI_LANGUAGE "NorwegianNynorsk"
  !insertmacro MUI_LANGUAGE "Finnish"
  !insertmacro MUI_LANGUAGE "Greek"
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "Portuguese"
  !insertmacro MUI_LANGUAGE "PortugueseBR"
  !insertmacro MUI_LANGUAGE "Polish"
  !insertmacro MUI_LANGUAGE "Ukrainian"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "Slovak"
  !insertmacro MUI_LANGUAGE "Croatian"
  !insertmacro MUI_LANGUAGE "Bulgarian"
  !insertmacro MUI_LANGUAGE "Hungarian"
  !insertmacro MUI_LANGUAGE "Thai"
  !insertmacro MUI_LANGUAGE "Romanian"
  !insertmacro MUI_LANGUAGE "Latvian"
  !insertmacro MUI_LANGUAGE "Macedonian"
  !insertmacro MUI_LANGUAGE "Estonian"
  !insertmacro MUI_LANGUAGE "Turkish"
  !insertmacro MUI_LANGUAGE "Lithuanian"
  !insertmacro MUI_LANGUAGE "Slovenian"
  !insertmacro MUI_LANGUAGE "Serbian"
  !insertmacro MUI_LANGUAGE "SerbianLatin"
  !insertmacro MUI_LANGUAGE "Arabic"
  !insertmacro MUI_LANGUAGE "Farsi"
  !insertmacro MUI_LANGUAGE "Hebrew"
  !insertmacro MUI_LANGUAGE "Indonesian"
  !insertmacro MUI_LANGUAGE "Mongolian"
  !insertmacro MUI_LANGUAGE "Luxembourgish"
  !insertmacro MUI_LANGUAGE "Albanian"
  !insertmacro MUI_LANGUAGE "Breton"
  !insertmacro MUI_LANGUAGE "Belarusian"
  !insertmacro MUI_LANGUAGE "Icelandic"
  !insertmacro MUI_LANGUAGE "Malay"
  !insertmacro MUI_LANGUAGE "Bosnian"
  !insertmacro MUI_LANGUAGE "Kurdish"
  !insertmacro MUI_LANGUAGE "Irish"
  !insertmacro MUI_LANGUAGE "Uzbek"
  !insertmacro MUI_LANGUAGE "Galician"
  !insertmacro MUI_LANGUAGE "Afrikaans"
  !insertmacro MUI_LANGUAGE "Catalan"
  !insertmacro MUI_LANGUAGE "Esperanto"
  !insertmacro MUI_LANGUAGE "Asturian"
  !insertmacro MUI_LANGUAGE "Basque"
  !insertmacro MUI_LANGUAGE "Pashto"
  !insertmacro MUI_LANGUAGE "ScotsGaelic"
  !insertmacro MUI_LANGUAGE "Georgian"
  !insertmacro MUI_LANGUAGE "Vietnamese"
  !insertmacro MUI_LANGUAGE "Welsh"
  !insertmacro MUI_LANGUAGE "Armenian"
  !insertmacro MUI_LANGUAGE "Corsican"
  !insertmacro MUI_LANGUAGE "Tatar"
  !insertmacro MUI_LANGUAGE "Hindi"

;--------------------------------
;Reserve Files

  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.

  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Installer Sections
Section "Dedicated Server" Server

  ;Installation path
  SetOutPath "$INSTDIR"
  SetOverwrite ifdiff

  ;Download SteamCMD
  IfFileExists "$INSTDIR/steamcmd.zip" +2
  NSISdl::download "https://media.steampowered.com/installer/steamcmd.zip" "$INSTDIR/steamcmd.zip"

  ;Extract
  IfFileExists "$INSTDIR/steamcmd.exe" +2
  nsExec::ExecToLog '"powershell.exe" Expand-Archive "$INSTDIR/steamcmd.zip" "$INSTDIR"'

  ;Delete the zip
  Delete "$INSTDIR/steamcmd.zip"

  ;Install server
  nsExec::ExecToLog '"$INSTDIR/steamcmd.exe" +login anonymous +force_install_dir server +app_update 582400 validate +quit'

  ;Write server configs
  File /r "server"
  File /r "assets"

  ;Retrieve server options
  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 2" "State"
  StrCpy $name "$R0"
  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 6" "State"
  StrCpy $port "$R0"
  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 9" "State"
  StrCpy $players "$R0"
  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 11" "State"
  StrCpy $spectators "$R0"

  ;Write them
  FileOpen $0 "$INSTDIR\start-server.ps1" w
  FileWrite $0 `$$arguments = '-game reactivedrop -console -ip 0.0.0.0 -nohltv -nomessagebox -nocrashdialog -port $port +con_logfile console.log -maxplayers $spectators +rd_max_marines $players +hostname "$name" +exec server.cfg'$\r$\n`
  FileWrite $0 `$$host.UI.RawUI.WindowTitle = "Reactive Drop Server Watchdog"$\r$\n`
  FileWrite $0 `while($$true)$\r$\n`
  FileWrite $0 '{$\r$\n'
  FileWrite $0 `  Write-output "Server starting at: $$(Get-Date)"$\r$\n`
  FileWrite $0 `  Start-Process "server\srcds.exe" -ArgumentList $$arguments -Wait$\r$\n`
  FileWrite $0 `  Write-output "Server crashed or shutdown at: $$(Get-Date)"$\r$\n`
  FileWrite $0 `  Timeout /T 5$\r$\n`
  FileWrite $0 `}$\r$\n`
  FileClose $0

  ;Start Menu
  createDirectory "$SMPROGRAMS\${COMPANYNAME}"
  createShortCut "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk" "powershell.exe" "$INSTDIR\start-server.ps1" "$INSTDIR\assets\logo.ico"

  ;Store installation folder
  WriteRegStr HKCU "Software\Reactive Drop Dedicated Server" "" "$INSTDIR"

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ;Registry information for add/remove programs
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayName" "${COMPANYNAME} - ${APPNAME} - ${DESCRIPTION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\assets\logo.ico$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "Publisher" "$\"${COMPANYNAME}$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayVersion" "$\"${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}$\""
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMinor" ${VERSIONMINOR}

  ;There is no option for modifying or repairing the install
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoRepair" 1

  ;Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "EstimatedSize" ${INSTALLSIZE}

  ;Wait
  Sleep 1000

SectionEnd

;--------------------------------
;Installer Functions
Function SetCustom

  WriteINIStr $PLUGINSDIR\options.ini "Field 2" "State" "My First Reactive Drop Server"
  WriteINIStr $PLUGINSDIR\options.ini "Field 6" "State" "27050"
  WriteINIStr $PLUGINSDIR\options.ini "Field 9" "State" "4"
  WriteINIStr $PLUGINSDIR\options.ini "Field 11" "State" "4"


  ;Display the Install Options dialog
  Push $R0
  InstallOptions::dialog $PLUGINSDIR\options.ini
  Pop $R0

FunctionEnd

Function ValidateCustom

  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 2" "State"
  StrCmp $R0 "" 0 +3
    MessageBox MB_ICONEXCLAMATION|MB_OK "Please enter a valid server name"
    Abort

  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 6" "State"
  StrCmp $R0 "" 0 +3
    MessageBox MB_ICONEXCLAMATION|MB_OK "Please enter a valid server port"
    Abort

  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 9" "State"
  StrCmp $R0 "" 0 +3
    MessageBox MB_ICONEXCLAMATION|MB_OK "Please enter a valid number of players"
    Abort

  ReadINIStr $R0 "$PLUGINSDIR\options.ini" "Field 11" "State"
  StrCmp $R0 "" 0 +3
    MessageBox MB_ICONEXCLAMATION|MB_OK "Please enter a valid number of spectators"
    Abort

FunctionEnd

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY
  SectionSetSize ${Server} 4194304

  InitPluginsDir
  File /oname=$PLUGINSDIR\options.ini options.ini
FunctionEnd

;--------------------------------
;Descriptions

  ;USE A LANGUAGE STRING IF YOU WANT YOUR DESCRIPTIONS TO BE LANGAUGE SPECIFIC

  ;Assign descriptions to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${Server} "Dedicated Server"
  !insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
;Uninstaller Section

Section "Uninstall"

  Delete "$INSTDIR\Uninstall.exe"
  RMDir /r "$INSTDIR"

  ;Remove Start Menu launcher
  delete "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk"
  ;Try to remove the Start Menu folder - this will only happen if it is empty
  rmDir "$SMPROGRAMS\${COMPANYNAME}"

  DeleteRegKey /ifempty HKCU "Software\Reactive Drop Dedicated Server"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"
SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE

FunctionEnd

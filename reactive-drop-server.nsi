;NSIS Modern User Interface
;Multilingual Script

!pragma warning error all


;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  !include "nsDialogs.nsh"

  !define MUI_ICON "assets/logo.ico"
  !define MUI_HEADERIMAGE_BITMAP "assets/logo.bmp"

;--------------------------------
;General

  ;Properly display all languages (Installer will not work on Windows 95, 98 or ME!)
  Unicode true

  ;Show details by default
  ShowInstDetails show

  ;Name and file
  Name "Reactive Drop - Dedicated Server"
  OutFile "RD-installer.exe"

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

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU"
  !define MUI_LANGDLL_REGISTRY_KEY "Software\Reactive Drop Dedicated Server"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE ".\LICENSE"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_LICENSE ".\LICENSE"
  !insertmacro MUI_UNPAGE_COMPONENTS
  !insertmacro MUI_UNPAGE_DIRECTORY
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English" ; The first language is the default language
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "German"
  ; !insertmacro MUI_LANGUAGE "Spanish"
  ; !insertmacro MUI_LANGUAGE "SpanishInternational"
  ; !insertmacro MUI_LANGUAGE "SimpChinese"
  ; !insertmacro MUI_LANGUAGE "TradChinese"
  ; !insertmacro MUI_LANGUAGE "Japanese"
  ; !insertmacro MUI_LANGUAGE "Korean"
  ; !insertmacro MUI_LANGUAGE "Italian"
  ; !insertmacro MUI_LANGUAGE "Dutch"
  ; !insertmacro MUI_LANGUAGE "Danish"
  ; !insertmacro MUI_LANGUAGE "Swedish"
  ; !insertmacro MUI_LANGUAGE "Norwegian"
  ; !insertmacro MUI_LANGUAGE "NorwegianNynorsk"
  ; !insertmacro MUI_LANGUAGE "Finnish"
  ; !insertmacro MUI_LANGUAGE "Greek"
  ; !insertmacro MUI_LANGUAGE "Russian"
  ; !insertmacro MUI_LANGUAGE "Portuguese"
  ; !insertmacro MUI_LANGUAGE "PortugueseBR"
  ; !insertmacro MUI_LANGUAGE "Polish"
  ; !insertmacro MUI_LANGUAGE "Ukrainian"
  ; !insertmacro MUI_LANGUAGE "Czech"
  ; !insertmacro MUI_LANGUAGE "Slovak"
  ; !insertmacro MUI_LANGUAGE "Croatian"
  ; !insertmacro MUI_LANGUAGE "Bulgarian"
  ; !insertmacro MUI_LANGUAGE "Hungarian"
  ; !insertmacro MUI_LANGUAGE "Thai"
  ; !insertmacro MUI_LANGUAGE "Romanian"
  ; !insertmacro MUI_LANGUAGE "Latvian"
  ; !insertmacro MUI_LANGUAGE "Macedonian"
  ; !insertmacro MUI_LANGUAGE "Estonian"
  ; !insertmacro MUI_LANGUAGE "Turkish"
  ; !insertmacro MUI_LANGUAGE "Lithuanian"
  ; !insertmacro MUI_LANGUAGE "Slovenian"
  ; !insertmacro MUI_LANGUAGE "Serbian"
  ; !insertmacro MUI_LANGUAGE "SerbianLatin"
  ; !insertmacro MUI_LANGUAGE "Arabic"
  ; !insertmacro MUI_LANGUAGE "Farsi"
  ; !insertmacro MUI_LANGUAGE "Hebrew"
  ; !insertmacro MUI_LANGUAGE "Indonesian"
  ; !insertmacro MUI_LANGUAGE "Mongolian"
  ; !insertmacro MUI_LANGUAGE "Luxembourgish"
  ; !insertmacro MUI_LANGUAGE "Albanian"
  ; !insertmacro MUI_LANGUAGE "Breton"
  ; !insertmacro MUI_LANGUAGE "Belarusian"
  ; !insertmacro MUI_LANGUAGE "Icelandic"
  ; !insertmacro MUI_LANGUAGE "Malay"
  ; !insertmacro MUI_LANGUAGE "Bosnian"
  ; !insertmacro MUI_LANGUAGE "Kurdish"
  ; !insertmacro MUI_LANGUAGE "Irish"
  ; !insertmacro MUI_LANGUAGE "Uzbek"
  ; !insertmacro MUI_LANGUAGE "Galician"
  ; !insertmacro MUI_LANGUAGE "Afrikaans"
  ; !insertmacro MUI_LANGUAGE "Catalan"
  ; !insertmacro MUI_LANGUAGE "Esperanto"
  ; !insertmacro MUI_LANGUAGE "Asturian"
  ; !insertmacro MUI_LANGUAGE "Basque"
  ; !insertmacro MUI_LANGUAGE "Pashto"
  ; !insertmacro MUI_LANGUAGE "ScotsGaelic"
  ; !insertmacro MUI_LANGUAGE "Georgian"
  ; !insertmacro MUI_LANGUAGE "Vietnamese"
  ; !insertmacro MUI_LANGUAGE "Welsh"
  ; !insertmacro MUI_LANGUAGE "Armenian"
  ; !insertmacro MUI_LANGUAGE "Corsican"
  ; !insertmacro MUI_LANGUAGE "Tatar"
  ; !insertmacro MUI_LANGUAGE "Hindi"

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
  SetOverwrite ifnewer

  ;Download SteamCMD
  IfFileExists "$INSTDIR/steamcmd.zip" +2
  NSISdl::download "https://media.steampowered.com/installer/steamcmd.zip" "$INSTDIR/steamcmd.zip"

  ;Extract
  IfFileExists "$INSTDIR/steamcmd.exe" +2
  nsExec::ExecToLog '"powershell.exe" Expand-Archive "$INSTDIR/steamcmd.zip" "$INSTDIR"'

  ;Delete the zip
  Delete "$INSTDIR/steamcmd.zip"

  ;Install server
  ;nsExec::ExecToLog '"$INSTDIR/steamcmd.exe" +login anonymous +force_install_dir server +app_update 582400 validate +quit'

  ;Install configs
  File /r "server"

  ;Store installation folder
  WriteRegStr HKCU "Software\Reactive Drop Dedicated Server" "" "$INSTDIR"

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ;Wait
  Sleep 5000

SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY
  SectionSetSize ${Server} 4194304

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

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\Reactive Drop Dedicated Server"

SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE

FunctionEnd
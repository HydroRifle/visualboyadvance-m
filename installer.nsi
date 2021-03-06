; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "VisualBoyAdvance-M"
!define PRODUCT_VERSION "2.0.0"
!define PRODUCT_PUBLISHER "visualboyadvance"
!define PRODUCT_WEB_SITE "http://vba-m.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\visualboyadvance-m.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor /SOLID lzma
XPStyle on

!packhdr tmpexe.tmp "upx --lzma -9 --compress-icons=0 tmpexe.tmp"

BrandingText "VisualBoyAdvance-M Version 2.0.0 Throttlefix"

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "x64.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE ".\doc\gpl.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\visualboyadvance-m.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "vba-m_${PRODUCT_VERSION}_setup.exe"
InstallDir "$PROGRAMFILES64\VisualBoyAdvance-M"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ${If} ${RunningX64}
    File "..\binary\x86_64\visualboyadvance-m.exe"
    CreateDirectory "$SMPROGRAMS\VisualBoyAdvance-M"
    CreateShortCut "$SMPROGRAMS\VisualBoyAdvance-M\VisualBoyAdvance.lnk" "$INSTDIR\visualboyadvance-m.exe"
    CreateShortCut "$DESKTOP\VisualBoyAdvance.lnk" "$INSTDIR\visualboyadvance-m.exe"
    File "..\binary\x86_64\vbam.exe"
  ${Else}
    File "..\binary\i686\visualboyadvance-m.exe"
    CreateDirectory "$SMPROGRAMS\VisualBoyAdvance-M"
    CreateShortCut "$SMPROGRAMS\VisualBoyAdvance-M\VisualBoyAdvance.lnk" "$INSTDIR\visualboyadvance-m.exe"
    CreateShortCut "$DESKTOP\VisualBoyAdvance.lnk" "$INSTDIR\visualboyadvance-m.exe"
    File "..\binary\i686\vbam.exe"
  ${Endif}
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\VisualBoyAdvance-M\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\VisualBoyAdvance-M\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\visualboyadvance-m.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\visualboyadvance-m.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\vbam.exe"
  Delete "$INSTDIR\visualboyadvance-m.exe"

  Delete "$SMPROGRAMS\VisualBoyAdvance-M\Uninstall.lnk"
  Delete "$SMPROGRAMS\VisualBoyAdvance-M\Website.lnk"
  Delete "$DESKTOP\VisualBoyAdvance.lnk"
  Delete "$SMPROGRAMS\VisualBoyAdvance-M\VisualBoyAdvance.lnk"

  RMDir "$SMPROGRAMS\VisualBoyAdvance-M"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

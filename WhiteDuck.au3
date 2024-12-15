#pragma compile(ExecLevel, requireAdministrator)
#pragma compile(FileDescription, WhiteDuck - a KISS evil USB blocker)
#pragma compile(ProductName, WhiteDuck)
#pragma compile(ProductVersion, 1)
#pragma compile(FileVersion, 1.0.5)
#pragma compile(LegalCopyright, © Nikos K. Kantarakias)

#RequireAdmin

#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPISys.au3>
#include <Timers.au3>
#include <FileConstants.au3>
#include <Date.au3>
#include <StringConstants.au3>
#include <TrayConstants.au3>

Opt("TrayMenuMode", 3)
TraySetState($TRAY_ICONSTATE_SHOW)
TraySetToolTip("WhiteDuck, KISS evil USB blocker." & @CRLF & "THIS WILL NOT PROTECT YOU" & @CRLF & "from delayed or more sophisticated attacks.")

; Global constants and variables
Global $HID_Device_Class = "HID" ; Identifier for HID devices in PnPEntity
Global $LOG_FILE =  @ScriptDir & "\HIDmonitor.csv"


; Open the file for writing at the end (or create it if it doesn't exist)
Local $hFile = FileOpen($LOG_FILE, $FO_APPEND)
; Check if the file was opened successfully
If $hFile = -1 Then
    MsgBox(16, "Error", "Failed to open or create the logfile.")
    Exit
EndIf


; Start monitoring USB HID devices in a separate thread
;HotKeySet("{ESC}", "_ExitScript")

; Start WMI monitoring for HID devices
Global $oWMIService = ObjGet("winmgmts:\\.\root\CIMV2")
If Not IsObj($oWMIService) Then
    MsgBox($MB_ICONERROR, "Error", "Unable to connect to WMI.")
    Exit
EndIf

Global $oEventSource = $oWMIService.ExecNotificationQuery( _
    "SELECT * FROM __InstanceCreationEvent WITHIN 1 WHERE " & _
    "TargetInstance ISA 'Win32_PnPEntity'")

AdlibRegister("_MonitorHID", 100)

While 1
    Sleep(100)
WEnd

Func _MonitorHID()
    Local $oEvent = $oEventSource.NextEvent(1000)
    If IsObj($oEvent) Then
        If StringInStr($oEvent.TargetInstance.Name, $HID_Device_Class) Then
            If StringInStr($oEvent.TargetInstance.Name, "keyboard", 0) Then
                RunWait(@ComSpec & " /c rundll32.exe user32.dll,LockWorkStation", "", @SW_HIDE)
                ; Block input with random delays
                Local $blockTime = Random(6, 12, 1) * 1000 ; Random between 6-12 seconds
                Local $allowTime = Random(8, 12, 1) * 1000 ; Random between 8-12 seconds
                Local $finalBlockTime = Random(2, 5, 1) * 1000 ; Random between 2-5 seconds
                BlockKeyboard(True) ; Block input
                Sleep($blockTime)
                BlockKeyboard(False) ; Allow input
                Sleep($allowTime)
                BlockKeyboard(True) ; Block input again
                Sleep($finalBlockTime)
                BlockKeyboard(False) ; Allow input
                FileWrite($LOG_FILE, _NowDate() & "," & _NowTime(5) & ",PC locked !" & @CRLF)
            EndIf
            FileWrite($LOG_FILE, _NowDate() & "," & _NowTime(5) & ",HID Device Detected: " & $oEvent.TargetInstance.Name & @CRLF)
        EndIf
    EndIf
EndFunc


Func BlockKeyboard($bBlock)
    If $bBlock Then
        DllCall("user32.dll", "int", "BlockInput", "int", 1) ; Block keyboard and mouse
    Else
        DllCall("user32.dll", "int", "BlockInput", "int", 0) ; Unblock keyboard and mouse
    EndIf
EndFunc



#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#singleinstance force
#UseHook, On
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, 0
SetControlDelay, 0
#IfWinExist, Path of Exile
Coordmode, Mouse, Screen
Coordmode, Pixel, Screen


; HOLD R-CTRL + CLICK = auto click
; HOLD R-CTRL + RIGHT CLICK = transfer entire inventory

DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution) ;setting the Windows Timer Resolution to 0.5ms, THIS IS A GLOBAL CHANGE

r := 1440/1080 ; resolution scale, change numerator to resolution (example 1440)

#IfWinActive ahk_class POEWindowClass

~RCtrl & LButton::
    while GetKeyState("LButton", "p") && GetKeyState("RCtrl", "p") {
        click
        DllCall("Sleep","UInt",40) ;precision sleep
    }
return

~RCtrl & RButton::
    BlockInput, MouseMove
    MouseGetPos, x, y
    MouseMove, 1305*r, 573*r
    while GetKeyState("RButton", "p") && GetKeyState("RCtrl", "p") {
        DllCall("Sleep","UInt",8) ;precision sleep
        click
        DllCall("Sleep","UInt",8) ;precision sleep
        click
        MouseGetPos, XX, YY
        if (YY >= 800*r) {
            MouseMove, XX+52*r, 625*r
        } else if (XX >= 1900*r){
            MouseMove, 1305*r, 573*r
            MouseGetPos, XX, YY
        } else {
            MouseMove, XX, YY+52*r
        }
    }
    sleep 50
    MouseMove, x, y
    BlockInput, MouseMoveOff
return
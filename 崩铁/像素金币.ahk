#Requires AutoHotkey v2.0
#Include ..\lib.ahk

; 按 Z 开启/关闭无限循环
; 步骤：
; 1. 按住 A 键 54 秒
; 2. 点按 ESC，等待 2 秒
; 3. 点击坐标 227,1440（离开二次元）
; 4. 等待 1.5 秒
; 5. 点按 F
; 6. 等待 4 秒，然后回到第 1 步

global Looping := false

CoordMode("Mouse", "Screen")

#HotIf WinActive("ahk_class UnityWndClass") && (InStr(WinGetTitle("A"), "崩坏：星穹铁道") || InStr(WinGetTitle("A"), "Honkai: Star Rail") || InStr(WinGetTitle("A"), "Star Rail"))
z:: {
    global Looping
    Looping := !Looping
    if Looping {
        ShowToast("像素金币循环已启动，按 Z 停止", 1500)
    } else {
        ShowToast("像素金币循环已停止", 1500)
    }
}
#HotIf

RunLoop() {
    global Looping
    while Looping {
        Send("{a down}")
        if (!WaitWhileRunning(54000))
            break
        Send("{a up}")
        if (!WaitWhileRunning(100))
            break

        Send("{Esc}")
        if (!WaitWhileRunning(2000))
            break

        MouseMove_Click_Sleep(227, 1440, 0)
        if (!WaitWhileRunning(1500))
            break

        Send("f")
        if (!WaitWhileRunning(4000))
            break
    }
    if (!Looping)
        Send("{a up}")
}

WaitWhileRunning(duration) {
    global Looping
    interval := 50
    endTime := A_TickCount + duration
    while A_TickCount < endTime {
        Sleep(interval)
        if (!Looping)
            return false
    }
    return true
}
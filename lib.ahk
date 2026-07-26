#Requires AutoHotkey v2.0
#SingleInstance Force
TraySetIcon("shell32.dll", 127)
A_MenuMaskKey := "vkE8"
CoordMode "Mouse", "Window"
SendMode "Input"
SetMouseDelay -1
SetKeyDelay -1, -1
SetWinDelay -1
ProcessSetPriority "High"
DllCall("winmm.dll\timeBeginPeriod", "UInt", 1)
OnExit((*) => DllCall("winmm.dll\timeEndPeriod", "UInt", 1))

; =============== 公共函数 ===============
MouseMove_Click_Sleep(x, y, sleeptime := 0, clickbutton := true) {
    MouseMove(x, y, 0)
    if (clickbutton)
        Click()
    if (sleeptime != 0)
        Sleep(sleeptime)
}

; OpenMapQuick(pointIndexValue, sleepTime := 120, pointsString := ",1,") {
;     Send("{Enter}")
;     Sleep(InStr(pointsString, "," pointIndexValue ",") ? sleepTime : 50)
;     MouseMove(226, 170, 0)
;     Send("{Escape}")
;     Sleep(40)
;     Click()
;     Send "m"
; }

; SendInputDrag(xS, yS, xE, yE, maxDeltaPerStep := 50) {
;     MouseMove(xS, yS, 0)
;     Sleep(32)
;     SendInput("{LButton Down}")
;     Sleep(32)
;     totalDX := xE - xS
;     totalDY := yE - yS
;     steps := Max(1, Ceil(Max(Abs(totalDX), Abs(totalDY)) / maxDeltaPerStep))
;     Loop steps {
;         curX := Round(xS + totalDX * A_Index / steps)
;         curY := Round(yS + totalDY * A_Index / steps)
;         MouseMove(curX, curY, 0)
;         Sleep(32)
;     }
;     Sleep(32)
;     SendInput("{LButton Up}")
;     Sleep(32)
; }

ShowToast(msg, duration := 2000) {
    static g := ""
    try g.Destroy()
    g := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
    g.BackColor := "050E1A"
    g.SetFont("s14 c60C8FF Bold", "Microsoft YaHei")
    g.Add("Text", "xm ym", msg)
    DllCall("dwmapi\DwmSetWindowAttribute", "ptr", g.Hwnd,"uint", 33, "int*", 2, "uint", 4)  ; 圆角
    g.Show("NoActivate x0 y0")
    g.GetPos(, , &w, &h)
    g.Move(A_ScreenWidth // 2 - w // 2, A_ScreenHeight // 2 - h // 2)
    SetTimer(() => (g.Destroy(), g := ""), -duration)
}

; MapMinimize(sleepTime := 24){
;     MouseMove(61, 670, 0)
;     Sleep(sleepTime - 4)
;     Click("Down")
;     Sleep(sleepTime)
;     MouseMove(61, 630, 0)
;     Sleep(sleepTime)
;     Click("Up")
;     Sleep(sleepTime)
; }

; MapMaximize(sleepTime := 24){
;     MouseMove(61, 927, 0)
;     Sleep(sleepTime - 4)
;     Click("Down")
;     Sleep(sleepTime)
;     MouseMove(61, 967, 0)
;     Sleep(sleepTime)
;     Click("Up")
;     Sleep(sleepTime)
; }

ButtonsUp(){
    Sleep(50)
    Send "{LButton Up}"
    Send "{RButton Up}"
    Send "{w up}{a up}{s up}{d up}"
    Sleep(50)
}

; =============== 只能游戏里触发 ================
; #HotIf WinActive("ahk_class UnityWndClass")
; ;饭团的号 体力药
; $`:: {
;     static busy := false
;     if busy
;         return
;     busy := true

;     BlockInput(true)
;     try {
;         Send "b"
;         ShowToast("✦ 正在吃 回复体力药(饭团)", 1100)
;         Sleep(780)
;         MouseMove(1150, 68, 0)
;         Click()
;         Sleep(330)
;         MouseMove(237, 264, 0)
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
;         Send "{Esc}"
;     } finally {
;         BlockInput(false)
;     }
;     KeyWait "``"
;     busy := false
; }

; ;调整地图大小
; $F12:: {
;     static busy := false
;     if busy
;         return
;     busy := true

;     BlockInput(true)
;     try {
;         MouseMove(53, 927, 0)
;         Sleep(20)
;         Click("Down")
;         Sleep(24)
;         MouseMove(66, 927, 0)
;         Sleep(24)
;         Click("Up")
;         Sleep(24)
;         MouseMove(60, 666, 0)
;         Loop 2 {
;             Click()
;             Sleep(32)
;         }
;     } finally {
;         BlockInput(false)
;     }
;     KeyWait "F12"
;     busy := false
; }

; ;我的号 夜兰吃的药
; $-:: {
;     static busy := false
;     if busy
;         return
;     busy := true
    
;     BlockInput(true)
;     try {
;         Send "b"
;         ShowToast("✦ 正在吃 夜兰 的药(乆刄)", 1300)
;         Sleep(780)
;         MouseMove(1150, 68, 0)
;         Click()
;         Sleep(330)
;         MouseMove(1200, 730, 0) ;第1个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
;         MouseMove(430, 1000, 0) ;第2个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
;         MouseMove(600, 1200, 0) ;第3个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
;         MouseMove(824, 494, 0) ;第4个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
;         Send "{Esc}"
;     } finally {
;         BlockInput(false)
;     }
;     KeyWait "-"
;     busy := false
; }

; ;我的号 火神吃的药
; $=:: {
;     static busy := false
;     if busy
;         return
;     busy := true
    
;     BlockInput(true)
;     try {
;         Send "b"
;         ShowToast("✦ 正在吃 火神 的药(乆刄)", 1200)
;         Sleep(780)
;         MouseMove(1150, 68, 0)
;         Click()
;         Sleep(330)
        
;         MouseMove(240, 730, 0) ;第1个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
        
;         MouseMove(432, 1188, 0) ;第2个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
        
;         Send "{Esc}"
;     } finally {
;         BlockInput(false)
;     }
;     KeyWait "="
;     busy := false
; }

; ;小美的号 恰吃的药
; $F10:: {
;     static busy := false
;     if busy
;         return
;     busy := true
    
;     BlockInput(true)
;     try {
;         Send "b"
;         ShowToast("✦ 正在吃 恰 的药(小美)", 1200)
;         Sleep(780)
;         MouseMove(1150, 68, 0)
;         Click()
;         Sleep(330)
        
;         MouseMove(433, 281, 0) ;第1个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
        
;         MouseMove(637, 300, 0) ;第2个药的位置
;         Click()
;         Sleep(32)
;         MouseMove(2218, 1500, 0)
;         Click()
;         Sleep(20)
        
;         Send "{Esc}"
;     } finally {
;         BlockInput(false)
;     }
;     KeyWait "F10"
;     busy := false
; }

; global pointIndex := 1
; global maxPoints := 1
; Left:: {
;     global pointIndex, maxPoints
;     if pointIndex > 1
;         pointIndex--
;     else
;         pointIndex := maxPoints
;     ShowToast("✦ 点位：" pointIndex " / " maxPoints, 900)
; }
; Right:: {
;     global pointIndex, maxPoints
;     if pointIndex < maxPoints
;         pointIndex++
;     else
;         pointIndex := 1
;     ShowToast("✦ 点位：" pointIndex " / " maxPoints, 900)
; }

; ;火神双码头
; global fireOn := false
; global scriptBusy := false
; XButton2:: {
;     global fireOn
;     fireOn := !fireOn
;     if fireOn {
;         SetTimer FireLoop, -1
;     } else {
;         fireOn := false
;         Send "{LButton Up}{RButton Up}"
;     }
; }
; FireLoop() {
;     global fireOn, scriptBusy
;     while fireOn {
;         if scriptBusy {
;             Sleep 100
;             continue
;         }
;         Send "{LButton Down}"
;         Sleep 205
;         Send "{RButton Down}"
;         Sleep 200
;         Send "{LButton Up}"
;         Sleep 2
;         Send "{RButton Up}"
;         Sleep 2
;         Send "{LButton Down}"
;         Sleep 160
;         Send "{RButton Down}"
;         Sleep 110
;         Send "{RButton Up}"
;         Sleep 1050
;         Send "{LButton Up}"
;         Sleep 560
;     }
;     Send "{LButton Up}{RButton Up}"
; }
#HotIf
; =============================================

; F4:: {
;     Run('"' . A_AhkPath . '" "' . A_ScriptDir . "\..\Main.ahk" . '"')
;     ExitApp
; }

; #SuspendExempt True
; F3:: {
;     Suspend
;     ShowToast(A_IsSuspended ? "脚本已暂停" : "脚本已开启", 2000)
; }
; #SuspendExempt False
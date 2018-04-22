/*
  Copyright (C) <2018>  <https://github.com/society765/yys-auto-yuhun>
    
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/



;; Include my library functions
#include functions.ahk

F10::

yqarray := []
;; read YAO QI from yaoqi.txt
loop, read, yaoqi.txt 
{
  yqarray.push(A_LoopReadLine)
}

;; TS Plugin is writen using C++, developed using VC2008, 
;;   and is open-sourced at http://bbs.tyuyan.net/thread-45659-1-1.html
;; The author acknowledges the development of TS Plugin.


;; Register the TS Plugin version 4.019

Global ts

need_ver := "4.019"
RunWait, regsvr32 /s TSPlug.dll

ts := ComObjCreate("ts.tssoft")
if (ts.ver() <> need_ver) { 
  msgbox, "register failed'
  return
}
OutputDebug, % "register succeed"


;; Binding the game emulator window, and resize it to 1136*640

hwnd := ts.FindWindow("", "阴阳师-网易游戏")
;hwnd := ts.GetMousePointWindow()
ts_ret := ts.BindWindow(hwnd,"dx2","windows","windows",0)
if (ts_ret <> 1){
  msgbox, % "binding failed"
  return
}
OutputDebug, % "binding succeed"
sleep, 2000
;ts_ret := ts.SetClientSize(hwnd, 1136, 640)
;OutputDebug, % ts_ret

;; Color debugging
coldebug := 0
while (coldebug = 0){
  tscoldebug := ts.GetColor(1, 1)
  OutputDebug, % tscoldebug
  if(tscoldebug <>"000000" and tscoldebug <> "ffffff"){
    coldebug := 1
  }
  sleep, 200
}

newstart:

WTFC1(221, 576, "cac3c0", 204, 224, 549, 612, 0, 1)  ; 点击 组队
OutputDebug, % "click ZU DUI"
mysleep(1000, 333)

; 如果有山风，鬼灯，陆生等碎片活动，妖气封印需要上移一格
FileRead, shanfengx, huodong.txt
if (shanfengx = 1) {
  SHANFENG()
}

WTFC1(285, 528, "e8d6c1", 146, 256, 541, 545, 0, 1) ; 点击 妖气封印
OutputDebug, % "click YAO QI FENG YIN"
mysleep(1000, 333)

kaishizhaoche:


REJXS()
found := 0
while (found = 0){
  mysleep(100, 100)
  REJXS()

  if (ts.CmpColor(681, 324, "ffffff", 1.0) = 1){
    CRND(378, 483, 557, 580)  ; 点击 刷新
  }
  OutputDebug, % "click SHUA XIN"

  qjx := 0
  qjxc := 0
  while (qjx = 0){
    REJXS()
    if (ts.CmpColor(681, 324, "ffffff", 1.0) = 0){
      qjx := 1  ; 正在刷新
    }
    qjxc++
    If (qjxc > 5){
      REJXS()
      if (ts.CmpColor(1039, 614, "bd8956", 1.0) = 0){
        ; 已经进入战斗, this is usually unexpected
        Goto, inthebattle
      }
      Goto, sxjs
    }
    sleep, 33
  }

  qjy := 0
  while (qjy = 0){
    REJXS()
    if (ts.CmpColor(681, 324, "ffffff", 1.0) = 1){
      qjy := 1  ; 刷新结束
    }
    sleep, 33
  }
sxjs:
  OutputDebug, % "SHUA XIN finished"
  REJXS()

  ; 找对应的妖气封印，并点击对应的加入，只能找前两排的车
  for index, element in yqarray {
    if (findyaoqi(".\imgs\" . element . "1.bmp") = 0){
      found := 1
      OutputDebug, % "found " . element . " 1"
      Goto, foundyaoqi
    }
    if (findyaoqi(".\imgs\" . element . "2.bmp") = 0){
      found := 2
      OutputDebug, % "found " . element . " 2"
      Goto, foundyaoqi
    }
  }
}

foundyaoqi:
REJXS()

if (found = 1){
  CRND(899, 967, 191, 215)
}
if (found = 2){
  CRND(899, 967, 278, 308)
}

sleep, 1000

; 判断是否上车成功
REJXS()
if (ts.CmpColor(480, 574, "f3b25e", 1.0) = 0){
  ; 上车失败
  OutputDebug, % "failed to SHANG CHE"
  Goto, kaishizhaoche
}
OutputDebug, % "SHANG CHE successfully"
; 上车成功，等待开车
sleep, 1000
kc := 0
while (kc = 0){
  REJXS()
  CRND(850, 918, 528, 538) ; 使劲点击开始战斗，为了应对房主跳车的特殊情况
  if (ts.CmpColor(697, 556, "c4bab1", 1.0) = 1){
    ; 开车成功
    OutputDebug, % "KAI CHE successfully"
    kc := 2
  }
  mysleep(333, 100)
}

; 开车成功，现在在 loading 界面，判断是否进入战斗
inthebattle:
WTFC1(1039, 614, "bd8956", 991, 1064, 465, 537, 0, 1)
; 已经点击准备，等待战斗开始
OutputDebug, % "ZHUN BEI clicked"
sleep, 5000

; 判断战斗是否开始
zcc := 0
while (zcc = 0){
  REJXS()
  if (ts.CmpColor(44, 587, "f8f3e0", 1.0) = 0){
    zcc := 1
    ; 战斗已经开始
  }
  mysleep(333, 100)
}
OutputDebug, % "battle started"
sleep, 5000

; 战斗已经开始，判断战斗是否结束
zce := 0
while (zce = 0){
  REJXS()
  if (ts.CmpColor(44, 587, "f8f3e0", 1.0) = 1){
    zce := 1
    ; 战斗已经结束
  }
  mysleep(333, 100)
}
OutputDebug, % "battle finished"
sleep, 1000

; 战斗已经结束，快速结算
jss := 0
while (jss = 0){
  REJXS()
  CRND(735, 795, 97, 147)
  if (ts.CmpColor(221, 576, "cac3c0", 1.0) = 0){
    jss := 1
    ; 结算结束，已回到庭院
  }
  mysleep(333, 100)
}

sleep, 1000
Goto, newstart

ts_ret := ts.UnBindWindow()

Return


F12:: 
  OutputDebug, % "reloading ..."
  ts_ret := ts.UnBindWindow()
  Reload
Return






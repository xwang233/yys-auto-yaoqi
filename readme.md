
# 阴阳师自动妖气脚本

网易阴阳师电脑版，Autohotkey 脚本，自动妖气封印, 已支持完全后台。

This is a script, written using Autohotkey, for automated Yao-Qi farming in Netease game Onmyoji, PC emulator version.
Now the script supports fully background running. 

## 准备工作

玩家需自行下载网易阴阳师电脑版，并登录至游戏内，不要调整窗口大小。

该脚本为本人修仙时间使用 Autohotkey 1.1.28 版本编写，玩家可以自行下载 [Autohotkey](https://autohotkey.com/)，以及所有源文件，然后运行 onmyoji_yys-auto-yaoqi.ahk。

玩家也可以下载预先编译好的可执行版本 [Releases](https://github.com/society765/yys-auto-yaoqi/releases)。

## 使用方法及功能简介

玩家需要将人物置于庭院中，然后按 F10 启动脚本。如果存在多于一个阴阳师窗口，该脚本有可能找不到正确的窗口，请修改源代码并使用 ts.GetMousePointWindow() 函数来手动选择游戏窗口。

使用了后台插件，窗口现在可以完全后台，可以被遮挡，但是不能最小化。

该脚本为组队妖气封印，搜索并加入指定妖怪的妖气封印队伍，玩家可以自己指定要打的怪物，及搜索的优先级。

该脚本会自动拒绝所有悬赏封印的邀请。

该脚本仅使用了画面找色，鼠标后台点击的函数，完全模拟人类玩家行为，没有使用任何内存读写函数。在敏感位置添加了均匀分布的随机时间漂移，和随机坐标漂移。
作者使用过该脚本上万体力仍没有收到鬼使黑来信，而且作者不对您的可能存在的任何被封禁结果负责。

玩家可以在任何时刻使用键盘快捷键结束脚本 (F12)。

感谢您使用该脚本，并欢迎各种反馈和改进意见。 

### 指定妖气封印的妖怪

玩家需要在 yaoqi.txt 文件中，指定并排列需要加入的妖气封印队伍，
该脚本将按照优先级从上到下筛选妖气封印队伍。

目前只支持 二口女，骨女，鬼使黑，海坊主，日何坊，小松丸 的妖气封印组队。

例： yaoqi.txt 文件中存在 rhf，那么脚本将尝试加入日何坊的妖气车，
前提是存在 imgs\rhf1.bmp, imgs\rhf2.bmp 图片。
rhf1.bmp 对应第一排的妖气车，rhf2.bmp 对应第二排的妖气车；
第三排及以后的妖气车概率太小，本代码并不提供挤第三排及之后的车的功能。

欢迎玩家手动截取其他妖怪对应的图片，发 PR 来完善脚本功能。

### 山风，鬼灯，陆生等活动碎片

在山风，鬼灯，陆生等活动出现时，由于有碎片副本的存在，组队列表需要上移一格才能点到妖气封印。
此时玩家需要将 huodong.txt 文件内容改为 1.
如没有碎片副本时，请将该文件内容改为 0.

在脚本上移组队列表时，请勿将鼠标在游戏窗口内移动。

## 已知存在的问题

* 当玩家使用 Windows 7 系统时，需要以管理员身份运行阴阳师游戏窗口和脚本。而且，需要调整系统的画面设置： 右键我的电脑 -> 高级系统设置 -> 高级 -> 设置 -> 取消勾选以下3项： "启用 Aero peek"，"启用透明玻璃"，和"启用桌面组合"。

* 该脚本只在 Windows 7 环境下进行了测试，欢迎对其他系统兼容性的反馈。

## 更新记录

2018年4月21日，上传了初始版本。

## 免责声明

网易，阴阳师，是网易公司的商标。 http://yys.163.com

按键精灵，是按键精灵公司的商标。 http://www.anjian.com

Autohotkey，为 GPL 开源程序。 https://autohotkey.com/

该脚本为了实现后台点击及找色功能，使用了开源的 [天使插件](http://bbs.tyuyan.net/thread-45659-1-1.html)，
该插件由 C++ 编写，用户可以前往他们的站点下载源代码，作者只是调用了预编译好的 dll 库。
并请参考天使插件的 License.

<!-- 根据 [GPLv3](https://www.gnu.org/licenses/gpl-3.0.html) 开源协议，本人不对该脚本负任何责任。-->

## 协议 (License)

该源代码使用了 [GPLv3](https://www.gnu.org/licenses/gpl-3.0.html) 开源协议。

This project is licensed under the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.html) license.


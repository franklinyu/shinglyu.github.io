---
layout: post
title: 如何貢獻開源專案 - 以 Servo 為例
categories: Web
date: 2017-08-26 20:17:48 +08:00
tags: mozilla
excerpt_separator: <!--more-->
---

<!--more-->
# 心理準備

# 基礎知識 
以下有些基礎技能你最好先學會（或是先掃過一下教學文件然後邊做邊學）：
* git

http://blog.fukuball.com/git-jian-yi-shi-yong-jiao-xue/
* GitHub 
  * [基本觀念（中文）][github-zh]
  * [基本流程（英文）][github-en]
https://guides.github.com/activities/hello-world/
  * [Fork（英文）][github-form-en]
https://guides.github.com/activities/forking/

# 找尋可以貢獻的 bug
* Servo 的 bug (程式缺陷) 或是新功能請求都在 GitHub 上管理，可以至 Servo 的 [Issues 頁面][issues]瀏覽
* Servo 適合新手的 bug 都蒐集在 https://starters.servo.org 頁面上，也可以至 Servo Issues 直接查詢[有 E-easy 標籤的 bug][easy]
* 找到 issue 以後，試著理解問題是什麼，如果下面留言中沒有人表示想要做，就可以立刻留言表示興趣，並且向開 bug 的人請求進一步的指示或協助。以下是一個範例的回應：

> Hi @<username>, I'm interested in this issue.

* 想要知道相關原始碼在哪裡 => Could you kindle point me to the relevant code/file?
* 想要知道如何重現出這個問題 => Could you tell me the exact step to reproduce this issue?
* 想要知道相關的標準規範 (W3C, WHATWG, etc. ) => Could point me to the relevant spec?
* 看不太懂也不知道要問什麼，希望對方進一步說明 => Could you give me more information on how this thing works and how I should proceed?

# 如何下載、修改並測試 Servo 的原始碼
要取得 Servo 的程式碼開始修改，首先要從 Servo 官方的 repository "fork" 出一版，按下右上方的 "Fork" 按鈕，你的帳號下就會出現一個 `servo` repository。(詳見[Forking ][])。需要這麼做的原因是因為一般使用者沒有權限直接修改 servo/servo 的原始碼，所以你必須複製("fork")一份自己的版本，修改完以後在把改動提交給官方審核 (也就是所謂的 Pull Request)

# [TODO: fork
接下來你就可以從你剛剛 fork 出來的 servo repository 按下 "Clone or download"，取得 clone 用的網址。接下來開啟一個終端機，輸入 `git clone git@github.com/<你的帳號>/servo.git` (把<你的帳號>代換成你的 clone 網址)。這個下載需要耗費不少時間,記得確保你的網路暢通，就可以去泡杯咖啡慢慢等候了。

# [TODO:clone  

等下載完畢，首先要做的就是確保你的環境能夠正確的編譯並執行 servo。Servo 的文件中有寫出各個平台所需要事先安裝的一些套件(看[這裡][prerequsite]) , 例如 Ubuntu 就需要安裝

```
sudo apt install git curl freeglut3-dev autoconf libx11-dev \
       libfreetype6-dev libgl1-mesa-dri libglib2.0-dev xorg-dev \
       gperf g++ build-essential cmake virtualenv python-pip \
       libssl-dev libbz2-dev libosmesa6-dev libxmu6 libxmu-dev \
       libglu1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdbus-1-dev
```

然後執行 `./mach build --dev` 來試著編譯。注意除了 OSX 與 Linux 外，其他平台的狀況都不是很穩定，所以如果無法順利編譯也不要氣餒，記得到 [issues][issues] 看看有沒有其他人也遇到一樣的問題，或是開個新 issue 尋求協助 （記得附上你遇到的錯誤訊息）。

一但編譯順利，你就可以跑 `./mach run` 來測試 servo 是否正常運作，你應該會看到 servo 開啟一個視窗，並且載入 servo 的官方網站。你也執行 `./mach run -b` 試試看一個用 HTML 打造的簡易瀏覽器界面 [browser.html][browser.html]。

如果你編譯一切順利，恭喜！你可以開始動工了。通常我們會為每一個 issue 或是功能開一個新的 branch，以方便切換。當你完成更改以後，記得 commit 並且寫上清楚的 commit 訊息。一般來說好的 commit message 可以寫成：
* Implemented <a JavaScript API/CSS property/other feature> (實作了<一個 JavaScript API, CSS 屬性或其他功能>)
* Modified/Fixed/Changed <some part of the code> to <provide some benefit> (修改/修正/改動了<某個部份>來<提供某些好處>), 例如 Change the internal implementation of class Foo to enhance readabiltiy。

舉例來說，假設我們要實作 `window.open()` 這個 JavaScript API, 我們可以

```
git branch -b window-open # 開啟一個叫 window-open 的 branch
git checkout window-open
# 實作 window open
./mach build -d  # 確定編譯會過
git commit -m "Implemented window.open()"
git push -u origin window-open # 把 window-open branch 上的東西推到你的 servo repo
```

# 如何提交 Pull Request
當你的更改完成，記得先檢查以下幾點，以免浪費其他人的時間：
* `./mach build -d` 可以順利編譯。
* `./mach test-tidy` 會檢查程式風格的問題，例如多餘的空格、錯誤的括號位置、行長度過長之類的問題。
* 相關的測試有通過（不知道要跑什麼測試的話，請到原始的 issue 中問）:
  * `./mach test-unit` 單元測試
  * `./mach test-wpt` web platform test, 主要測試 JS/CSS 相關功能是否符合標準規範

如果都通過就可以到 servo/servo，選Pull requests 然後按 New pull request。接下來按 compare across forks，然後head fork 選擇 <你的帳號>/servo, compare 選擇你要提交的 branch。簡單檢查一下下面出現的程式碼，如果沒有問題就可以按 Create pull request。

[#TODO: 圖]

當你一開 pull request，servo 的 highfive 聊天機器人就會自動跳出來跟你打招呼，並且幫你指定一個 reviewer。所有提交到 servo 的程式碼都需要通過他人審核，這也是一般 open source 專案的慣例，不過 servo 的 reviewer 都相當友善，所以不用太擔心。

接下來 reviewer 通常會提供你一些修改的建議，這對很多人來說很難為情，因為要把自己寫的程式攤在日光下給人家批評。不過記得 reviewer 都是對事不對人，所以不要把這些評論當作對自己的人身攻擊。這也是一些非常好的學習機會，通常都可以從 reviewer 那邊學到相當 多 servo 內部的知識以及程式風格的建議。

如果要根據 reviewer 的意見修正，只要繼續在自己的那份 servo 上修改、commit、並且 git push 到你自己原來的那個 branch 即可，過給秒鐘後再去重新整理 pull request 的頁面就可以發現已經更新到你新推的程式碼了。經過這樣幾次來回修改直到 reviewer 滿意以後，他可能會做幾件事情：
* 請你 rebase 或 squash，這些操作比較進階，也超出本篇的篇幅，詳細可以參考[這篇手把手教學][]
* 他向另外一隻聊天機器人 @bors-servo 說 "@bors-servo try"，這表示他請 bors-servo 啟動一系列自動測試，但是並不直接 merge 你的 pull request。最後如果測試都通過通常就會進到下一條。
* 他向 bors-servo 說 "@bors-servo r+"，這時候 bors-servo 就會先執行一系列測試，如果測試都通過就會直接 merge 你的 pull request。

假設有任何測試沒通過，請不要驚慌，根據測試失敗的原因繼續修改你的程式即可。如果看不懂為何會錯也可以直接在 pull request 裡面發問。

# 哪裡查資料與問問題
以上就是完整的從找到問題到成功 merge 一個 pull request 的流程，但是在這過程中有許許多多的小環節都有可能出錯，這時千萬記得隨時發問。

Servo 是一個非常複雜而且龐大的專案，而且瀏覽器引擎相關的資料在網路上相當稀少。所以以下我蒐集了一些資源可以幫助你更了解相關的背景知識：

* How browser works: 這是目前網路上最完整最全面的瀏覽器引擎介紹,雖然沒有直接介紹 Servo，但是可以幫助你了解瀏覽器引擎大致是如何運作的
* Matt's Let's build a browser engine: Matt Brubeck (也是 Servo 的核心成員) 用實際的 code 介紹如何寫出真正可以運作的瀏覽器引擎
* [Servo Wiki][]: Servo 官方的 wiki，有一些設計的筆記與投影片，不過似乎有一陣子沒更新，記得要檢查一下是不是太舊。
* Servo code 裡面的註解與文件: Servo 的程式碼中夾雜了不少註解與文件，例如 [][], 假設你在修改某個檔案，記得在同一個資料夾或上下一兩層資料夾找找文件。
* WHATWG Spec & W3C Spec: 假設你處理的是 DOM (JavaScript) 或是 CSS 的功能，看一下官方的規範是跑不掉的
* MDN: 官方規範太硬太難唸，想要看一下實際上如何使用可以去 MDN 上搜尋

[issues]: https://github.com/servo/servo/issues
[easy]: https://github.com/servo/servo/issues?utf8=✓&q=is%3Aopen%20is%3Aissue%20label%3AE-easy%20-label%3AC-assigned
[github-zh]: http://www.ithome.com.tw/news/95283
[prerequsite]: https://github.com/servo/servo#setting-up-your-environment


TODO: 
http://brainlessdeveloper.com/2017/08/12/my-experience-contributing-to-servo/
https git
servo starter not only servo dev build and release build
irc

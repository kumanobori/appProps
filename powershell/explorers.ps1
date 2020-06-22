# ----------- 設定部分start ----------------------------------------
[int]$waitMsec = 1000 # エクスプローラを起動すると、非同期で次の処理へ行ってしまうので、開くのを待つための時間ミリ秒。
[int]$startX = 0 # gridX=0のエクスプローラの左端の座標
[int]$startY = 0 # gridY=0のエクスプローラの上端の座標
[int]$width = 500 # エクスプローラーのウィンドウの幅
[int]$height = 300 # エクスプローラのウィンドウの高さ
[int]$paddingX = -15 # エクスプローラのウィンドウ同士の隙間(横)
[int]$paddingY = -8 # エクスプローラのウィンドウ同士の隙間(縦)
# ----------- 設定部分end ------------------------------------------

# エクスプローラを開く
# @param gridX 配置位置の横座標
# @param gridY 配置位置の縦座標
# @param folderPath エクスプローラが開くフォルダのパス
function execExplorer ([int]$gridX, [int]$gridY, [string]$folderPath) {
	explorer $folderPath
	Start-Sleep -m $waitMsec
	# エクスプローラの配列の配列はどうやら起動順らしいので、最後に起動したエクスプローラは最終要素になる
	$app = (New-Object -com "Shell.Application").windows() | Select-Object -last 1
	$app.Left = $startX + $gridX * ($width + $paddingX)
	$app.Top = $startY + $gridY * ($height + $paddingY)
	$app.Width = $width
	$app.Height = $height
}


# ----------- 実行部分start ----------------------------------------

# エクスプローラの配列をforeachで回して全部閉じる
# メモ：foreach1回ではエクスプローラが全部は消えない場合がある。2回やると消える。原因不明。
foreach ($app in (New-Object -com "Shell.Application").windows()) {
	$app.quit()
}
foreach ($app in (New-Object -com "Shell.Application").windows()) {
	$app.quit()
}

# ウィンドウ位置とパスを指定してエクスプローラを起動
execExplorer 0 0 "c:\"
execExplorer 1 0 "c:\program files"
execExplorer 2 0 "c:\program files (x86)"
execExplorer 0 1 "c:\"
execExplorer 1 1 "c:\program files"
execExplorer 2 1 "c:\program files (x86)"
execExplorer 0 2 "c:\"
execExplorer 1 2 "c:\program files"
execExplorer 2 2 "c:\program files (x86)"

# ----------- 実行部分end ------------------------------------------


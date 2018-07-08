MyPath="D:\\thuy_max\\00_max\\previews\\" +  ((FilterString (maxFileName as string) "." )[1])+ "\\"
if not (doesFileExist MyPath)do(makeDir (MyPath))
--______________________________________________________
cameraName = "MADISON_lookup_*"

for c in cameras where (isKindOf c camera) and (matchpattern c.name pattern:cameraName)do
(
	viewport.setCamera c
	forceCompleteRedraw()
	img = gw.getViewportDib()
	img.filename = MyPath + (getfileNameFile maxFileName) + "_" +c.name + "_" +".jpg"
	save img
)

--______________________________________________________

ShellLaunch "explorer.exe" MyPath
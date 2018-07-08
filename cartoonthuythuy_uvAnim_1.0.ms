fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxUtils.ms"
dotNet.loadAssembly "E:\\thuy_3dsmax\\thuy_dotnet\\thuy_cs_test\\thuy_cs_test\\bin\\Debug\\thuy_cs_test.dll"

-- ==========
-- funtion
-- ==========
function getUV gridCount = (
	-- Function functionName body
	count_ = (sqrt gridCount) - 1
	uvTileing = 1.0/(count_+1)
	minVal = 0
	maxVal = 1 - uvTileing

	lerpOut = LerpArray minVal maxVal count_
	lerpOut1 = LerpArray maxVal minVal count_
-- 	print lerpOut

	arrayTMP = #()

	for v in lerpOut1 do(
		for u in lerpOut do(
			append arrayTMP [u,v]
		)
	)
-- 	print id
-- 	print arrayTMP

	return #(uvTileing, arrayTMP)
)

-- ==========
-- UI
-- ==========
try(destroydialog dlg) catch()
rollout dlg "uv animation"
(
	local imageclass = dotNetclass "System.Drawing.image"
	local bgImg = ""
	local globalSize = 160
	local buttons = ""
 	local malign = dotnetclass "System.Drawing.ContentAlignment"
	local Ccolor = dotnetclass "system.drawing.color"
	local cursor_harrow = dotNetObject "System.Windows.Forms.Cursor" "C:\\WINDOWS\\Cursors\\aero_link.cur"
	local font = dotNetObject "System.Drawing.Font" "Verdana" 6 ((dotNetClass "System.Drawing.FontStyle").bold)
	local fontLarge = dotNetObject "System.Drawing.Font" "Verdana" 8 ((dotNetClass "System.Drawing.FontStyle").bold)
	local target = undefined
	local scale_ = undefined
	local uvs = undefined

	edittext bgImgPath	"bgImgPath" text: "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\misc\\MouthThumbnails.jpg" pos:[0,0]
	pickbutton targetSurface "target Surface" pos:[0,24] width:(globalSize)
	button refresh "refresh" pos:[0,48] width:(globalSize)
	dotNetControl flp "thuy_cs_test.thuy_FlowLayoutPanel" pos:[0,72] height:(globalSize) width:(globalSize)

	on targetSurface picked obj do
	(
		if obj != undefined then
		(
			targetSurface.text = obj.name
			target = obj
		)
	)

	fn dotnetImageResize image width height =
	(
		img = dotNetObject "System.Drawing.Bitmap" width height image.PixelFormat
		g = (dotnetclass "System.Drawing.Graphics").FromImage img

		g.SmoothingMode = g.SmoothingMode.HighQuality
		g.CompositingQuality = g.CompositingQuality.HighQuality
		g.InterpolationMode = g.InterpolationMode.HighQualityBicubic
		g.PixelOffsetMode = g.PixelOffsetMode.highQuality

		g.DrawImage image 0 0 width height
		return img
	)

	fn onMouseDown ctrl evnt =
	(
		id = ctrl.text as integer
		ctrl.forecolor = Ccolor.green
		ctrl.font = fontLarge
		if ctrl.backcolor != Ccolor.red do ctrl.backcolor = Ccolor.red
		if target != undefined then(
			if target.modifiers[1] != undefined then(
				target.modifiers[1].U_Tile = scale_
				target.modifiers[1].V_Tile = scale_
				target.modifiers[1].U_Offset = uvs[id][1]
				target.modifiers[1].V_Offset = uvs[id][2]
			)else print "UVW xform modifier is undefined!"
		)else print "Target is undefined!"
	)

	fn onMouseEnter ctrl evnt =
	(
		ctrl.font = fontLarge
		ctrl.forecolor = Ccolor.red
		ctrl.TextAlign = malign.MiddleCenter
		ctrl.Cursor = cursor_harrow
		ctrl.FlatAppearance.BorderSize = 2
		ctrl.flatappearance.mouseoverbackcolor = Ccolor.transparent
	)

	fn onMouseLeave ctrl evnt =
	(
		ctrl.forecolor = Ccolor.black
		ctrl.backcolor = Ccolor.transparent
		ctrl.TextAlign = malign.BottomCenter
		ctrl.FlatAppearance.BorderSize = 0
	)

	fn makeButtons =
	(
		result = #()
		size = globalSize

-- 		create uv val
		gridCount = 16
		uvVal = getUV gridCount
		scale_ = uvVal[1]
		uvs = uvVal[2]

-- 		Images_Array = getFiles ("E:\\thuy xsi\\Anhungxadieu\\anhungxadieu\\Render_Pictures\\test\\rig" + "\\*.png")
	-- 	Images_Array = getFiles ("E:\\thuy_nuke\\asset\\BG\\HT_BG" + "\\*.png")

		for i=1 to uvs.count do
		(
			btn = dotnetobject "button"
			btn.size = dotnetobject "system.drawing.size" (size/4-6) (size/4-6) --160 120
	-- 		maxBackColor = colorMan.getColor #background
	-- 		DotNetBackColor = mColor.FromArgb (maxBackColor[1] * 255.0f) (maxBackColor[2] * 255.0f) (maxBackColor[3] * 255.0f)

	-- 		create image////////////////////////////
	-- 		imageclass = dotNetclass "System.Drawing.image"
			-- load bitmaps
	-- 		IListimage1 = imageclass.fromfile (i)
			--create an imagelist
	-- 		imglist = dotnetobject "System.Windows.Forms.ImageList"
	-- 		imglist.imagesize =	dotnetobject "System.Drawing.Size" (btn.height-11) (btn.width-11)
			--add them to the image list
	-- 		imglist.images.add ilistimage1
	-- 		imglist.TransparentColor = Ccolor.white

	-- 		create button///////////////////////////
-- 			btn.text = uvs[i] as string
			btn.text = i as string
		 	btn.TextAlign = malign.BottomCenter
		 	btn.font = font
-- 		 	btn.imagealign = malign.topcenter
	-- 		btn.ImageIndex = 0
	-- 		btn.ImageList = ImgList
			btn.flatStyle=btn.flatStyle.flat
			btn.FlatAppearance.BorderSize = 0
			btn.flatappearance.mousedownbackcolor = Ccolor.red
			btn.flatappearance.bordercolor = Ccolor.magenta
			btn.backcolor = Ccolor.Transparent

	-- 		Setup an event handlers for both buttons
			dotnet.addEventHandler btn "MouseDown" onMouseDown
			dotnet.addEventHandler btn "MouseEnter" onMouseEnter
			dotnet.addEventHandler btn "MouseLeave" onMouseLeave
	-- 		dotnet.addEventHandler btn "MouseUp" onMouseUp
	-- 		dotnet.addEventHandler btn "MouseMove" onMouseMove

			dotNet.setLifetimeControl btn #dotnet
			append result btn
	 	)
	 	return result
	)

	on refresh pressed do
	(
		if doesFileExist bgImgPath.text then
		(
			print bgImgPath.text
-- 				showEvents flp
			bgImg = imageclass.fromfile (bgImgPath.text as string)
-- 				globalSize = bgImg.height

			size = globalSize
			img = dotnetImageResize bgImg size size

			flp.BackgroundImage = img
			flp.size = dotnetobject "System.Drawing.Size" size size

			buttons = makeButtons()

			flp.controls.addrange buttons
		)
		else
		(
			messageBox "bgImgPath --> error" title: "error"
			return false
		)
	)

	on dlg open do
	(
		if doesFileExist bgImgPath.text then
		(
			print bgImgPath.text
			bgImg = imageclass.fromfile (bgImgPath.text as string)
-- 				globalSize = bgImg.height

			size = globalSize
			img = dotnetImageResize bgImg size size

			flp.BackgroundImage = img
			flp.size = dotnetobject "System.Drawing.Size" size size

			buttons = makeButtons()

			flp.controls.addrange buttons
		)
		else
		(
			messageBox "bgImgPath --> error" title: "error"
			return false
		)
	)

	on dlg resized size do
	(
		factor = if ((if size.x < size.y then size.x else size.y)/globalSize) >= 1 then 1 else ((if size.x < size.y then size.x else size.y)/globalSize)
		if factor != 0.0 then
		(
			img = dotnetImageResize bgImg (globalSize * factor) (globalSize * factor)

			flp.BackgroundImage = img
			flp.Size = dotnetobject "System.Drawing.Size" img.height img.width
			for i in buttons do
			(
				i.size = dotnetobject "system.drawing.size" (img.width/4-6) (img.height/4-6)
			)

		)
		else
		(
			print "Minimize!"
		)
	)
)
-- createdialog dlg 500 500 style:#	(
-- 								 	#style_titlebar,
-- 									#style_sysmenu,
-- 									#style_minimizebox,
-- 									#style_maximizebox,
-- 									#style_sunkenedge,
-- 									#style_resizing
-- 									)
-- ======
-- end UI
-- ======

for o in selection do
(
	myMod = addModifier o (EmptyModifier ())
	custAttributes.add o.modifiers[1] CA
)



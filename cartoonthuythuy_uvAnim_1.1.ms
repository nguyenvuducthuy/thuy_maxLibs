fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxUtils.ms"
dotNet.loadAssembly "E:\\thuy_3dsmax\\thuy_dotnet\\thuy_cs_test\\thuy_cs_test\\bin\\Debug\\thuy_cs_test.dll"

-- ==========
-- funtion
-- ==========

-- ==========
-- UI
-- ==========
rollout chFloat "cartoonthuythuy_uvAnim" width:160 height:160
(
	local width = 160
	local scale_ = undefined
	local uvs = undefined
	local form = undefined
-- 	local form = dotNetObject "form"
	local target = undefined
	local imageclass = dotNetclass "System.Drawing.image"

	edittext imgPath "Img Path" text: "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\misc\\manga_eyes_expression_1.png"
	edittext uvXformModName "UV Xform" text: "UVW Xform"
	spinner mapChannel "Map Channel:" type:#integer range:[1,1111,1]
	spinner gridCount "Grid Count:" type:#integer range:[2,22,4]
	spinner UIScale "Float UI scale" type:#integer range:[1,11,1]
	pickbutton targetSurface "Pick Object" width:(width)
	button floatUI ">> Float UI <<" width:(width)
-- 	dotNetControl flp "thuy_cs_test.thuy_FlowLayoutPanel" 	/* pos:[0,(width*0+24*6)] height:(width) width:(width) */
-- 	dotNetControl form "MaxCustomControls.MaxForm" 	pos:[0,(width*0+24*6)] height:(width) width:(width)

	on targetSurface picked obj do
	(
		if obj != undefined then
		(
			targetSurface.text = obj.name
			target = obj
		)
	)

	fn getUV count = (
		count_ = (sqrt count) - 1
		scale = 1.0/(count_+1)
		minVal = 0
		maxVal = 1 - scale

		lerpOut = LerpArray minVal maxVal count_
		lerpOut1 = LerpArray maxVal minVal count_

		arrayTMP = #()

		for v in lerpOut1 do(
			for u in lerpOut do(
				append arrayTMP [u,v]
			)
		)
		return #(scale, arrayTMP)
	)

-- 	fn resized size =(
-- 		factor = if ((if size.x < size.y then size.x else size.y)/(width)) >= 1 then 1 else ((if size.x < size.y then size.x else size.y)/(width))
-- 		if factor != 0.0 then
-- 		(
-- 			flp.Size = dotnetobject "System.Drawing.Size" (width * factor) (width * factor)
-- 		)
-- 		else
-- 		(
-- 			print "Minimize!"
-- 		)
-- 	)

	fn existFile fname = (getfiles fname).count != 0

 	fn clickhandler sender args =
 	(
 		id = args.btnId+1
 		uvXfromName = args.flpId
 		parent = target
 		if parent != undefined then(
	 		for m in parent.modifiers where m.name == uvXfromName do(
	 			uvXform = m
				if uvXform != undefined then(
					uvXform.map_channel = mapChannel.value
					uvXform.U_Tile = scale_
					uvXform.V_Tile = scale_
					uvXform.U_Offset = uvs[id][1]
					uvXform.V_Offset = uvs[id][2]
				)else print "UVW xform modifier is undefined!"
 			)
 		)else print "Pick An Object"
 	)

 	on floatUI pressed do
 	(
 		try(form.close())catch()
-- 	 	create uv value////////
		uvVal = getUV (gridCount.value^2)
		scale_ = uvVal[1]
		uvs = uvVal[2]

-- 		create ui/////////////
		if existFile imgPath.text then
		(
			newSize = width * UIScale.value

			flp = dotNetObject "thuy_cs_test.thuy_FlowLayoutPanel"
			flp.Size = dotnetobject "System.Drawing.Size" newSize newSize
			flp.globalSize = newSize
			flp.imgPath = imgPath.text
			flp.count = gridCount.value
			flp.flpId = uvXformModName.text
			flp.DoSomething()

			form = dotNetObject "MaxCustomControls.MaxForm"
			if (target != undefined) then(
				form.text = target.name +"_"+ uvXformModName.text
			)
			else(
				messageBox "Please Pick Object First!"
				return false
			)
			form.size = dotnetobject "System.Drawing.Size" (newSize+10) (newSize+28)
			form.controls.add flp

			dotnet.addEventHandler flp "picked" clickhandler

			p = DotNetObject "System.IntPtr" ( Windows.GetMAXHWND() )
			mainwin = dotNetObject "System.Windows.Forms.Control"
			mainwin.fromHandle p
			form.show(maxHwnd)
			form.show()
		)
 	)

--  	on chFloat resized size do
-- 	(
-- 		resized size
-- 	)
)

CA = attributes cartoonthuythuy_tool
(
	parameters uvAnim rollout: ch
	(
		uvXformModName type:#string ui:uvXformModName Default:"UVW Xform"
		imgPath type:#string ui:imgPath Default:"D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\misc\\manga_eyes_expression_1.png"
		mapChannel type:#integer ui:mapChannel Default:1
		gridCount type:#integer ui:gridCount Default:4
		UIScale type:#float ui:UIScale Default:1
	)
	rollout ch "cartoonthuythuy_uvAnim" width:82 height:44
	(
-- 		local imgPath = "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\misc\\mangaMouthThumbnails.png"
-- 		local imgPath = "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\misc\\manga_eyes_expression_1.png"
		local width = 160
		local scale_ = undefined
		local uvs = undefined
		local Ccolor = dotnetclass "system.drawing.color"
-- 		local form = dotNetObject "MaxCustomControls.MaxForm"

		edittext imgPath "" text: "" fieldWidth:(width-60) height:20
		button openFileDialog "..." pos:[(width-40),7]
		edittext uvXformModName "UV Xform" text: ""
		spinner mapChannel "Map Channel:" type:#integer
		spinner gridCount "Grid Count:" type:#integer
		spinner UIScale "Float UI scale" type:#float range:[1,1111,1]
-- 		button floatUI "Float UI" width:(width)
		dotNetControl flp "thuy_cs_test.thuy_FlowLayoutPanel" pos:[0,(width*0+24*5)] height:(width*UIScale.value) width:(width)
-- 		dotNetControl floatFlp "thuy_cs_test.thuy_FlowLayoutPanel" height:0 width:0

		function getUV count = (
			count_ = (sqrt count) - 1
			scale = 1.0/(count_+1)
			minVal = 0
			maxVal = 1 - scale

			lerpOut = LerpArray minVal maxVal count_
			lerpOut1 = LerpArray maxVal minVal count_

			arrayTMP = #()

			for v in lerpOut1 do(
				for u in lerpOut do(
					append arrayTMP [u,v]
				)
			)
			return #(scale, arrayTMP)
		)

		fn existFile fname = (getfiles fname).count != 0

		fn createFlp imgPath count size flp = (
   			if existFile imgPath.text then
			(
				flp.globalSize = size
				flp.imgPath = imgPath.text
				flp.count = count
				flp.flpId = uvXformModName.text
				flp.DoSomething()
			)
		)

	 	fn clickhandler sender args =
	 	(
	 		id = args.btnId+1
	 		uvXfromName = args.flpId
	 		parent = (refs.dependentNodes (custAttributes.getOwner this))[1]
	 		for m in parent.modifiers where m.name == uvXfromName do
	 		(
	 			uvXform = m
				if uvXform != undefined then(
					uvXform.map_channel = mapChannel.value
					uvXform.U_Tile = scale_
					uvXform.V_Tile = scale_
					uvXform.U_Offset = uvs[id][1]
					uvXform.V_Offset = uvs[id][2]
				)else print "UVW xform modifier is undefined!"
-- 				print uvXform
	 		)
-- 	 		case sender.name of
-- 	 		(
-- 	 		"btn_headFK":print "btn_FK pressed"
-- 	 		"btn_other":print "btn_other"
-- 	 		default:print "boo"
-- 	 		)
	 	)

--  		on floatUI pressed do
-- 		(
-- 			try(
-- 				floatForm.close()
-- 			)catch()
-- 			global floatForm = dotNetObject "MaxCustomControls.MaxForm"
-- -- 			floatFlp = dotNetObject "thuy_cs_test.thuy_FlowLayoutPanel"
-- -- 			create floatUI////////
-- 			newSize = width * UIScale.value
-- 			floatForm.text = "Float cartoonthuythuy uvAnim UI"
-- 			floatForm.size = dotnetobject "System.Drawing.Size" (newSize+10) (newSize+28)
-- 			floatFlp.visible = true
-- 			floatFlp.Size = dotnetobject "System.Drawing.Size" newSize newSize
-- 			createFlp imgPath gridCount.value newSize floatFlp

-- 			try(
-- 				floatForm.controls.add floatFlp
-- 			)catch()

-- 			p = DotNetObject "System.IntPtr" ( Windows.GetMAXHWND() )
-- 			mainwin = dotNetObject "System.Windows.Forms.Control"
-- 			mainwin.fromHandle p
-- 			floatForm.show(maxHwnd)
-- 			floatForm.show()
-- 		)

	 	on ch open do
	 	(
-- 	 		create uv value////////
			uvVal = getUV (gridCount.value^2)
			scale_ = uvVal[1]
			uvs = uvVal[2]

-- 			create ui/////////////
-- 			floatFlp.visible = false
			flp.autoscroll = true
			scaleSize = width*UIScale.value
			createFlp imgPath gridCount.value scaleSize flp
	 	)

	 	on openFileDialog pressed do
	 	(
			theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog"
			theDialog.title = "PLEASE Select One image"
			theDialog.Multiselect = false
			theDialog.Filter = "Bitmap File|*.bmp|JPEG File (*.jpg,*.jpe,*.jpeg)|*.jpg,*.jpe,*.jpeg|PNG Image File (*.png)|*.png|All Files (*.*)|*.*"
			theDialog.FilterIndex = 3
			result = theDialog.showDialog()
			if result == result.Cancel then return false else imgPath.text = theDialog.fileName
			imgPath.text = theDialog.fileName
	 	)

-- 	 	on ch close do
-- 	 	(
-- 	 		floatForm.close()
-- 	 	)

	 	on flp picked sender args do clickhandler sender args
	 	on floatFlp picked sender args do clickhandler sender args
	)
)
-- ======
-- end UI
-- ======
-- CA/////////////////////////
for o in selection do
(
	myMod = (for m in o.modifiers where m.name == "cartoonthuythuy_uvAnim" collect m)[1]
	if myMod == undefined do
	(
		myMod = EmptyModifier ()
		myMod.name = "cartoonthuythuy_uvAnim"
		addModifier o (myMod)
	)
	custAttributes.add myMod CA
)

-- dlg////////////////////////
-- createdialog chFloat style:#	(
-- 					 	#style_titlebar,
-- 						#style_sysmenu,
-- 						#style_minimizebox,
-- 						#style_maximizebox,
-- 						#style_sunkenedge,
-- 						#style_resizing
-- 						)
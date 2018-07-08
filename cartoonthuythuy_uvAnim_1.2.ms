dotNet.loadAssembly "E:\\thuy_3dsmax\\thuy_dotnet\\thuy_cs_test\\thuy_cs_test\\bin\\Debug\\thuy_cs_test.dll"

-- ==========
-- funtion
-- ==========

-- ==========
-- UI
-- ==========
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
		local width = 160
		local scale_ = undefined
		local uvs = undefined

		edittext imgPath "" text: "" fieldWidth:(width-60) height:20
		button openFileDialog "..." pos:[(width-40),7]
		edittext uvXformModName "UV Xform" text: ""
		spinner mapChannel "Map Channel:" type:#integer
		spinner gridCount "Grid Count:" type:#integer
		spinner UIScale "Float UI scale" type:#float range:[1,1111,1]
		dotNetControl flp "thuy_cs_test.thuy_FlowLayoutPanel" pos:[0,(width*0+24*5)] height:(width*UIScale.value) width:(width)

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
	 		)
	 	)

	 	on ch open do
	 	(
-- 	 		create uv value////////
			uvVal = getUV (gridCount.value^2)
			scale_ = uvVal[1]
			uvs = uvVal[2]

-- 			create ui/////////////
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

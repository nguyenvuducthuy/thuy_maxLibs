macroScript makeRender category: "cartoonthuythuy" buttonText: "makeRender"
Icon:#("thuy_icon_00",1)
(
	fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithRender.ms"
	fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxUtils.ms"
	-- //////////////////////////////////
	-- CHANGE HERE///////////////////////
	-- //////////////////////////////////
	global movieNum = queryDialog.init()
	if movieNum == undefined then return messageBox "project name undefined"
	-- input file
	global theMaxFiles = GetDir #scene + "\\cartoonthuythuy\\spidermanBaby\\"+movieNum+"\\in\\aTung\\"
	global theTexPath = "\\\\ANHUNGXADIEUDEL\\thuy_3dsmax\\scenes\\cartoonthuythuy\\spidermanBaby\\texture\\"
	-- output file
	global savepath = GetDir #scene + "\\cartoonthuythuy\\spidermanBaby\\"+ movieNum +"\\out\\render\\"
	-- material libraries
	global matLib = "D:\\thuy_3dsmax\\materiallibraries\\vray\\cartoonthuythuy_spidermanbaby.mat"
	-- merge File
	global mergeFile = GetDir #scene + "\\cartoonthuythuy\\spidermanBaby\\movie_05\\out\\render\\video_05_b_new_render_.max"
	global mergeObj = #("VRayAmbientLight001","VRaySun001") as string
	-- working scene
	global renderPath = "\\\\ANHUNGXADIEUDEL\\thuy_3dsmax\\renderoutput\\cartoonthuythuy\\spidermanBaby\\"+ movieNum +"\\render"
	global thePresetFiles = GetDir #renderPresets + "\\cartoonthuythuy\\spidermanBaby\\cartoonSeries.rps"
	-- //////////////////////////////////
	rollout cartoonthuythuy "makeRender" width: 200 height: 520
	(
		edittext _movieNum 			"_movieNum" 		text: movieNum		 labelOnTop:true
		edittext _theMaxFiles 		"_theMaxFiles" 		text: theMaxFiles	 labelOnTop:true
		edittext _theTexPath 		"_theTexPath" 		text: theTexPath	 labelOnTop:true
		edittext _savepath 			"_savepath" 		text: savepath		 labelOnTop:true
		edittext _matLib 			"_matLib" 			text: matLib		 labelOnTop:true
		edittext _mergeFile 		"_mergeFile" 		text: mergeFile	 	 labelOnTop:true
		edittext _mergeObj 			"_mergeObj" 		text: mergeObj		 labelOnTop:true
		edittext _renderPath 		"_renderPath" 		text: renderPath	 labelOnTop:true
		edittext _thePresetFiles 	"_thePresetFiles"	text: thePresetFiles labelOnTop:true
		edittext _managerName 		"_managerName"		text: "anhungxadieudel" labelOnTop:true

		checkbox material_btn "mat" 		across:2
		checkbox texture_btn "tex" 			across:2
		checkbox light_btn "lig" 			across:2
		checkbox addtionTasks_btn "+Tasks"	across:2
		checkbox renderSetup_btn "renSet" 	across:2
		checkbox saveMax_btn "saveMax" 		across:2
		checkbox toBackburner_btn "2Backburner"	across:2
		checkbox currentMax_btn "currentMax"	across:2

		button _render_ 	"_render_" 		pos:[10,490]

	-- //////////////////////////////////
		on _render_ pressed do(
		-- start loop_______________________________________________
			if (currentMax_btn.state)then
			(
				maxFiles = getFiles (maxFilePath + maxFileName)
			)else(
				maxFiles = getFiles (_theMaxFiles.text as string + "*.max")
			)
			for f in maxFiles do
			(
			-- 	open the file
				if (currentMax_btn.state == false )then loadmaxfile f
			-- 	////////////////////////////
			-- 	variables>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

				sceneName = getFilenameFile (maxFilePath + maxFileName)
				output_ = _renderPath.text +"\\"+sceneName + "_.exr"

			-- 	load mat from material libraries>>>>>>>>>>>>>>>>>>>>>>>
				if (material_btn.state)then(
					for o in objects do(
					case of
						(
							(matchPattern o.name pattern:("*elsa_full")):
							getMatFromLib o _matLib.text "vray elsa skin"
							(matchPattern o.name pattern:("*spiderman_baby_mesh001")):
							getMatFromLib o _matLib.text "vray spiderman_baby"
							(o.name == "face_elsa_Morpher"):
							getMatFromLib o _matLib.text "vray elsa skin"
							(o.name == "hands"):
							getMatFromLib o _matLib.text "vray elsa skin"
							(o.name == "spiderman_baby_mesh"):
							getMatFromLib o _matLib.text "vray spiderman_baby"
							(o.name == "Face_Morpher_snow"):
							getMatFromLib o _matLib.text "vray snowWhite skin"
							(o.name == "body_clothes"):
							getMatFromLib o _matLib.text "vray elsa dress"
							(o.name == "jacket"):
							getMatFromLib o _matLib.text "vray elsa cape"
							(o.name == "L_eye_elsa"):
							getMatFromLib o _matLib.text "vray elsa eyes"
							(o.name == "R_eye_elsa"):
							getMatFromLib o _matLib.text "vray elsa eyes"
							(o.name == "beach"):
							getMatFromLib o _matLib.text "vray sand_01"
							(o.name == "ocean"):
							getMatFromLib o _matLib.text "vray water"
						)
					)
				)
			-- 	relink all texture and delete missing one>>>>>>>>>>>>>>
				if (texture_btn.state)then(
					relinkAllSceneTex _theTexPath.text
				-- 	resolveAllMisTex()
				)
			-- 	replace light>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				if (light_btn.state)then(
					for l in lights do delete l
					mergemaxfile _mergeFile.text (execute _mergeObj.text)
				)

			-- 	modified all turbosmooth for character>>>>>>>>>>>>>>>>>
				if (addtionTasks_btn.state)then(
					for m in (getclassinstances turbosmooth) do
					(
						m.enabled = true
						m.iterations = 0
						m.useRenderIterations = true
						m.renderIterations = 2
					)
				-- 	myMod = Normalmodifier flip: true
				-- 	try addmodifier $hands myMod catch()
				)
			-- 	load render preset>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				if (renderSetup_btn.state)then(
					loadRenderPreset _renderPath.text _thePresetFiles.text output_
				)
			-- 	show only render geometry>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

				hideByCategory.all()
				hideByCategory.geometry = false
				hideByCategory.shapes = false

			-- 	submit to backburner >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				if (toBackburner_btn.state)then(
					submitToBackBurner()
				)
			-- 	////////////////////////////
			-- 	sase an close file>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				if (saveMax_btn.state)then(
				-- 	saveMaxFile f --save file
					if (doesfileexist _savepath.text == false) then (
						makedir (_savepath.text)
					)
					saveMaxFile (_savepath.text + sceneName + "_render_") --save new file
					resetMaxFile #noPrompt
				)
			)
		-- end loop_______________________________________________
		)
	)
	createDialog cartoonthuythuy
)
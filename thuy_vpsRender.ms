fileIn "\\\\WIN-OTUOK3LQL52\\Users\\Administrator\\Documents\\3dsMax\\script\\thuy_workWithRender.ms"
-- //////////////////////////////////
-- CHANGE HERE///////////////////////
-- //////////////////////////////////
movieNum = "xaRac"
-- input file
theMaxFiles = getFiles (GetDir #scene + "\\spidermanBaby\\"+movieNum+"\\out\\render\\" + "*.max")
theTexPath = "\\\\WIN-OTUOK3LQL52\\Users\\Administrator\\Documents\\3dsMax\\scenes\\spidermanBaby\\texture\\"
-- output file
savepath = GetDir #scene + "\\spidermanBaby\\"+ movieNum +"\\out\\render\\"
makedir (savepath)
-- working scene
renderPath = "\\\\WIN-OTUOK3LQL52\\Users\\Administrator\\Documents\\3dsMax\\renderoutput\\spidermanBaby\\"+ movieNum +"\\render"
-- //////////////////////////////////
-- check renderPath
if not doesFileExist renderPath then
	(
	makedir (renderPath)
	)
else(
	format "'%' IS EXIST!!!" renderPath
	)
-- //////////////////////////////////
-- start loop_______________________________________________
for f in theMaxFiles do
(
-- 	open the file
	loadmaxfile f
-- 	////////////////////////////
-- 	variables>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	sceneName = getFilenameFile (maxFilePath + maxFileName)
	output_ = renderPath +"\\"+sceneName + "_VPS_render_" + ".exr"

-- 	relink all textrue and delete missing one>>>>>>>>>

	relinkAllSceneTex theTexPath
-- 	resolveAllMisTex()

-- 	set renderOutput>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	vr = renderers.current
	vr.output_rawFileName = outPut_

-- 	////////////////////////////
-- 	sase an close file>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- 	saveMaxFile f --save file

	saveMaxFile (savepath + sceneName + "_VPS_render_") --save new file
-- 	resetMaxFile #noPrompt
)
-- end loop_______________________________________________
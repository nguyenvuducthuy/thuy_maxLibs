--time__________________________
calendar = getLocalTime()
year = calendar[1] as string
month = calendar[2]
day = calendar[4]
month = formattedPrint month format:"02u"
day = formattedPrint day format:"02u"
timeSaveDayOnly =  year + "_" + month + "_" + day
--_______________________________
--/////////////////////////////////////////////////////////////////////////////
-- variables///////////////////////////////////////////////////////////////////
sceneName = getFilenameFile (maxFilePath + maxFileName)
renderPath = GetDir #renderOutput +"\\"+ sceneName + "\\" + timeSaveDayOnly + "\\"
thePresetFiles = getFiles (GetDir #renderPresets + "\\*.rps")
output_ = renderPath +"\\"+ sceneName + "_.exr"
--/////////////////////////////////////////////////////////////////////////////
fn relinkAllSceneTex theTexPath =
(
	bitmapTex = getClassinstances bitmaptexture
	hdriTex = getClassinstances VRayHDRI
-- 	bitmaptexture______________________
	for t in bitmapTex where t.fileName != undefined do
	(
		texName = filenameFromPath (t.fileName)
		t.fileName = theTexPath + texName
	)
-- 	VRayHDRI___________________________
	for t in hdriTex where t.HDRIMapName != undefined do
	(
		texName = filenameFromPath (t.HDRIMapName)
		t.HDRIMapName = theTexPath + texName
	)
)
--/////////////////////////////////////////////////////////////////////////////
fn loadRenderPreset renderPath thePresetFile output_ =
(
	renderpresets.LoadAll 0 thePresetFile

	vr = renderers.current
	vr.output_rawFileName = outPut_
	if not doesFileExist renderPath then
		(
		makedir (renderPath)
		)
	else(
		format "'%' IS EXIST!!!" renderPath
		)

-- 	shellLaunch "explorer.exe" renderPath
)
--/////////////////////////////////////////////////////////////////////////////
fn resolveAllMisTex =
(
	arg = for j in (getClassinstances bitmaptex) where (doesFileExist j.filename) == false do
	(
		format "% missing form this file!!!\n" (filenameFromPath j.fileName)
		replaceinstances j (bitmapTex())
	)
)
--/////////////////////////////////////////////////////////////////////////////
fn getMatFromLib obj matLib matName=
 (
	loadMaterialLibrary matLib
	tempMatLib = currentMaterialLibrary
	try obj.material = tempMatLib[matName] catch( messageBox "no selection!!!" )
 )
--/////////////////////////////////////////////////////////////////////////////
fn submitToBackBurner _managerName framerange camera = (
   -- Function submitToBackBurner body
	render_m = NetRender.GetManager()
	render_m.connect #manual _managerName

	for f in framerange do(
		try(
			frame = filterString f "-"
			job = render_m.newJob()
			job.includeMaps = true
			job.suspended = true
			job.name = maxfilename + f
			job.fromFrame = frame[1] as float
			job.toFrame = frame[2] as float
			job.renderCamera = camera
			job.submit()
		)catch()
	)
)
--/////////////////////////////////////////////////////////////////////////////
fn thuy_renderElement =
(
   -- Function renderElement body
	remCurrent = maxOps.GetCurRenderElementMgr()

	for i = 0 to remCurrent.NumRenderElements()-1 do --note render element manager is 0 based
	(
		re = remCurrent.GetRenderElement i
		re.vrayVFB = false
-- 		format "enable: % --> %\n" re.vrayVFB re
	)
)
--/////////////////////////////////////////////////////////////////////////////
-- ###############################################################################
-- loadRenderPreset renderPath thePresetFiles[1] output_
-- ###############################################################################

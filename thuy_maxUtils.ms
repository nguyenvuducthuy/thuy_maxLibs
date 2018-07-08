-- //////////////////////////////////////////////////////////
-- queryDialog///////////////////////////////////////////////
global queryDialog = rollout queryDialog ""
(
	local result

	edittext _movieName	"_movieName" text: ""	labelOnTop:true
	button ok_bnt "ok" width:140
	button cancel_btn "Cancel" width:140

	fn init val:undefined =
	(
		try destroyDialog queryDialog catch()
		result = val
		createDialog queryDialog modal:true
		result
	)

	fn getVal val =
	(
		result = val
		destroyDialog queryDialog
	)

	on ok_bnt pressed do getVal _movieName.text
	on cancel_btn pressed do destroyDialog queryDialog
)
-- //////////////////////////////////////////////////////////
-- Print all Project Sub-Directories ////////////////////////
fn thuy_printAllSubDir =
(
	for i = 1 to pathConfig.getProjectSubDirectoryCount() do
	(
		format "%: %\n" i (pathConfig.getProjectSubDirectory i)
	)
)
-- //////////////////////////////////////////////////////////
function renameCamByLayer =
(
	for c in cameras where c.ishidden == false do c.name = c.layer.name
)
-- //////////////////////////////////////////////////////////
fn thuyIntsRay startObj surface =
(
   -- Function thuyIntsRay body
	theRay = ray startObj.pos [0,1,0]
	theIntEx = IntersectRayEx surface theRay
	return theIntEx
)
-- //////////////////////////////////////////////////////////
fn LerpArray v0 v1 count =
(
	lerpOut = #()
	for t = 0.0 to count do
	(
		w = t/count
		append lerpOut (v0 + w * (v1 - v0))
	)
	return lerpOut
)
-- //////////////////////////////////////////////////////////
fn thuy_showLayerInList renderLayers:#() printLayerNames:false = (
-- 	print layerName>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	if printLayerNames then(
		for i = 0 to layerManager.count-1 do print (layerManager.getLayer i).name
		return false
	)
-- 	>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	for i = 0 to layerManager.count-1 do (layerManager.getLayer i).on = false
	for l in renderLayers do (LayerManager.getLayerFromName l).on = true
)
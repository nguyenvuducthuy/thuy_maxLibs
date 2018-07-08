Project = "LongAn"
instanceObj = ""
-- instanceObj = "\\instanceElements"
maxName = (filterString maxfilename ".")[1]
exportPath = pathConfig.getProjectSubDirectory 20 + "\\instanceElements\\" + Project +"\\"+ maxName

--####################################
fn exportProxyBylayer exportPath =
(
	if not (doesFileExist exportPath)do(makeDir (exportPath))
	for i = 0 to layerManager.count-1 where (layerManager.getLayer i).on == true do
	(
		ilayer = layerManager.getLayer i
		layerName = ilayer.name
		layer = ILayerManager.getLayerObject i
		layerNodes = refs.dependents layer
		format "Layer: %; nodes: %\n" layerName layerNodes
		ilayer.select true
		outPath = exportPath +"\\" + layerName +".vrmesh"
		exportfile outPath #noPrompt selectedOnly:true using:objExp
-- 		exportfile outPath #noPrompt selectedOnly:true
		vrayMeshExport meshFile:outPath autoCreateProxies:true exportMultiple:false animation:off animationRange:#explicit animationStart:0 animationEnd:0 animationRedrawViews:true
		deselect selection
	)
	shellLaunch "explorer.exe" exportPath
)
--get proxy from obj in scene #####################
fn renamebyProxyFileName =
(
	proxyFileName = makeUniqueArray (for o in objects where o.ishidden == false and classof o == vrayproxy collect o.filename )
	for f in proxyFileName do
	(
		color_ = random black white
-- 		vp = vrayproxy name:("thuy_"+(filterString f "\\")[7]) filename:f
		for o in objects where o.ishidden == false and classof o == vrayproxy and o.filename == f do
			(	
				pName = (filterString f "\\")[7]
				o.name = uniquename ((filterString pName ".")[1] + ".")
				o.wirecolor = color_
			)
	)
)
--####################################
fn renameByFirstSelection =
(
	sel = selection[1]
	for o in objects where o.ishidden == false do o.name = uniquename(sel.name + ".")
)
--####################################
fn cloneFirst =
(
		filterObj = Execute ("$'"+"*.001"+"'")
		objs = (for o in filterObj where o.ishidden == false collect o)
		for o in Objs do
		(
			c = copy o
			c.pos = [0,0,0]
			c.name = uniquename(c.name)
		)
)
-- ##################### funtion run #####################
-- renameByFirstSelection()
-- renamebyProxyFileName()
-- cloneFirst()
exportProxyBylayer exportPath
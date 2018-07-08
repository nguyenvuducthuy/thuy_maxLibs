rollout workWithName_ "Thuy_workWithName" width:170 height:180
(
	-- rename objects by mat name
	fn renameObjByMatname =
	(
		matNames = makeuniquearray(for o in geometry where o.material != undefined and o.ishidden == false collect o.material.name)
		for m in matNames do
		(
			color_ = random black white
			for o in geometry where o.material != undefined and o.ishidden == false and o.material.name == m do
				(
					o.name = m
					o.wirecolor = color_
				)
		)
	)
	--/////////////////////////////////////////////////////////////////////////////
	-- select objects by name
	fn selectObjByPattern =
	(
		name_ = "multimaterial_001"
		objects_ = Execute ("$'" + "*" + name_ + "*" + "'")
		select (for o in objects_ where o.ishidden == false collect o)
	)
	--/////////////////////////////////////////////////////////////////////////////
	fn renameObjectsByLayers =
	(
		for i = 0 to layerManager.count-1 where (layerManager.getLayer i).on == true do
		(
			ilayer = layerManager.getLayer i
			layerName = ilayer.name
			layer = ILayerManager.getLayerObject i
	-- 		layer.wirecolor = random black white
	-- 		layer.showFrozenInGray = false
			layer.nodes &nodes
			for n in nodes do n.name = uniquename layer.name
		)
	)
	--/////////////////////////////////////////////////////////////////////////////
	fn printObjName =
	(
		printCount = true
		oName = makeuniquearray(for o in geometry where o.ishidden == false collect o.name)
		if(printCount)then
		(
			for n in oname do
			(
				os = (for o in objects where o.name == n collect o)
				format "have % objs name '%'\n" os.count n
			)
		)
	)
	--/////////////////////////////////////////////////////////////////////////////
	fn setLayerNameBySelObj =
	(
		sel = $.name
		CurrentLayer = LayerManager.current
		CurrentLayer.setname(sel)
	)
	--/////////////////////////////////////////////////////////////////////////////
	--rename Layer___________________________
-- 	maxName = (filterString maxfilename ".")[1] as string
-- 	for i = 0 to layerManager.count-1 where (layerManager.getLayer i).on == true do
-- 	(
-- 		ilayer = layerManager.getLayer i
-- 		layerName = ilayer.name
-- 		ilayer.setname(maxName +"_"+ i as string)
-- 	)
	--_______________________________________
	-- ###############################################################################
	-- renameObjectsByLayers()
	-- printObjName()
	-- selectObjByPattern()
	-- renameObjByMatname()
	-- setNameBySelObj()
	-- ###############################################################################
-- 	edittext MatName text: "$.material" pos:[10,22.5] width:150 height:18

	button _renameObjectsByLayers_ 	"_renameObjectsByLayers_" 	pos:[10,50] 	width:150 	height:20
	button _printObjName_			"_printObjName_" 			pos:[10,75] 	width:150 	height:20
	button _selectObjByPattern_ 	"_selectObjByPattern_" 		pos:[10,100] 	width:150 	height:20
	button _renameObjByMatname_ 	"_renameObjByMatname_" 		pos:[10,125] 	width:150 	height:20
	button _setLayerNameBySelObj_ 	"_setLayerNameBySelObj_" 	pos:[10,150] 	width:150 	height:20

	on _renameObjectsByLayers_ pressed do
	(
		renameObjectsByLayers()
	)
	on _printObjName_ pressed do
	(
		printObjName()
	)
	on _selectObjByPattern_ pressed do
	(
		selectObjByPattern()
	)
	on _renameObjByMatname_ pressed do
	(
		renameObjByMatname()
	)
	on _setLayerNameBySelObj_ pressed do
	(
		setLayerNameBySelObj()
	)
)
createDialog workWithName_
-- ###############################################################################
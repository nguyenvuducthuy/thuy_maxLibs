--for i = 1 to 10 do teapot radius: (random 1.0 10.0) pos: (random [0,0,0] [100,100,0])
fn createLayerBySel =
(
	uniName = makeUniqueArray (for o in selection collect (trimRight o.name "1234567890"))
	sceneLayer = (for i = 0 to layerManager.count-1 collect ((layerManager.getLayer i).name))
	for i in uniName do (
		if( LayerManager.getLayerFromName i == undefined ) then
			(
				layer = layerManager.newlayer()
			)
			else
			(
				layer = LayerManager.getLayerFromName i
			)
		layer.setname (i as String)
		for o in selection where (trimRight o.name "1234567890") == i do layer.addnode o
	)
)
--###############renameLayer#########################
fn renameLayer =
(
	sceneLayer = (for i = 0 to layerManager.count-1 collect (layerManager.getLayer i))
	for l in sceneLayer where (matchPattern l.name pattern: "03_*") == false do l.setname ("03_"+l.name)
)
--###############################################
renameLayer()
-- createLayerBySel()
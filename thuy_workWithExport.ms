fn exportOBJBylayer exportPath =
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
		outPath = exportPath +"\\" + layerName +".obj"
		--//////////// start set obj export option ///////////////////
		theINI =objexp.getIniName()
		setIniSetting theINI"General" "Preset" "<NONE>"
		setIniSetting theINI"Geometry" "FaceType" "0"
		setIniSetting theINI"Geometry" "Normals" "0"
		setIniSetting theINI"Geometry" "TextureCoords" "1"
		setIniSetting theINI"Material" "UseMaterial" "1"
		setIniSetting theINI"Material" "CreateMatLibrary" "1"
		--//////////// end set obj export option ///////////////////
		exportfile outPath #noPrompt selectedOnly:true using:objExp
-- 		exportfile outPath #noPrompt selectedOnly:true
		deselect selection
	)
	shellLaunch "explorer.exe" exportPath
)
--####################################
-- Print all Project Sub-Directories:_______________________
-- for i = 1 to pathConfig.getProjectSubDirectoryCount() do
-- (format "%: %\n" i (pathConfig.getProjectSubDirectory i))
--####################################
fn saveMAXBylayer proxyPath =
(
	if not (doesFileExist proxyPath)do(makeDir (proxyPath))
	for i = 0 to layerManager.count-1 where (layerManager.getLayer i).on == true do
	(
		ilayer = layerManager.getLayer i
		layerName = ilayer.name
		layer = ILayerManager.getLayerObject i
		layerNodes = refs.dependents layer
		format "Layer: %; nodes: %\n" layerName layerNodes
		ilayer.select true
		outPath = proxyPath +"\\" + layerName +".max"
		savenodes selection outPath
		deselect selection
	)
	shellLaunch "explorer.exe" proxyPath
)
--####################################
fn alembicExport _filename _in _out _step _subStep _particleSystemToMeshConversion _automaticinstancing _facesets _purePointCache _normals _uvs _materialIDs _flattenHierarchy _transformCache _exportSelected _validateMeshTopology _storageFormat _objects
 =
(
	if not (doesFileExist _filename)do(makeDir (_filename))
	for i = 0 to layerManager.count-1 where (layerManager.getLayer i).on == true do
	(
		ilayer = layerManager.getLayer i
		layerName = ilayer.name
		layer = ILayerManager.getLayerObject i
		layerNodes = refs.dependents layer
		format "Layer: %; nodes: %\n" layerName layerNodes
		ilayer.select true
		outPath = _filename +"\\" + layerName +".abc"
		abcExportString =	(
							"filename="+ outPath +";"+
							"in="+ _in +";"+
							"out="+ _out +";"+
							"step="+ _step +";"+
							"subStep="+ _subStep +";"+
							"particleSystemToMeshConversion="+ _particleSystemToMeshConversion +";"+
							"automaticinstancing="+ _automaticinstancing +";"+
							"facesets="+ _facesets +";"+
							"purePointCache="+ _purePointCache +";"+
							"normals="+ _normals +";"+
							"uvs="+ _uvs+";"+
							"materialIDs="+ _materialIDs +";"+
							"flattenHierarchy="+ _flattenHierarchy +";"+
							"transformCache="+ _transformCache +";"+
							"exportSelected="+ _exportSelected +";"+
							"validateMeshTopology="+ _validateMeshTopology +";"+
							"storageFormat="+ _storageFormat
-- 							"objects= "+_objects
							)
		print abcExportString
		ExocortexAlembic.createExportJobs(abcExportString)
		deselect selection
	)
	shellLaunch "explorer.exe" exportPath
)
--####################################
fn saveIncrementOBJ exportPath =
(
	if not (doesFileExist exportPath)do(makeDir (exportPath))
	objs = (for o in geometry where o.ishidden == false collect o)
	for s in objs do
	(
		select s
		outPath = exportPath +"\\" + s.name +".obj"
		theINI =objexp.getIniName()
		setIniSetting theINI"General" "Preset" "<NONE>"
		setIniSetting theINI"Geometry" "FaceType" "0"
		setIniSetting theINI"Geometry" "TextureCoords" "1"
		setIniSetting theINI"Material" "UseMaterial" "1"
		setIniSetting theINI"Material" "CreateMatLibrary" "1"
		exportfile outPath #noPrompt selectedOnly:true using:objExp
	)
	deselect selection
	shellLaunch "explorer.exe" exportPath
)
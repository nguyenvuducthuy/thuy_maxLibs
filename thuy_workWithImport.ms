-- //////////////////////////////////////////////////////////
fn importSkp files =
(
	for f in files do
	(
		if (getFilenameType f == ".skp")then
		(
			oldObj = objects as array
			texPath = (getFilenamePath f) +"\\"+ (getFilenameFile f) as string
			makeDir (texPath)
-- 			===========
-- 			import skp
-- 			===========
			importfile f
-- 			===========

			fileName = getFilenameFile f
			print fileName
			layer = layerManager.newlayer()

		-- 	check Layer Name Exist
			checkLayerNameExist fileName

		-- 	rename layer
			layer.setname fileName
			newObj = for o in objects where findItem oldObj o == 0 collect o
			for o in newObj do layer.addnode o
		-- 	newObj.name = fileName
			layer.on = false
			max select none
		)else(format "% is not .skp" f)
	)
)

oldObj = objects as array
 --perform import here
newObj = for o in objects where findItem oldObj o == 0 collect o
-- //////////////////////////////////////////////////////////
fn importObj files =
(
	for f in files do
	(
		if (getFilenameType f == ".obj")then
		(
			oldObj = objects as array
-- 			===========
-- 			import obj
-- 			===========
			importfile f #noPrompt
-- 			===========

			fileName = getFilenameFile f
			print fileName
			layer = layerManager.newlayer()

		-- 	check Layer Name Exist
			checkLayerNameExist fileName

		-- 	rename layer
			layer.setname fileName
			newObj = for o in objects where findItem oldObj o == 0 collect o
			for o in newObj do layer.addnode o
		-- 	newObj.name = fileName
			layer.on = false
			max select none
		)else(format "% is not .obj" f)
	)
)
-- //////////////////////////////////////////////////////////
fn mergeMax files =
(
	for f in files do
	(
		if (getFilenameType f == ".max")then
		(
			oldObj = objects as array
-- 			===========
-- 			import max
-- 			===========
			mergemaxfile f
-- 			===========

			fileName = getFilenameFile f
			print fileName
			layer = layerManager.newlayer()

		-- 	check Layer Name Exist
			checkLayerNameExist fileName

		-- 	rename layer
			layer.setname fileName
			newObj = for o in objects where findItem oldObj o == 0 collect o
			for o in newObj do layer.addnode o
		-- 	newObj.name = fileName
			layer.on = false
			max select none
		)else(format "% is not .max" f)
	)
)
-- //////////////////////////////////////////////////////////
fn alembicImport_ files =
(
	for f in files do
	(
		if (getFilenameType f == ".abc")then
		(
			-- //////////// start set abc import option ///////////////////
			_filename = f
			_normals = "true"
			_uvs = "true"
			_materialIDs = "true"
			_attachToExising = "false"
			_loadGeometryInTopologyModifier = "true"
			_loadTimeControl = "true"
			_loadCurvesAsNURBS = "true"
			_meshSmoothModifiers = "true"
			_loadUserProperties = "false"
			_objectDuplication = "Instance"
			_filters = ""
			_includeChildren = "false"
			_failOnUnsupported = "false"
			--//////////// end set abc import option ///////////////////
			alembicImport _filename _normals _uvs _materialIDs _attachToExising _loadGeometryInTopologyModifier _loadTimeControl _loadCurvesAsNURBS _meshSmoothModifiers _loadUserProperties _objectDuplication _filters _includeChildren _failOnUnsupported
		)else(format "% is not .abc" f)
	)
)
-- ___________________________________
fn alembicImport _filename _normals _uvs _materialIDs _attachToExising _loadGeometryInTopologyModifier _loadTimeControl _loadCurvesAsNURBS _meshSmoothModifiers _loadUserProperties _objectDuplication _filters _includeChildren _failOnUnsupported
 =
(
	oldObj = objects as array

	outPath = _filename
	abcImportString =	(
						"filename="+ outPath +";"+
						"normals="+ _normals +";"+
						"uvs="+ _uvs +";"+
						"materialIDs="+ _materialIDs +";"+
						"attachToExising="+ _attachToExising +";"+
						"loadGeometryInTopologyModifier="+ _loadGeometryInTopologyModifier +";"+
						"loadTimeControl="+ _loadTimeControl +";"+
						"loadCurvesAsNURBS="+ _loadCurvesAsNURBS +";"+
						"meshSmoothModifiers="+ _meshSmoothModifiers +";"+
						"loadUserProperties="+ _loadUserProperties +";"+
						"objectDuplication="+ _objectDuplication +";"+
						"filters="+ _filters +";"+
						"includeChildren="+ _includeChildren +";"+
						"failOnUnsupported="+ _failOnUnsupported
						)
-- 	print abcImportString
-- 	alembic export\\\\\\\\\\\\\\\\\\\\
	ExocortexAlembic.createImportJob(abcImportString)
-- 	add to layer\\\\\\\\\\\\\\\\\\\\\\
	fileName = getFilenameFile _filename
	layer = layerManager.newlayer()

-- 	check Layer Name Exist
	checkLayerNameExist fileName

-- 	rename layer
	layer.setname fileName
	newObj = for o in objects where findItem oldObj o == 0 collect o
	for o in newObj do layer.addnode o
-- 	newObj.name = fileName
	layer.on = false
	max select none
)
-- //////////////////////////////////////////////////////////
fn checkLayerNameExist fileName=
(
	for i = 0 to layerManager.count-1 do
	(
		ilayer = layerManager.getLayer i
		layerName = ilayer.name
		if (layerName == fileName) then
		(
			ilayer.setname (layerName + "_old_" + (random 1.0 1000) as string )
		)
	)
)
-- //////////////////////////////////////////////////////////

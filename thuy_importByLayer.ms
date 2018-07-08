fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithImport.ms"
--//////////// start set global variable ///////////////////
global dir = ""
--//////////// end set global variable ///////////////////
rollout thuy_importBylayer_ "thuy_importBylayer" width:170 height:100
(
	checkbox _skp 		"_SKP_" 	across:2
	checkbox _obj 		"_OBJ_" 	across:2
	checkbox _max 		"_Max_" 	across:2
	checkbox _abc 		"_ABC_" 	across:2

	button	 _importFolder_ "_importFolder_" 	width:150
	button	 _import_ 		"_import_"		width:150

	on _importFolder_ pressed do
	(
		dir = getSavePath caption:"my dir" initialDir: (pathConfig.getProjectSubDirectory 3)
		print dir
	)
	on _import_ pressed do
	(
-- 		difine files////////////////////////////////
		local files = ""
-- 		///////////////////////////////////////////
		if (_skp.state)then
		(
			files = ( getFiles (dir + "\\*.skp" ))
			importSkp files
		)
		if (_obj.state)then
		(
			files = ( getFiles (dir + "\\*.obj" ))
			importObj files
		)
		if (_max.state)then
		(
			files = ( getFiles (dir + "\\*.max" ))
			mergeMax files
		)
		if (_abc.state)then
		(
			files = ( getFiles (dir + "\\*.abc" ))
			alembicImport_ files
		)
	)
)
-- -- //////////////////////////////////////////////////////////
-- mergeMax files
-- importSkp files
-- importObj files
-- -- //////////////////////////////////////////////////////////
-- -- //////////// start set abc import option ///////////////////
-- _filename = "C:\\Users\\anhungxadieu\\Desktop\\test.abc"
-- _normals = "true"
-- _uvs = "true"
-- _materialIDs = "true"
-- _attachToExising = "false"
-- _loadGeometryInTopologyModifier = "true"
-- _loadTimeControl = "true"
-- _loadCurvesAsNURBS = "true"
-- _meshSmoothModifiers = "true"
-- _loadUserProperties = "false"
-- _objectDuplication = "Instance"
-- _filters = ""
-- _includeChildren = "false"
-- _failOnUnsupported = "false"
-- --//////////// end set abc import option ///////////////////
-- alembicImport _filename _normals _uvs _materialIDs _attachToExising _loadGeometryInTopologyModifier _loadTimeControl _loadCurvesAsNURBS _meshSmoothModifiers _loadUserProperties _objectDuplication _filters _includeChildren _failOnUnsupported
-- -- //////////////////////////////////////////////////////////
-- ###############################################################################
-- createDialog thuy_importBylayer_
-- ###############################################################################
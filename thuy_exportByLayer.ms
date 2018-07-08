fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithExport.ms"
--//////////// start set global variable ///////////////////
global Project 		= "Project"
global instanceObj 	= "instanceObj"
global _exportPath_ = "_exportPath_"
global _proxyPath_ 	= "_proxyPath_"
global maxName 		= (filterString maxfilename ".")[1] as string
global exportPath 	= pathConfig.getProjectSubDirectory 3 	+"\\"+ _exportPath_ 	+"\\"+ Project +"\\" + instanceObj
global proxyPath 	= pathConfig.getProjectSubDirectory 20 	+"\\"+ _proxyPath_ 		+"\\"+ Project +"\\" + maxName
--//////////// end set global variable ///////////////////
rollout thuy_exportBylayer_ "thuy_exportBylayer" width:170 height:230
(
	edittext _Project		"_Project" 		text: "\\_Project_" 		labelOnTop:true
	edittext _instanceObj	"_instanceObj" 	text: ("\\" + maxName) 		labelOnTop:true
	edittext _exportPath 	"_exportPath" 	text: "\\obj\\asset"		labelOnTop:true
	edittext _proxyPath 	"_proxyPath" 	text: "_proxyPath_" 		labelOnTop:true

	checkbox _saveMAXBylayer_ 		"_MAX_" 		across:2
	checkbox _alembicExport_ 		"_alembic_" 		across:2
	checkbox _saveIncrementOBJ_ 	"_IncreOBJ_" 	across:2
	checkbox _exportOBJBylayer_ 	"_OBJ_" 	across:2

	button	 _export_ 				"_export_"
	on _export_ pressed do(
		if (_saveMAXBylayer_.state)then
		(
			-- _______________________
			Project 		= _Project.text
			instanceObj 	= _instanceObj.text
			_exportPath_ 	= _exportPath.text
			_proxyPath_ 	= _proxyPath.text
			exportPath 		= pathConfig.getProjectSubDirectory 3 	+ _exportPath_ + Project  + instanceObj
			-- _______________________
			saveMAXBylayer proxyPath
		)
		if (_alembicExport_.state)then
		(
			-- _______________________
			Project 		= _Project.text
			instanceObj 	= _instanceObj.text
			_exportPath_ 	= _exportPath.text
			_proxyPath_ 	= _proxyPath.text
			exportPath 		= pathConfig.getProjectSubDirectory 3 	+ _exportPath_ + Project  + instanceObj
			-- _______________________
			--//////////// start set abc export option ///////////////////
			_filename = exportPath as string
			_in = "1"
			_out = "1"
			_step = "1"
			_subStep = "1"
			_particleSystemToMeshConversion = "true"
			_automaticinstancing = "true"
			_facesets = "all"
			_purePointCache = "false"
			_normals = "true"
			_uvs = "true"
			_materialIDs = "true"
			_flattenHierarchy = "true"
			_transformCache = "false"
			_exportSelected = "true"
			_validateMeshTopology = "false"
			_storageFormat = "hdf5"
			_objects = ""
			--//////////// end set abc export option ///////////////////
			alembicExport _filename _in _out _step _subStep _particleSystemToMeshConversion _automaticinstancing _facesets _purePointCache _normals _uvs _materialIDs _flattenHierarchy _transformCache _exportSelected _validateMeshTopology _storageFormat _objects
		)
		if (_saveIncrementOBJ_.state)then
		(
			-- _______________________
			Project 		= _Project.text
			instanceObj 	= _instanceObj.text
			_exportPath_ 	= _exportPath.text
			_proxyPath_ 	= _proxyPath.text
			exportPath 	= pathConfig.getProjectSubDirectory 3 	+ _exportPath_ + Project  + instanceObj
			-- _______________________
			saveIncrementOBJ exportPath
		)
		if (_exportOBJBylayer_.state)then
		(
			-- _______________________
			Project 		= _Project.text
			instanceObj 	= _instanceObj.text
			_exportPath_ 	= _exportPath.text
			_proxyPath_ 	= _proxyPath.text
			exportPath 	= pathConfig.getProjectSubDirectory 3 	+ _exportPath_ + Project  + instanceObj
			-- _______________________
			exportOBJBylayer exportPath
		)
	)
-- ###############################################################################
)
createDialog thuy_exportBylayer_
-- ###############################################################################
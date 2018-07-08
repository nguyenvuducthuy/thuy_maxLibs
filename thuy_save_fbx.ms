scene_= maxFilePath + maxFileName
sPath = getFilenamePath scene_
sName = getFilenameFile scene_

-- for o in geometry do saveNodes (path_+o.name+".max")

inPath = "D:\\thuy_3dsmax\\sceneassets\\model\\R&D group\\iTrees vol.2 Summer\\Vray\\"
theFiles = getFiles(inPath+"*max")
makeDir (outPath = "D:\\thuy_3dsmax\\sceneassets\\model\\thuy_itrees-02\\")
fbxPresetFile = "D:\\thuy_3dsmax\\sceneassets\\model\\anhungxadieu.fbxexportpreset"

for f in theFiles do
( 	loadMaxFile(f)
	for o in geometry do (

		FBXExporterSetParam "LoadExportPresetFile" fbxPresetFile
		select o; exportFile(outPath+o.name+".fbx")#noPrompt selectedOnly:true
		)
)

shellLaunch "Explorer.exe" outPath
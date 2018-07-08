fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithMaterial.ms"
try(destroyDialog workWithMaterial)catch()

rollout workWithMaterial "Thuy_workWithMaterials" width:170 height:30
(
	button _nameMatByTextName_ 	"_nameMatByTextName_" 	width:150
-- 	button _replaceDSideMat_ 	"_replaceDSideMat_" 	width:150
-- 	button _replaceVray2Sided_ 	"_replaceVray2Sided_" 	width:150
-- 	button _replaceVrayblend_ 	"_replaceVrayblend_" 	width:150
-- 	button _nameTextureByLayers_"_nameTextureByLayers_" width:150

	on _nameMatByTextName_ pressed do
	(
		nameMatByTextName()
	)
-- 	on _replaceDSideMat_ pressed do
-- 	(
-- 		replaceDSideMat()
-- 	)
-- 	on _replaceVray2Sided_ pressed do
-- 	(
-- 		replaceVray2Sided()
-- 	)
-- 	on _replaceVrayblend_ pressed do
-- 	(
-- 		replaceVrayblend()
-- 	)
-- 	on _nameTextureByLayers_ pressed do
-- 	(
-- 		nameTextureByLayers()
-- 	)
)
-- ###############################################################################
createDialog workWithMaterial
-- ###############################################################################

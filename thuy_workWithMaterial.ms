fn getColorFloat color_ =
(
	r = (color_.r/255) as string
	g = (color_.g/255) as string
	b = (color_.b/255) as string
	colorArray = r +"_"+ g +"_"+ b + "_col"
)
fn getColorAverage color_ =
(
	r = (color_.r/255)
	g = (color_.g/255)
	b = (color_.b/255)
	colorArray = (r + g + b)/3
)
-- /////////////////////////////////////////////////////////////////////////////
fn replaceDSideMat =
(
	mats = for o in objects where not o.ishidden and classof o.material == multimaterial collect o.material
	for mat in mats do for i = 1 to mat.count where classof mat[i] == DoubleSided do
	(
		if (mat[i].material1.diffuseMap != None)
		then
			mat[i] = mat[i].material1
		else
			mat[i] = mat[i].material2
	-- 	print mat[i]
	)
)
-- /////////////////////////////////////////////////////////////////////////////
fn replaceVray2Sided =
(
	for o in geometry where (o.ishidden == false) and (o.material != undefined) do
	(
		mat = o.material
		if (classof mat == VRay2SidedMtl)then
		(
			matF = mat.frontMtl
			o.material =  matF
		)
	)
	mats = for o in objects where not o.ishidden and classof o.material == multimaterial collect o.material
	for mat in mats do for i = 1 to mat.count where classof mat[i] == VRay2SidedMtl do
	(
		mat[i] = mat[i].frontMtl
	)
)
--////////////////////////////////////////////////////////////////
fn getMapName mat =
(
-- 	get material data/////////////
	dif = mat.diffuse
	difMap = if classof mat.diffuseMap == Bitmaptexture then mat.diffuseMap else undefined
	opaLev = mat.opacity
	opaMap = if classof mat.opacityMap == Bitmaptexture then mat.opacityMap else undefined
	spe = mat.specular
	speMap = if classof mat.specularMap == Bitmaptexture then mat.specularMap else undefined
	speLev = mat.specularLevel
	speLevMap = if classof mat.specularLevelMap == Bitmaptexture then mat.specularLevelMap else undefined
	bumLev = mat.bumpMapAmount
	bumMap = if classof mat.bumpMap == Bitmaptexture then mat.bumpMap else undefined
-- 	/////////////////////////////
	dmap = "None"
	oLev = "None"
	omap = "None"
	sLev = "None"
	smap = "None"
	bLev = "None"
	bmap = "None"
-- 	diffuse_////////////////////
	if(difmap != undefined )then
	(
		try
		(
			texPath = difMap.filename
			texPathArray = (filterstring texPath "\\")
			dmap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % difMap_ in material:<<%>>\n" dmap mat
	)
	else
	(
		dmap = getColorFloat(dif) as string
-- 		format "have no map on bump in material:<<%>>\n" mat
	)
-- 	specular_////////////////////
	sLev = (speLev/100) as string
	if(speMap != undefined )then
	(
		try
		(
			texPath = speMap.filename
			texPathArray = (filterstring texPath "\\")
			smap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % difMap_ in material:<<%>>\n" smap mat
	)
	else
	(
		smap = getColorFloat(spe) as string
-- 		format "have no map on bump in material:<<%>>\n" mat
	)
-- 	opacity_////////////////////
	oLev = (opaLev/100) as string
	if(opaMap != undefined )then
	(
		try
		(
			texPath = opaMap.filename
			texPathArray = (filterstring texPath "\\")
			omap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % opaMap_ in material:<<%>>\n" omap mat
	)
	else
	(
-- 		format "have no map on bump in material:<<%>>\n" mat
	)

-- 	bump_////////////////////
	bLev = (bumLev/100) as string
	if(bumMap != undefined )then
	(
		try
		(
			texPath = bumMap.filename
			texPathArray = (filterstring texPath "\\")
			bmap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % bumMap_ in material:<<%>>\n" bmap mat
	)
	else
	(
-- 		format "have no map on bump in material:<<%>>\n" mat
	)
	matName = dmap +"_dauma_"+ omap +"_dauma_"+ oLev +"_dauma_"+ smap +"_dauma_"+ sLev +"_dauma_"+ bmap +"_dauma_"+ bLev
)
-- ///////////////////////////////////////////////////////////////////////////////////////
fn getMapNameV mat =
(
-- 	get material data/////////////
	dif = mat.diffuse
	difMap = if classof mat.texmap_diffuse == Bitmaptexture then mat.texmap_diffuse else undefined
	opa = mat.refraction
	opaMap = if classof mat.texmap_refraction == Bitmaptexture then mat.texmap_refraction else undefined
	opaGlo = mat.refraction_glossiness
	spe = mat.reflection
	speMap = if classof mat.texmap_reflection == Bitmaptexture then mat.texmap_reflection else undefined
	speGlo = mat.reflection_glossiness
	bumMap = if classof mat.texmap_bump == Bitmaptexture then mat.texmap_bump else undefined
	bumLev = mat.texmap_bump_multiplier
-- 	/////////////////////////////
	dmap = "None"
	oGlo = "None"
	omap = "None"
	sGlo = "None"
	smap = "None"
	bLev = "None"
	bmap = "None"
-- 	diffuse_////////////////////
	if(difmap != undefined )then
	(
		try
		(
			texPath = difMap.filename
			texPathArray = (filterstring texPath "\\")
			dmap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % difMap_ in material:<<%>>\n" dmap mat
	)
	else
	(
		dmap = getColorFloat(dif) as string
-- 		format "have no map on bump in material:<<%>>\n" mat
	)
-- 	specular_////////////////////
	sGlo = (speGlo) as string
	if(speMap != undefined )then
	(
		try
		(
			texPath = speMap.filename
			texPathArray = (filterstring texPath "\\")
			smap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % difMap_ in material:<<%>>\n" smap mat
	)
	else
	(
		smap = getColorFloat(spe) as string
-- 		format "have no map on bump in material:<<%>>\n" mat
	)
-- 	opacity_////////////////////
	oGlo = (opaGlo) as string
	oLev = (1-getColorAverage(opa)) as string
	if(opaMap != undefined )then
	(
		try
		(
			texPath = opaMap.filename
			texPathArray = (filterstring texPath "\\")
			omap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % opaMap_ in material:<<%>>\n" omap mat
	)
	else
	(
-- 		format "have no map on bump in material:<<%>>\n" mat
	)

-- 	bump_////////////////////
	bLev = (bumLev/100) as string
	if(bumMap != undefined )then
	(
		try
		(
			texPath = bumMap.filename
			texPathArray = (filterstring texPath "\\")
			bmap = texPathArray[texPathArray.count]
		)
		catch
		(
			print (format "texture false: %" mat.name)
			result = undefined
		)
-- 		format "have % bumMap_ in material:<<%>>\n" bmap mat
	)
	else
	(
-- 		format "have no map on bump in material:<<%>>\n" mat
	)
	matName = dmap +"_dauma_"+ omap +"_dauma_"+ oLev +"_dauma_"+ smap +"_dauma_"+ sGlo +"_dauma_"+ bmap +"_dauma_"+ bLev
)
-- ///////////////////////////////////////////////////////////////////////////////////////
fn nameMatByTextName =
(
	try
	(
		for o in geometry where (o.ishidden == false) and (o.material != undefined) and (classof o != ObjectSet)do
		(
			mat = o.material
			matType = classof mat
			matName = ""
			if(classof mat == multimaterial)then
			(
				for m in mat where m != none do
				(
					matType = classof m

					case matType of
					(
						VRayMtl: matName = getMapNameV m
						standardmaterial: matName = getMapName m
						default: format "this % in % can't rename\n" m.name o.name
					)
					mat.name = uniqueName("multimaterial_")
					m.name = matName
				)
			)
			else
			(
				case matType of
				(
					VRayMtl: matName = getMapNameV mat
					standardmaterial: matName = getMapName mat
					default: format "this % in % can't rename" mat.name o.name
				)
				mat.name = matName
			)
		)
	)catch()
)
-- ///////////////////////////////////////////////////////////////////////////////////////
fn replaceVrayblend =
(
	for o in geometry where (o.ishidden == false) and (o.material != undefined) do
	(
		mat = o.material
		if (classof mat == VRayBlendMtl)then
		(
			matF = mat.Base_mtl
			o.material =  matF
		)
	)
	mats = for o in objects where not o.ishidden and classof o.material == multimaterial collect o.material
	for mat in mats do for i = 1 to mat.count where classof mat[i] == VRayBlendMtl do
	(
		mat[i] = mat[i].Base_mtl
	)
)
-- ///////////////////////////////////////////////////////////////////////////////////////
fn nameTextureByLayers =
(
	for i = 0 to layerManager.count-1 where (layerManager.getLayer i).on == true do
	(
		ilayer = layerManager.getLayer i
		layerName = ilayer.name
		layer = ILayerManager.getLayerObject i
		layer.nodes &nodes
		for n in nodes do
		(
			maps = getClassInstances bitmapTexture target: n
			for m in maps do
			(
				textFilePath = m.filename
				newFile = (getFilenamePath textFilePath) + layer.name +"_"+ (getFilenameFile textFilePath) + (getFilenameType textFilePath)
				renameFile m.filename newFile
				m.filename = newFile
			)
		)
	)
)
-- ///////////////////////////////////////////////////////////////////////////////////////
function toMultiSubMat =
(
	if selection.count >= 1 then
		(
			local selectedGeom = selection as array
			local newMat = multisubmaterial()
			newMat.name = "newMat"
			newMat.count = 0
			meditMaterials[1] = newMat

			addModifier selectedGeom[1] (Materialmodifier ())
			selectedGeom[1].modifiers[#Material].materialID = 1
			newMat.material[1] = selectedGeom[1].material
			selectedGeom[1].material = newMat

			for i in 2 to selectedGeom.count do
			(
				doesMatExist = findItem newMat.material selectedGeom[i].material

				--print doesMatExist
				if doesMatExist == 0 then
				(
					addModifier selectedGeom[i] (Materialmodifier ())
					selectedGeom[i].modifiers[#Material].materialID = newMat.material.count+1
					newMat.material[newMat.material.count+1] = selectedGeom[i].material
					selectedGeom[i].material = newMat
				)
				else
				(
					addModifier selectedGeom[i] (Materialmodifier ())
					selectedGeom[i].modifiers[#Material].materialID = doesMatExist
					selectedGeom[i].material = newMat
				)
			)
		)
)
-- ///////////////////////////////////////////////////////////////////////////////////////
-- fn selectOBJMisMat =
-- (
--      --st = timestamp(); sh = heapfree

--      materials = #()
--      fn CollectMaterials arg mat = appendifunique materials mat

--      for j in scenematerials do enumeratefiles j CollectMaterials j #missing

--      nodes = for j in objects where (finditem materials j.material) != 0 collect j
--      select nodes

--      --format "time:% ram:%\n" (timestamp()-st) (sh-heapfree)
-- )
-- ///////////////////////////////////////////////////////////////////////////////////////

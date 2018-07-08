fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxLibs\\thuy_maxUtils.ms"

rollout thuy_place_OBJ "Thuy Place Obj"
(

	pickbutton selectObj "Select Obj" width:140
	spinner x  	"x" type:#float range:[-100000,100000,0]
	spinner y 	"y" type:#float range:[-100000,100000,0]
	spinner z 	"z" type:#float range:[-100000,100000,0]

	button _place_ ">>place at cencer<<" width:140

	on selectObj picked obj do
	(
		if obj != undefined then
		(
			selectObj.text = obj.name
		)
	)
	on _place_ pressed do
	(
		targets = selection
		try
		(
			for t in targets do
			(
				inst = instance selectObj.object
				inst.position = t.position + [x.value,y.value,z.value]
				inst.wirecolor = t.wirecolor
			)
		)catch()
	)
)
rollout thuy_UVXform "thuy uv xfrom"
(
-- 	spinner uvTileing 	"uvTileing" type:#float range:[-10,10,0]
	pickbutton startObj_ "start Obj" width:140
	pickbutton surface_ "Surface" width:140
	pickbutton targetSurface "target Surface" width:140
	button _hit_ ">>hit<<" width:140

	on startObj_ picked obj do
	(
		if obj != undefined then
		(
			startObj_.text = obj.name
		)
	)
	on surface_ picked obj do
	(
		if obj != undefined then
		(
			surface_.text = obj.name
		)
	)
	on targetSurface picked obj do
	(
		if obj != undefined then
		(
			targetSurface.text = obj.name
		)
	)
	on _hit_ pressed do
	(
		try
		(
			startObj = startObj_.object
			surface = surface_.object

			count_ = surface_.object.lengthsegs - 1
			uvTileing = 1.0/(count_+1)
			minVal = 0
			maxVal = 1 - uvTileing

			lerpOut = LerpArray minVal maxVal count_
			print lerpOut

			theintsRay = thuyIntsRay startObj surface
			if theintsRay != undefined then
			(
				id = (theintsRay[2]+1)/2
				arrayTMP = #()

				for v in lerpOut do
				(
					for u in lerpOut do
					(
						append arrayTMP [u,v]
					)
				)
				u = arrayTMP[id][1]
				v = arrayTMP[id][2]

				targetSurface.object.modifiers[1].U_Tile = uvTileing
				targetSurface.object.modifiers[1].V_Tile = uvTileing
				targetSurface.object.modifiers[1].U_Offset = u
				targetSurface.object.modifiers[1].V_Offset = v

-- 				format "u = % | v = %\n" u v
-- 				print id
				print arrayTMP
			)
		)catch()
	)
)

fn collectElementFirstVerts node = if iskindof node Editable_Mesh do
 (
 	getelement = meshop.getelementsusingface
 	geteverts = meshop.getVertsUsingFace

 	faces = #{1..node.numfaces}
 	verts = #()
 	while not faces.isEmpty do for f in faces while
 	(
 		ee = getelement node f
 		faces -= ee
 		append verts (geteverts node ee)
 		off
 	)
 	do()
 	verts
 )

fn collectElements node = if iskindof node Editable_Mesh do
 (
 	getelement = meshop.getelementsusingface
 	geteverts = meshop.getVertsUsingFace

 	faces = #{1..node.numfaces}
 	result = #()
 	while not faces.isEmpty do for f in faces while
 	(
 		ee = getelement node f
 		faces -= ee
 		append result ee
 		off
 	)
 	do()
 	result
 )

fn findOverlapeVerts inMesh islands =
(
	xViewChecker.on = true
	xViewChecker.activeIndex = 6
	xViewChecker.selectResults 0
	overVerts = inMesh.selectedVerts as BitArray
	xViewChecker.on = false

	result = #{}
	allVerts = #{1..inMesh.numVerts}
	for i in islands do
	(
		sub = (overVerts - (allVerts-i))
		res = (overVerts - sub)
-- 		format "overVerts: % - island: % = sub: %\n" overVerts i sub
		for v in sub do for o in res where distance inMesh.verts[v].pos inMesh.verts[o].pos < 0.00001 do
		(
-- 			print v
			deleteItem sub v
			deleteItem sub o
		)
		if sub.numberset > 1 then result += sub
	)
	result
)

fn findOlVertsPerE inmesh overVerts islands =
(
	result = #{}
	allVerts = #{1..inMesh.numVerts}
	for i in islands do
	(
		sub = (overVerts - (allVerts-i))
		res = (overVerts - sub)
-- 		format "overVerts: % - island: % = sub: %\n" overVerts i sub
		for v in sub do for o in res where distance inMesh.verts[v].pos inMesh.verts[o].pos < 0.00001 do
		(
-- 			print v
			deleteItem sub v
			deleteItem sub o
		)
		if sub.numberset > 1 then result += sub
	)
	result
)

/**************************************************  ********************
    DESCRIPTION:    Get all mesh elements
    AUTHOR:         Jorge Rodríguez
    DATE:           09.19.2013

    PARAMETERS:
        node:   An Editable_mesh
    RETURNS:
        An Array of Bitarrays, where each Bitarray has the faces
        of the Mesh element.
    NOTES:
        You can speed it up around 30% by unrolling the k loops.
**************************************************  ********************/

fn GetAllMeshElements node =
(
    try(heapsize = 536870912L)catch(print "Can't Allocate Heap") -- For large meshes

    local tmesh = snapshotasmesh node
    local faces = #{1..tmesh.numfaces}
    local verts = for v = 1 to tmesh.numverts collect #()
    local elements = #()

    for j in faces do
    (
        f = getface tmesh j
        for k = 1 to 3 do append verts[f[k]] j
    )

    for i in faces do
    (
        element = #(i)
        for j in element where faces[j] do
        (
            faces[j] = false
            f = getface tmesh j
            for k = 1 to 3 where verts[f[k]] != undefined do
            (
                join element verts[f[k]]
                verts[f[k]] = undefined
            )
        )
        append elements (element as bitarray)
    )
    return elements
)
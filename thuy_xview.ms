fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxUtils.ms"
fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithMaterial.ms"
-- fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithDotnet.ms"
fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithRender.ms"
fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_workWithObjs.ms"
fileIn @"D:\Dropbox\anhungxadieu_3d\3dsmax\maxscripts\download\SoulburnScriptsPack_3dsMax_v105_R2013toR2017\scripts\SoulburnScripts\lib\sLib.ms"


fn checkVertsOverlape input = (
    islands = (collectElementFirstVerts input)
    result = (findOverlapeVerts input islands)
    result
)

(
global overlapeVertsPerElem
struct overlapeVertsE
(
--     FaceAreaThresholdMin = 1,
--     FaceAreaThresholdMax = 10,
--     faceAreaDialog = undefined,

    fn geomCheck theTime theNode theResults =
    (
        local theCount = case classof theNode of
        (
        Editable_Poly: theNode.numverts
        Editable_Mesh: theNode.numverts
        )
        local theAreaMethod = case classof theNode of
        (
        Editable_Poly: checkVertsOverlape
        Editable_Mesh: checkVertsOverlape
        )

        overVerts = theNode.selectedVerts as bitarray
        islands = (collectElementFirstVerts theNode)
        result = #{}
        allVerts = #{1..theNode.numVerts}
        for i in islands do
        (
            sub = (overVerts - (allVerts-i))
            res = (overVerts - sub)
    --      format "overVerts: % - island: % = sub: %\n" overVerts i sub
            for v in sub do for o in res where distance theNode.verts[v].pos theNode.verts[o].pos < 0.00001 do
            (
    --          print v
                deleteItem sub v
                deleteItem sub o
            )
            if sub.numberset > 1 then result += sub
        )
        for i in result do append theResults i
--         print theResults

--         getelement = meshop.getelementsusingface
--         geteverts = meshop.getVertsUsingFace

--         faces = #{1..theNode.numfaces}
--         while not faces.isEmpty do for f in faces while
--         (
--             ee = getelement theNode f
--             faces -= ee
--             verts = (geteverts theNode ee)
--             while not verts.isEmpty do for v in verts while
--             (
--                 verts -= #{v}
--                 for i in verts where (distance theNode.verts[i].pos theNode.verts[v].pos) < 0.01 do(
--                     append theResults v
--                     append theResults i
--                     verts -= #{i}
--                 )
--                 off
--             )
--             do()
--             off
--         )
--         do()
    1
    ),

    fn supportedCheck theNode =
    (
      classof theNode == Editable_Mesh or classof theNode == Editable_Poly
    )

--     fn configDlg =
--     (
--       try(destroyDialog overlapeVertsPerElem.faceAreaDialog)catch()
--       rollout faceAreaDialog "Face Area Checker"
--       (
--         spinner spn_FaceAreaThresholdMin "Min. Threshold:" range:[0,1000000,overlapeVertsPerElem.FaceAreaThresholdMin] offset:[7,-3] type:#worldUnits
--         spinner spn_FaceAreaThresholdMax "Max. Threshold:" range:[0,1000000,overlapeVertsPerElem.FaceAreaThresholdMax] offset:[7,-3] type:#worldUnits

--         fn updateDisplay =
--         (
--           XViewChecker.runCheck CurrentTime
--           max views redraw
--         )
--         on spn_FaceAreaThresholdMin changed val do
--         (
--           overlapeVertsPerElem.FaceAreaThresholdMin = val
--           updateDisplay()
--         )
--         on spn_FaceAreaThresholdMax changed val do
--         (
--           overlapeVertsPerElem.FaceAreaThresholdMax = val
--           updateDisplay()
--         )
--       )--end rollout

--       createDialog faceAreaDialog
--       setDialogPos faceAreaDialog mouse.screenpos
--       overlapeVertsPerElem.faceAreaDialog = faceAreaDialog
--     )
)--end struct

try(destroyDialog overlapeVertsPerElem.faceAreaDialog)catch()
overlapeVertsPerElem = overlapeVertsE()

XViewChecker.unRegisterChecker "Vertices overlape per element"
XViewChecker.registerChecker overlapeVertsPerElem.geomCheck overlapeVertsPerElem.supportedCheck #Vertices "Vertices overlape per element" /* overlapeVertsPerElem.configDlg */ undefined undefined
)--end script

(
global showSelVerts
struct showVerts
(
    fn geomCheck theTime theNode theResults =
    (
        local theCount = case classof theNode of
        (
        Editable_Poly: theNode.numverts
        Editable_Mesh: theNode.numverts
        )
        local theAreaMethod = case classof theNode of
        (
        Editable_Poly: checkVertsOverlape
        Editable_Mesh: checkVertsOverlape
        )

        for i in theNode.selectedVerts as bitarray do append theResults i
    1
    ),

    fn supportedCheck theNode =
    (
      classof theNode == Editable_Mesh or classof theNode == Editable_Poly
    )

)--end struct

showSelVerts = showVerts()
XViewChecker.unRegisterChecker "show sel verts"
XViewChecker.registerChecker showSelVerts.geomCheck showSelVerts.supportedCheck #Vertices "show sel verts" undefined undefined undefined
)--end script






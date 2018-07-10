fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxLibs\\thuy_maxUtils.ms"
fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxLibs\\thuy_workWithMaterial.ms"
-- fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxLibs\\thuy_workWithDotnet.ms"
fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxLibs\\thuy_workWithRender.ms"
fileIn "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\thuy_maxLibs\\thuy_workWithObjs.ms"
fileIn @"D:\Dropbox\anhungxadieu_3d\3dsmax\maxscripts\download\SoulburnScriptsPack_3dsMax_v105_R2013toR2017\scripts\SoulburnScripts\lib\sLib.ms"

-- /////////////////////////////////////////////////////////////////////////////////////
rollout test "Test" width:300
(
        slider tilt "Head tilt" type:#integer orient:#horizontal    ticks:5 range:[-30,30,0]
        on tilt changed val do print val
)
-- =========
-- test area///////////////////////////
-- =========
-- thuy_renderElement()
-- createDialog thuy_UVXform

fn cropImag img rec = (
     -- Function cropImag body
    retBmp = dotnetObject "System.Drawing.Bitmap" 128 128
    g = (dotnetclass "system.drawing.graphics").fromImage retBmp
    g.drawimage img rec
    return retBmp
)

-- fName = "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\misc\\manga_eyes_expression_1.png"
-- rec = dotnetObject "System.Drawing.Rectangle" 0 0 512 512
-- img = (dotnetclass "System.Drawing.Image").fromfile fName
-- cropimg = cropImag img rec


-- mButton = dotNetObject "System.Windows.Forms.Button"
-- mButton.size = dotNetObject "System.Drawing.Size" 128 128
-- -- mButton.text = "BIG DotNet Button"
-- mButton.location = dotNetObject "System.Drawing.Point" 60 60
-- mButton.image = cropimg
-- --Create a DotNet Form
-- hForm = dotNetObject "System.Windows.Forms.Form"
-- hForm.controls.add mButton --add the Button to the Form
-- hForm.topmost = true
-- hForm.show()



-- json = Python.Import "json"
-- bi = python.Import "__builtin__"
-- struct thuy
-- (
--    kaka="thuy",kuku="thoa"
-- )
-- kuku = thuy()
-- d = bi.dict thuy:kuku.kaka thuy2:kuku.kuku

-- file = bi.open "d:\\thuy.json" "w"
-- json.dump d file indent:2 separators:#(",", ":")
-- file.close()


-- CAT ref pose
-- thuy = $ApeHead.controller.setupTM
-- $.controller.setupTM = thuy
-- print thuy
-- print $.controller.setupTM

struct thuy1
(
        name = "thuy1",
        thuy=(rollout thuy "daume" (
                button btn "daume"
--                 on thuy open do (print "daume")
        ))
)

struct thuy2
(
        name="thuy2",
        thuy=(rollout thuy "kuku" (
                button btn "kuku"
--                 on thuy open do (print "kuku")
        ))
)

-- t1 = thuy1()
-- t2 = thuy2()
-- theNewFloater = newRolloutFloater    "Grinning" 300 400
-- addRollout t1.thuy theNewFloater
-- addRollout t2.thuy theNewFloater

-- islands = (collectElementFirstVerts $)
-- $.selectedVerts = (findOverlapeVerts $ islands)

-- $.selectedVerts = result
-- ////////////////////////////////////
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- createDialog listview_
-- createDialog treeView_
-- renameCamByLayer()
-- thuy_renderElement()
-- thuy_showLayerInList printLayerNames: true
-- toMultiSubMat()
-- createDialog test
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



-- --Create a rollout
-- try(cui.unRegisterDialogBar testR)catch()
-- try(destroyDialog testR)catch()
-- rollout testR "test"
-- (
--         button dockLeftBt "Dock Left"
--         button floatBt "Float"
--         button closeBt "Close"

--         --Register the rollout as a dialogBar then dock it to the left.
--         on dockLeftBt pressed do
--         (
--                 cui.registerDialogBar testR
--                 cui.dockDialogBar testR #cui_dock_left
--         )

--         --Float dialog if it is registered as a dialogBar
--         on floatBt pressed do
--         (
--                 if testR.dialogBar then (cui.floatDialogBar testR)
--         )

--         --Unregister dialogBar bar before trying to close it using destroyDialog.
--         on closeBt pressed do
--         (
--                 if testR.dialogBar then (cui.unRegisterDialogBar testR)
--                 destroyDialog testR
--         )
-- )

-- --Display the rollout.
-- createDialog testR





(
global FaceAreaChecker
struct FaceAreaCheckerStruct
(
FaceAreaThresholdMin = 1,
FaceAreaThresholdMax = 10,
faceAreaDialog = undefined,

fn geomCheck theTime theNode theResults =
(
    local theCount = case classof theNode of
    (
        Editable_Poly: getNumFaces theNode
        Editable_Mesh: theNode.numfaces
    )
    local theAreaMethod = case classof theNode of
    (
        Editable_Poly: polyOp.getFaceArea
        Editable_Mesh: meshOp.getFaceArea
    )

    for f = 1 to theCount do
    (
        local theArea = theAreaMethod theNode f
        if theArea >= FaceAreaChecker.FaceAreaThresholdMin and theArea <= FaceAreaChecker.FaceAreaThresholdMax do append theResults f
    )
3
),

fn supportedCheck theNode =
(
    classof theNode == Editable_Mesh or classof theNode == Editable_Poly
),

fn configDlg =
(
    try(destroyDialog FaceAreaChecker.faceAreaDialog)catch()
    rollout faceAreaDialog "Face Area Checker"
    (
        spinner spn_FaceAreaThresholdMin "Min. Threshold:" range:[0,1000000,FaceAreaChecker.FaceAreaThresholdMin] offset:[7,-3] type:#worldUnits
        spinner spn_FaceAreaThresholdMax "Max. Threshold:" range:[0,1000000,FaceAreaChecker.FaceAreaThresholdMax] offset:[7,-3] type:#worldUnits

        fn updateDisplay =
        (
            XViewChecker.runCheck CurrentTime
            max views redraw
        )
        on spn_FaceAreaThresholdMin changed val do
        (
            FaceAreaChecker.FaceAreaThresholdMin = val
            updateDisplay()
        )
        on spn_FaceAreaThresholdMax changed val do
        (
            FaceAreaChecker.FaceAreaThresholdMax = val
            updateDisplay()
        )
    )--end rollout

    createDialog faceAreaDialog
    setDialogPos faceAreaDialog mouse.screenpos
    FaceAreaChecker.faceAreaDialog = faceAreaDialog
)
)--end struct

-- try(destroyDialog FaceAreaChecker.faceAreaDialog)catch()
-- FaceAreaChecker = FaceAreaCheckerStruct()

-- XViewChecker.unRegisterChecker "Face Area Checker"
-- XViewChecker.registerChecker FaceAreaChecker.geomCheck FaceAreaChecker.supportedCheck #Faces "Face Area Checker" FaceAreaChecker.configDlg undefined undefined
)--end script

LoadDllsFromDir "E:/thuy_3dsmax/3dsmax api/mxsCmd/mxsCmd/mxsCmd/out/" "mxsCmd.dll"

-- (
--     with undo off with redraw off
--     (
--         delete objects
--         node = converttopoly (box lengthsegs:17 widthsegs:17 heightsegs:17)
--         polyop.breakverts node #{1..node.numverts}
--         for j = 1 to 5 do polyop.meshsmoothbyface node #{1..node.numfaces}
--         converttomesh node
--     )
-- )

-- gc()
st = timestamp(); sh = heapfree
islands = meshop.thuyGetAllElements $ level:1
-- overVerts = meshop.thuyGetOverlapeVertsPerElement $
-- result = findOlVertsPerE $ overVerts islands
-- print result
format "c++ \ntime:% ram:% faces:% elements:%\n%\n" (timestamp()-st) (sh-heapfree) $.numfaces islands.count elements
-- format "c++ \ntime:% ram:% \n" (timestamp()-st) (sh-heapfree)

-- gc()
-- st = timestamp(); sh = heapfree
-- elements = GetAllMeshElements $
-- format "mxs algorithem \ntime:% ram:% faces:% elements:%\n%\n" (timestamp()-st) (sh-heapfree) $.numfaces elements.count elements

-- gc()
-- st = timestamp(); sh = heapfree
-- elements = collectElements $
-- format "mxs \ntime:% ram:% faces:% elements:%\n%\n" (timestamp()-st) (sh-heapfree) $.numfaces elements.count elements




-- paren = for i in objects where classof i == CATParent collect i
-- for i=1 to paren[1].numLayers do
-- (
--     layer = paren[1].layers.controller[i]
--     if layer.name == "anhungxadieu" then
--     (
--         layer.LayerEnabled = true
-- --         layer.TransformNodeOn = false
--     ) else(
-- --         layer.TransformNodeOn = false
--         layer.LayerEnabled = false
-- )
-- )




-- .LayerName : TSTR by value
-- .LayerColour : color by value
-- .LayerType : TSTR by value
-- .LayerEnabled : boolean
-- .TransformNodeOn : boolean
-- .RemoveDisplacement : boolean
-- .LayerIndex : index
-- .CATParent : node
-- .Weights : float
-- .Transform : transform

-- getTimeRange $[3].track #children
-- getSubAnimName $[3][2] 2
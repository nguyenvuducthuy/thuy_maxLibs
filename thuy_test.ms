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





-- (
-- global FaceAreaChecker
-- struct FaceAreaCheckerStruct
-- (
-- FaceAreaThresholdMin = 1,
-- FaceAreaThresholdMax = 10,
-- faceAreaDialog = undefined,

-- fn geomCheck theTime theNode theResults =
-- (
--     local theCount = case classof theNode of
--     (
--         Editable_Poly: getNumFaces theNode
--         Editable_Mesh: theNode.numfaces
--     )
--     local theAreaMethod = case classof theNode of
--     (
--         Editable_Poly: polyOp.getFaceArea
--         Editable_Mesh: meshOp.getFaceArea
--     )

--     for f = 1 to theCount do
--     (
--         local theArea = theAreaMethod theNode f
--         if theArea >= FaceAreaChecker.FaceAreaThresholdMin and theArea <= FaceAreaChecker.FaceAreaThresholdMax do append theResults f
--     )
-- 3
-- ),

-- fn supportedCheck theNode =
-- (
--     classof theNode == Editable_Mesh or classof theNode == Editable_Poly
-- ),

-- fn configDlg =
-- (
--     try(destroyDialog FaceAreaChecker.faceAreaDialog)catch()
--     rollout faceAreaDialog "Face Area Checker"
--     (
--         spinner spn_FaceAreaThresholdMin "Min. Threshold:" range:[0,1000000,FaceAreaChecker.FaceAreaThresholdMin] offset:[7,-3] type:#worldUnits
--         spinner spn_FaceAreaThresholdMax "Max. Threshold:" range:[0,1000000,FaceAreaChecker.FaceAreaThresholdMax] offset:[7,-3] type:#worldUnits

--         fn updateDisplay =
--         (
--             XViewChecker.runCheck CurrentTime
--             max views redraw
--         )
--         on spn_FaceAreaThresholdMin changed val do
--         (
--             FaceAreaChecker.FaceAreaThresholdMin = val
--             updateDisplay()
--         )
--         on spn_FaceAreaThresholdMax changed val do
--         (
--             FaceAreaChecker.FaceAreaThresholdMax = val
--             updateDisplay()
--         )
--     )--end rollout

--     createDialog faceAreaDialog
--     setDialogPos faceAreaDialog mouse.screenpos
--     FaceAreaChecker.faceAreaDialog = faceAreaDialog
-- )
-- )--end struct

-- try(destroyDialog FaceAreaChecker.faceAreaDialog)catch()
-- FaceAreaChecker = FaceAreaCheckerStruct()

-- XViewChecker.unRegisterChecker "Face Area Checker"
-- XViewChecker.registerChecker FaceAreaChecker.geomCheck FaceAreaChecker.supportedCheck #Faces "Face Area Checker" FaceAreaChecker.configDlg undefined undefined
-- )--end script

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
-- st = timestamp(); sh = heapfree
-- islands = meshop.thuyGetAllElements $ level:1
-- overVerts = meshop.thuyGetOVLVerts $
-- result = findOlVertsPerE $ overVerts islands
-- print islands
-- format "c++ \ntime:% ram:% faces:% elements:%\n%\n" (timestamp()-st) (sh-heapfree) $.numfaces islands.count elements
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















-- dotnet.loadAssembly "system.dll"

-- fn createServer ipAddress port = 
-- (
--     dotNetIPAddress = (DotNetClass "System.Net.IPAddress").Parse ipAddress
--     tcpListener = DotNetObject "System.Net.Sockets.TcpListener" dotNetIPAddress port
--     tcpListener.Start()
--     msgReceived = ""
--     print ("listening on " + (ipAddress as string) + ":" + (port as string))
--     while true do 
--     (
--         print("waiting for a client socket")
--         socket = tcpListener.AcceptSocket()
--         print("client socket accepted")
--         while msgReceived != "exit" do
--         (
--             sendByteStream = DotNetObject "System.Byte[]" 10000
--             socket.Receive sendByteStream
--             encoding = DotnetClass "System.Text.UTF8Encoding"
--             msgReceived = trimright (encoding.UTF8.GetString(sendByteStream))

--             if msgReceived == "socketClosing" then (
--                 print("closing socket")
--                 socket.Close()
--                 exit
--             )
--             else (
--                 if msgReceived != "" then (
--                     print("execute : " + msgReceived)
--                     -- execute msgReceived
--                     try(
--                         result = execute(msgReceived)
--                     ) catch (
--                         error_str = "***" + getCurrentException() +"***\n" 
--                         print(error_str)
--                     )
--                     -- send result
--                     ascii_encoder = dotNetObject "System.Text.ASCIIEncoding"
--                     bytes = ascii_encoder.GetBytes (result as string)
--                     result = socket.Send bytes
--                 )
--             )
--         )
--     )
-- )

-- fn BackgroundTcpListenerDoWork theSender theEvent =
-- (
--     ipAddress = "192.168.1.7"
--     port = 5431
--     try (
--         createServer ipAddress port
--         exit
--     )
--     catch(
--         print("server crashed or port " + (port as string) + " is already used")
--     )
-- )

-- BackgroundWorker = DotNetObject "System.ComponentModel.BackgroundWorker"
-- DotNet.AddEventHandler BackgroundWorker "DoWork" BackgroundTcpListenerDoWork
-- BackgroundWorker.WorkerSupportsCancellation = true
-- BackgroundWorker.RunWorkerAsync()


-- run this python in maya
-- import socket


-- def sendMessage(msg, socket):
--     socket.send(msg)
--     return s.recv(responseBufferSize)

-- ## connect to the server
-- responseBufferSize = 1024
-- s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
-- s.connect(('localhost', 7500))

-- ## send messages
-- #sendMessage('saveMaxFile "C:/test.max"', s)
-- sendMessage('sphere()', s)

-- ## close the socket from server and client side
-- sendMessage('socketClosing', s)
-- s.shutdown(socket.SHUT_RDWR)
-- s.close()

-- imageClass = dotNetClass "system.drawing.image"

-- path_ = @"E:\thuypainting\jpg\181368_384911108232685_338829425_n.jpg"
-- img = imageClass.fromFile path_

-- try(wf.close())catch()

-- tt = dotNetObject "toolTip"
-- fn sImg s e = (
--     pos = s.cursor.position
--     str = "
--        Show <System.String>text <System.Windows.Forms.IWin32Window>window
--       .Show <System.String>text <System.Windows.Forms.IWin32Window>window <System.Drawing.Point>point
--       .Show <System.String>text <System.Windows.Forms.IWin32Window>window <System.Int32>duration
--       .Show <System.String>text <System.Windows.Forms.IWin32Window>window <System.Int32>x <System.Int32>y
--       .Show <System.String>text <System.Windows.Forms.IWin32Window>window <System.Drawing.Point>point <System.Int32>duration
--       .Show <System.String>text <System.Windows.Forms.IWin32Window>window <System.Int32>x <System.Int32>y <System.Int32>duration
--       .<System.String>ToString()
--     "
--     tt.show str s.parent (pos.X-s.parent.location.X) (pos.Y-s.parent.location.Y)
-- )

-- fn hImg s e = (
--     tt.hide s.parent
-- )

-- wf = dotnetObject "form"
-- gv = dotNetObject "datagridView"
-- gv.dock = gv.dock.fill
-- -- showProperties gv

-- col = dotNetObject "datagridViewButtonColumn"
-- col.name = "thuy"
-- gv.columns.add col
-- gv.AutoSizeColumnsMode = gv.AutoSizeColumnsMode.fill

-- row = dotNetObject "DataGridViewRow"
-- gv.rows.add row
-- row.cells.item[0].value = "anhungxadieu"

-- tt.setTooltip gv "thuy"
-- showEvents gv

-- dotNet.addEventHandler gv "cellMouseDown" sImg
-- dotNet.addEventHandler gv "cellMouseUp" hImg

-- wf.controls.add gv
-- wf.show()













asm = dotNet.loadAssembly @"D:\Dropbox\anhungxadieu_3d\3dsmax\dotnet\WeifenLuo.WinFormsUI.Docking.dll"
asmO = dotNet.loadAssembly @"D:\Dropbox\anhungxadieu_3d\3dsmax\dotnet\ObjectListView\ObjectListView.dll"
-- for t in asm.GetExportedTypes() do print t.fullname
thuy = dotnetobject "WeifenLuo.WinFormsUI.Docking.DockPanel"




-- fn do_ s e = (
--     tv_ = (s.tag.value)
--     r = tv_.ClientRectangle
--     r.Inflate -100 -100
--     tv_.Bounds = tv_.RectangleToScreen(r)

--     tv_.ScrollControlIntoView(s)
-- )

-- w = dotnetobject "form"
-- tv = dotNetObject "System.Windows.Forms.TableLayoutPanel"

-- tv.layoutSettings.RowCount = 12
-- tv.layoutSettings.ColumnCount = 6
-- --tv.BorderStyle = (dotNetClass "System.Windows.Forms.BorderStyle").None
-- --tv.CellBorderStyle = (dotNetClass "System.Windows.Forms.TableLayoutPanelCellBorderStyle").Single
-- tv.dock = tv.dock.fill
-- tv.AutoSize = false
-- tv.AutoScroll  = true
-- tv.AutoSizeMode = tv.AutoSizeMode.GrowOnly

-- --tv.width = tv.layoutSettings.ColumnCount * 32
-- --tv.height = tv.layoutSettings.RowCount* 32

-- for i = 0 to tv.layoutSettings.RowCount - 1 do
-- for j = 0 to tv.layoutSettings.ColumnCount - 1 do
-- (
-- btn = (dotNetObject "System.Windows.Forms.Button")
-- btn.tag = (dotNetMXSValue tv)
-- dotNet.addEventHandler btn "click" do_
-- --dotShow
-- -- btn.Width = 25
-- -- btn.Height = 25
-- btn.Text = (i+j) as string
-- btn.dock = btn.dock.fill
-- tv.Controls.Add btn i j
-- )

-- for i=0 to tv.columncount do(
--     percent = 100.0 / tv.ColumnCount
--     tv.ColumnStyles.add(dotNetObject "ColumnStyle" (dotNetClass "sizeType").percent 50)
-- )

-- for i=0 to tv.rowcount do(
--     percent = 100.0 / tv.rowCount
--     tv.rowStyles.add(dotNetObject "rowStyle" (dotNetClass "sizeType").percent 50)
-- )

-- w.AutoScroll  = true
-- btn = (dotNetObject "System.Windows.Forms.Button")
-- btn.tag = dotNetMXSValue w
-- dotNet.addEventHandler btn "click" do_

-- olv = dotnetObject "BrightIdeasSoftware.TreeListView"
-- olv.dock = olv.dock.fill
-- olv.VirtualMode = false
-- olvC1 = dotNetObject "BrightIdeasSoftware.OLVColumn"
-- olvC2 = dotNetObject "BrightIdeasSoftware.OLVColumn"
-- olv.columns.add olvC1
-- olv.columns.add olvC2
-- olv.items.add "thuy" "10"

-- DockState = dotNetClass "WeifenLuo.WinFormsUI.Docking.DockState"
-- kuku = dotNetObject "WeifenLuo.WinFormsUI.Docking.DockContent"
-- kaka = dotNetObject "WeifenLuo.WinFormsUI.Docking.DockContent"
-- koko = dotNetObject "WeifenLuo.WinFormsUI.Docking.DockContent"
-- thuy.dock = thuy.dock.fill
-- kuku.text = "thuy"
-- koko.text = "ObjectListView"
-- kuku.controls.add tv
-- kaka.controls.add btn
-- koko.controls.add olv
-- kuku.show thuy DockState.DockLeft
-- kaka.show thuy DockState.DockRight

lv = dotnetobject "ListView"
lv.View = lv.View.Details
lv.columns.add "thuy"
lv.columns.add "kuku"
lv.columns.add "pb"
lv.dock = lv.dock.fill
for i=1 to 10 do(

    lvi = dotNetObject "ListViewItem"
    pb  = dotNetObject "ProgressBar"

    lvi.SubItems.item[0].Text = "name"
    lvi.SubItems.Add "daudadsu"
    lvi.SubItems.Add ""
    lvi.SubItems.Add "key"
    lv.Items.Add lvi

    r = lvi.SubItems.item[2].Bounds
    pb.SetBounds r.X r.Y r.Width r.Height
--     pb.SetBounds 0 0 200 20
    pb.Minimum = 1
    pb.Maximum = 10
    pb.Value = 5
    pb.Name = "key"
    lv.Controls.Add pb
)

w.IsMdiContainer = true
w.controls.add lv
-- koko.show thuy DockState.Document


w.show()

-- showProperties olv



-- theFrm = dotNetObject "MaxCustomControls.SceneExplorerControls.SceneExplorerDialog"
-- thePtr = DotNetObject "System.IntPtr" (windows.getMAXHWND())
-- theHwnd = (dotNetObject "System.Windows.Forms.NativeWindow").FromHandle thePtr
-- theFrm.Show(theHwnd)
-- /////////////////////////////////////////////////////////////////////////////////////
try(destroyDialog listview_)catch()
rollout listview_ "the list view" width: 300
(
    dotNetControl lv "system.windows.forms.listview" height: 200

    button testButton "test"
    on testButton pressed do
    (
        clearListener()
        format "Props\n"
        showProperties lv.items
        format "\nMethods\n"
        showMethods lv.items
    )
    fn initLv theLv=
    (
        --Setup the forms view
        theLv.view=(dotNetClass "system.windows.forms.view").details
        theLv.FullRowSelect=true
        theLv.GridLines=true
        theLv.MultiSelect=true
    )
    --Add columns.
    fn addColumns theLv columnsAr=
    (
        w=(theLv.width/columnsAr.count)-1
        for x in columnsAr do
        (
            theLv.columns.add x w
        )
    )
    fn populateList theLv=
    (
        rows=#()        --Empty array to collect rows of data
        for x in objects do     --Loop through all the objects in the scene.
        (
            li=dotNetObject "System.Windows.Forms.ListViewItem" x.name      --Create a listViewItem object and name it.
            li.subitems.add ((classOf x) as string)     --Add data to the second column.
            li.subitems.add (((x.wireColor) as point3) as string)       --Add data to the third column.

            append rows li      --Added the listViewItem to the rows array
        )
        theLv.items.addRange rows       --Add the array of rows to the listView control.
    )
    on lv mouseDown arg do
    (
        clearListener()
        showProperties arg
        hit=(lv.HitTest (dotNetObject "System.Drawing.Point" arg.x arg.y))
        showProperties hit
        showProperties hit.item
        print hit.item.text
        showProperties hit.item.subItems
        print hit.item.subItems.count
        print hit.item.subItems.item[1].text
    )
    on listview_ open do
    (
        initLv lv
        addColumns lv #("Object","Class","Wire Color")
        populateList lv
    )
)
-- /////////////////////////////////////////////////////////////////////////////////////
--Destroy dialog if it already exists.
try(destroyDialog treeView_)catch()
rollout treeView_ "The tree View" width:300
(
    --Create the dotNet treeView control
    dotNetControl tv "system.windows.forms.treeView" height:200

    --Create a button for testing.
    button testButton "Test"
    on testButton pressed do
    (
        clearListener()     --Clear the listener.
        format "Props\n"    --Format a header so we know what we are looking at below.
        showProperties tv   --Show the properties of the treeView control.
        format "\nMethods\n"    --Format a header so we know what we are looking at below.
        showMethods tv      --Show the properties of the treeView control.
        format "\nEvents\n" --Format a header so we know what we are looking at below.
        showEvents tv       --Show the properties of the treeView control.
    )
    --Adds root nodes to treeView.
    fn populateTreeView theTv=
    (
        --Loop through all the objects in the scene.
        for x in objects do
        (
            --Create a treeViewNode and add it to the treeView control
            theTv.nodes.add (dotNetObject "System.Windows.Forms.TreeNode" x.name)
        )
    )

    on treeView_ open do
    (
        populateTreeView tv
    )
)
-- /////////////////////////////////////////////////////////////////////////////////////
try(destroyDialog testR)catch()
rollout testR "Test"
(
    local Ccolor = dotnetclass "system.drawing.color"
    dotNetControl testButton "system.windows.forms.button" height:50

    on testR open do
    (
        testButton.flatStyle=testButton.flatStyle.flat
        testButton.text="Test Button"
        testButton.TextAlign= (dotNetClass "System.Drawing.ContentAlignment").BottomRight
        testButton.backColor=testButton.backColor.lightBlue

        testButton.flatappearance.mouseoverbackcolor = Ccolor.green
        testButton.flatappearance.mousedownbackcolor = Ccolor.red
        testButton.flatappearance.bordercolor = Ccolor.yellow
    )
)
-- createDialog testR
-- /////////////////////////////////////////////////////////////////////////////////////
Global mc2TestGalleryDilog

if mc2TestGalleryDilog != undefined do destroyDialog mc2TestGalleryDilog

rollout mc2TestGalleryDilog "3DsMax 9 Gallery II" width:556 height:597
(
    --> Local
    local jpg_images_dir = "E:\\thuy xsi\\Anhungxadieu\\anhungxadieu\\Pictures" --put a path with images here
    local colorclass = dotnetclass "system.drawing.color"
--  local cursor_harrow = dotNetObject "System.Windows.Forms.Cursor" "C:\WINDOWS\Cursors\aero_link_xl.cur"
--  local cursor_hmove = dotNetObject "System.Windows.Forms.Cursor" "C:\WINDOWS\Cursors\hmove.cur"
    local thumb_size = [100, 100]
    --< Local

    -->Interface
    dotNetControl flp "flowlayoutpanel" pos:[5,52] width:543 height:531
    --MaxWidth for forms Width, MaxHeight to = (unset)
    dotNetControl legend "textbox" pos:[5,4] width:543 height:20
    --<Interface

    -->functions
    fn showInfo itm =
    (
        print "---------------------------------------------------------------------------"
        format "Info:%\n" itm
        print "---------------------------------------------------------------------------"
        try (   format "show:%\n"        (show itm)         ) catch (print "undefined")
        try (   format "interface:%\n" (showinterface itm)  ) catch (print "undefined")
        try (   format "methods:%\n" (showmethods itm)  ) catch (print "undefined")
        try (   format "prop:%\n"        (showproperties itm)   ) catch (print "undefined")
    )
    fn resizeBitmapNET srcBitmap width height useHighQuality:false=
    --Resizes the specified NET bitmap // MarcoBrunetta
    (
        local destBitmap = (dotNetObject "System.Drawing.Bitmap" width height) --Create new bitmap object
        destBitmap.SetResolution srcBitmap.HorizontalResolution srcBitmap.VerticalResolution
        local theGraphics = (dotNetClass "System.Drawing.Graphics").fromImage destBitmap --Create new Graphics object
        local destRec = (dotnetObject "System.Drawing.rectangle" 0 0 width height) --Set destination image size
        IF useHighQuality DO theGraphics.InterpolationMode = theGraphics.InterpolationMode.HighQualityBicubic
        theGraphics.drawImage srcBitmap destRec --Resize the image
        theGraphics.dispose() --gc  --but images is stil locked. cant be deleted
        return destBitmap
    )
    fn onMouseDown ctrl evnt =
    (
        format "MouseDown: % [%]\n" ctrl (evnt.button.tostring())
        if ctrl.forecolor == colorclass.red
        then (ctrl.forecolor = colorclass.yellow; legend.text = ctrl.text + " Unselected")
        else (ctrl.forecolor = colorclass.red; legend.text = ctrl.text + " Selected")
        ctrl.Cursor = cursor_hmove
    )
    fn onMouseUp ctrl evnt =
    (
         ctrl.Cursor = cursor_harrow
         -- format "MouseUp: % [%]\n" ctrl (evnt.button.tostring())
    )
    fn onMouseEnter ctrl evnt =
    (
        --format "MouseEnter % [%]\n" ctrl evnt
        if ctrl.forecolor != colorclass.red do ctrl.forecolor = colorclass.yellow
        legend.text = "MouseEnter: " + ctrl.text
        ctrl.Cursor = cursor_harrow
    )
    fn onMouseLeave ctrl evnt = --drag and drop
    (
        --format "MouseLeave % [%]\n" ctrl evnt
        if ctrl.forecolor != colorclass.red do ctrl.forecolor = colorclass.ivory
        --legend.text = "MouseLeave: " + ctrl.text
    )
    fn onMouseMove ctrl evnt =
    (
        --format "Move!\n\tSender : %\n\tMouse Pos : %\n" ctrl.Text [evnt.X, evnt.Y]
    )
    --<functions

    -->Actions
    on mc2TestGalleryDilog open do
    (
        local singleborder = (dotNetClass "System.Windows.Forms.BorderStyle").fixedsingle
        local dnfont = dotNetObject "System.Drawing.Font" "Verdana" 6.5 ((dotNetClass "System.Drawing.FontStyle").bold)
        local dnfontlarge = dotNetObject "System.Drawing.Font" "Verdana" 8.5 ((dotNetClass "System.Drawing.FontStyle").bold)
        local dnMXSlarge = dotNetObject "System.Drawing.Font" "System" 8.5 ((dotNetClass "System.Drawing.FontStyle").bold)

        local dnobjarray = #()

        Images_Array = getFiles (jpg_images_dir + "\\*.jpg")

        for i in Images_Array do
        (
            btndragdrop = dotnetobject "button"
            btndragdrop.size = dotnetobject "system.drawing.size" thumb_size.x thumb_size.y --160 120
            --btndragdrop.backcolor = colorclass.yellow --cadetblue -- tag color
            btndragdrop.forecolor = colorclass.ivory --text color
            btndragdrop.margin =    dotnetobject "system.windows.forms.padding" 2 -- thumbs distance
            btndragdrop.flatstyle = (dotNetclass "System.Windows.Forms.FlatStyle").flat
            btndragdrop.font= dnfont
            btndragdrop.text = getFilenameFile i
            btndragdrop.textalign = (dotnetclass "System.Drawing.ContentAlignment").BottomCenter
            local img = dotNetObject "System.Drawing.Bitmap" i
            img = resizeBitmapNET img thumb_size.x thumb_size.y
            btndragdrop.Image = img
            btndragdrop.AllowDrop = true
            gc()
            -- Setup an event handlers for both buttons
            dotnet.addEventHandler btndragdrop "MouseDown" onMouseDown
            dotnet.addEventHandler btndragdrop "MouseUp" onMouseUp
            dotnet.addEventHandler btndragdrop "MouseEnter" onMouseEnter
            dotnet.addEventHandler btndragdrop "MouseLeave" onMouseLeave
            dotnet.addEventHandler btndragdrop "MouseMove" onMouseMove


            append dnobjarray btndragdrop
            btndragdrop = nothing
        )

        --> Title of gallery type
        colorlabel = dotnetobject "label"
        colorlabel.borderstyle = singleborder
        colorlabel.margin = dotnetobject "system.windows.forms.padding" 2
        colorlabel.backcolor = colorclass.cadetblue
        colorlabel.font= dnfontlarge
        colorlabel.text = "3D Models"
        colorlabel.size = dotnetobject "system.drawing.size" 516 24
        colorlabel.textalign =  (dotnetclass "System.Drawing.ContentAlignment").MiddleCenter
        --show colorlabel
        --< Title of gallery type

        flp.controls.add colorlabel
        flp.controls.addrange dnobjarray
        --flp.MaximumSize = [1000,1000]
        --flp.MinimumSize = [100,100]
        flp.AutoSize = true
        flp.autoscroll = true
        flp.padding = dotnetobject "system.windows.forms.padding" 2
        flp.BackColor = colorclass.fromARGB 40 45 66
        showinfo flp

    )
    on mc2TestGalleryDilog resized size do
    (
        flp.width = flp.width + (size.x - flp.width) - 13 --offset
        flp.height = flp.height + (size.y - flp.height) - 66 --offset
        --format "v:%\th:%\tsize:%\n" flp.width flp.height size
    )
    --<Actions

)-- end rollout
-- createDialog mc2TestGalleryDilog style:#(#style_titlebar,
--                                          #style_sysmenu,
--                                          #style_minimizebox,
--                                          #style_maximizebox,
--                                          #style_sunkenedge,
--                                          #style_resizing)
-- /////////////////////////////////////////////////////////////////////////////////////
-- bgImgPath = "D:\\Dropbox\\anhungxadieu_3d\\3dsmax\\maxscripts\\misc\\MouthThumbnails.jpg"
-- imageclass = dotNetclass "System.Drawing.image"
-- bgImg = imageclass.fromfile (bgImgPath)
-- globalSize = bgImg.height
try(destroydialog dlg) catch()
rollout dlg "uv animation"
(
    local malign = dotnetclass "System.Drawing.ContentAlignment"
    local Ccolor = dotnetclass "system.drawing.color"
    local cursor_harrow = dotNetObject "System.Windows.Forms.Cursor" "C:\\WINDOWS\\Cursors\\aero_link.cur"
    local font = dotNetObject "System.Drawing.Font" "Verdana" 6 ((dotNetClass "System.Drawing.FontStyle").bold)
    local fontLarge = dotNetObject "System.Drawing.Font" "Verdana" 8 ((dotNetClass "System.Drawing.FontStyle").bold)

    dotNetControl flp "flowlayoutpanel" pos:[0,0]

    fn dotnetImageResize image width height =
    (
        img = dotNetObject "System.Drawing.Bitmap" width height image.PixelFormat
        g = (dotnetclass "System.Drawing.Graphics").FromImage img

        g.SmoothingMode = g.SmoothingMode.HighQuality
        g.CompositingQuality = g.CompositingQuality.HighQuality
        g.InterpolationMode = g.InterpolationMode.HighQualityBicubic
        g.PixelOffsetMode = g.PixelOffsetMode.highQuality

        g.DrawImage image 0 0 width height
        return img
    )

    fn onMouseDown ctrl evnt =
    (
        ctrl.text = "thuy"
        ctrl.forecolor = Ccolor.green
        ctrl.font = fontLarge
        if ctrl.backcolor != Ccolor.red do ctrl.backcolor = Ccolor.red
    )

    fn onMouseEnter ctrl evnt =
    (
        ctrl.text = "thuy"
        ctrl.font = fontLarge
        ctrl.forecolor = Ccolor.red
        ctrl.TextAlign = malign.MiddleCenter
        ctrl.Cursor = cursor_harrow
        ctrl.FlatAppearance.BorderSize = 2
        ctrl.flatappearance.mouseoverbackcolor = Ccolor.transparent
    )

    fn onMouseLeave ctrl evnt = --drag and drop
    (
        ctrl.text = ""
        ctrl.forecolor = Ccolor.black
        ctrl.backcolor = Ccolor.transparent
        ctrl.TextAlign = malign.BottomCenter
        ctrl.FlatAppearance.BorderSize = 0
    )

    fn makeButtons =
    (
        result = #()
        size = globalSize/2
--      Images_Array = getFiles ("E:\\thuy xsi\\Anhungxadieu\\anhungxadieu\\Render_Pictures\\test\\rig" + "\\*.png")
    --  Images_Array = getFiles ("E:\\thuy_nuke\\asset\\BG\\HT_BG" + "\\*.png")

        for i=0 to 16 do
        (
            btn = dotnetobject "button"
            btn.size = dotnetobject "system.drawing.size" (size/4-6) (size/4-6) --160 120
    --      maxBackColor = colorMan.getColor #background
    --      DotNetBackColor = mColor.FromArgb (maxBackColor[1] * 255.0f) (maxBackColor[2] * 255.0f) (maxBackColor[3] * 255.0f)

    --      create image////////////////////////////
    --      imageclass = dotNetclass "System.Drawing.image"
            -- load bitmaps
    --      IListimage1 = imageclass.fromfile (i)
            --create an imagelist
    --      imglist = dotnetobject "System.Windows.Forms.ImageList"
    --      imglist.imagesize = dotnetobject "System.Drawing.Size" (btn.height-11) (btn.width-11)
            --add them to the image list
    --      imglist.images.add ilistimage1
    --      imglist.TransparentColor = Ccolor.white

    --      create button///////////////////////////
            btn.text = ""
            btn.TextAlign = malign.BottomCenter
            btn.font = font
--          btn.imagealign = malign.topcenter
    --      btn.ImageIndex = 0
    --      btn.ImageList = ImgList
            btn.flatStyle=btn.flatStyle.flat
            btn.FlatAppearance.BorderSize = 0
            btn.flatappearance.mousedownbackcolor = Ccolor.red
            btn.flatappearance.bordercolor = Ccolor.magenta
            btn.backcolor = Ccolor.Transparent

    --      Setup an event handlers for both buttons
            dotnet.addEventHandler btn "MouseDown" onMouseDown
    --      dotnet.addEventHandler btn "MouseUp" onMouseUp
            dotnet.addEventHandler btn "MouseEnter" onMouseEnter
            dotnet.addEventHandler btn "MouseLeave" onMouseLeave
    --      dotnet.addEventHandler btn "MouseMove" onMouseMove

    --      dotNet.addEventHandler btn "click" whenButtonClick
            dotNet.setLifetimeControl btn #dotnet
            append result btn
        )
        return result
    )

    on dlg open do
    (
        size = globalSize/2
        img = dotnetImageResize bgImg size size

        flp.BackgroundImage = img
        flp.size = dotnetobject "System.Drawing.Size" size size

        global buttons = makeButtons()

        flp.controls.addrange buttons
    )

    on dlg resized size do
    (
        factor = if ((if size.x < size.y then size.x else size.y)/globalSize) >= 1 then 1 else ((if size.x < size.y then size.x else size.y)/globalSize)
        if factor != 0.0 then
        (
            img = dotnetImageResize bgImg (globalSize * factor) (globalSize * factor)

            flp.BackgroundImage = img
            flp.Size = dotnetobject "System.Drawing.Size" img.height img.width
            for i in buttons do
            (
                i.size = dotnetobject "system.drawing.size" (img.width/4-6) (img.height/4-6)
            )
        )
        else
        (
            print "Minimize!"
        )
    )
 )
--  createdialog dlg (globalSize/2) (globalSize/2) style:#  (
--                                                  #style_titlebar,
--                                                  #style_sysmenu,
--                                                  #style_minimizebox,
--                                                  #style_maximizebox,
--                                                  #style_sunkenedge,
--                                                  #style_resizing
--                                                  )

--  rollout DotNetTest ".Net UI on MXS Form"
--  (

--      dotnetcontrol mbutton "System.Windows.Forms.Button" height:60 width:80 pos:[5,5]
--      dotnetcontrol mbutton2 "System.Windows.Forms.Button" height:60 width:80 pos:[88,5]

--      on dotnettest open do
--      (
--      mcolor = dotnetclass "System.drawing.color"
--      malign = dotnetclass "System.Drawing.ContentAlignment"

--      maxBackColor = colorMan.getColor #background
--      DotNetBackColor = mColor.FromArgb (maxBackColor[1] * 255.0f) (maxBackColor[2] * 255.0f) (maxBackColor[3] * 255.0f)

--      imageclass = dotNetclass "System.Drawing.image"
--      -- load bitmaps
--      IListimage1 = imageclass.fromfile (LRUIdir+"zfstart.bmp")
--      IListimage2 = imageclass.fromfile (LRUIdir+"zfstop.bmp")
--      --create an imagelist
--      imglist = dotnetobject "System.Windows.Forms.ImageList"
--      imglist.imagesize = dotnetobject "System.Drawing.Size" 64 35
--      --add them to the image list
--      imglist.images.add ilistimage1
--      imglist.images.add ilistimage2
--      imglist.TransparentColor = mcolor.white

--      mbutton.text = "Add Start"
--      mbutton.flatstyle = dotnetobject "System.Windows.Forms.FlatStyle" Flat
--      mButton.TextAlign = malign.BottomCenter
--      mbutton.imagealign = malign.topcenter
--      mbutton.FlatAppearance.MouseOverBackColor = mcolor.limegreen
--      mbutton.backcolor = DotNetBackColor

--      mButton2.text = "Add Stop"
--      mbutton2.flatstyle = dotnetobject "System.Windows.Forms.FlatStyle" Flat
--      mbutton2.imagealign = malign.topcenter
--      mButton2.TextAlign = malign.bottomCenter
--      mbutton2.FlatAppearance.MouseOverBackColor = mcolor.coral
--      mbutton2.backcolor = DotNetBackColor

--      mbutton.ImageIndex = 0
--      mbutton.ImageList = ImgList
--      mbutton2.imageindex = 1
--      mbutton2.ImageList = ImgList
--      )

--      on mbutton click do
--      (
--      print "start pressed"
--      )

--      on mbutton2 click do
--      (
--      print "stop pressed"
--      )

--  )
--  createdialog dotnettest 175 80 style:#(#style_toolwindow, #style_sysmenu)


-- rollout pngtest "" width:155 height:232
-- (
--  local uiColor = ((dotnetclass "managedservices.CUIupdater").getinstance()).getcontrolcolor()

--  dotnetcontrol btn1 "button" pos:[7,5] width:68 height:71
--  dotnetcontrol btn2 "button" pos:[80,5] width:68 height:71
--  dotnetcontrol btn3 "button" pos:[7,80] width:68 height:71
--  dotnetcontrol btn4 "button" pos:[80,80] width:68 height:71
--  dotnetcontrol btn5 "button" pos:[7,155] width:68 height:71
--  dotnetcontrol btn6 "button" pos:[80,155] width:68 height:71

--  on pngtest open do
--  (
--      icondir = pathconfig.appendpath (getdir #maxroot) @"UI_ln\Resources\Light\Icons\Modeling"
--      icons = getfiles ( icondir + @"\\*.png")

--          for i = 1 to 6 do
--          (
--              btn = pngtest.controls[i]
--              btn.flatstyle = btn.flatstyle.flat
--              btn.FlatAppearance.BorderSize = 0
--              btn.backcolor = uiColor
--              btn.image = (dotnetclass "system.drawing.image").fromFile icons[i]
--          )
--  )
-- )
-- createdialog pngtest



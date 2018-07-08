macroScript thuy_automate_render_as_filename category: "thuyMaxTools" buttonText: "thuy_automate_render_as_filename " 
Icon:#(" thuy_automate_render_as_filename",1)
(
-- fn purifiedDate =
--   (
--   	local theStringArray = FilterString localTime "\\:/ "
--   	local theString = ""
--   	for i = 1 to theStringArray.count-1 do theString += theStringArray[i] + "_"
--   	theString += theStringArray[theStringArray.count]	
--   )
-- timecurrent = purifiedDate()

calendar = getLocalTime()
year = calendar[1] as string
month = calendar[2]
day = calendar[4] 
month = formattedPrint month format:"02u"
day = formattedPrint day format:"02u"

-- Path variable
desktop = "C:\Users\Dell Precision T5500\Desktop"
maxScenes = getdir#scene as string

global timeSaveDayOnly =  year + "_" + month + "_" + day
global scene_= maxFilePath + maxFileName
global scenePath = getFilenamePath scene_
global sceneName = getFilenameFile scene_
global renderOutputDef  = getdir #renderoutput

rollout auto_makedir_ "Thuy_automate_filename_out" width:170 height:180
(
	GroupBox default_path "default_path" pos:[5,5] width:160 height:40
	groupBox scene_name_path "scene_name" pos:[5,45] width:160 height:40
	groupBox image_name_path "image_name" pos:[5,85] width:160 height:40
	
	edittext out_folder text: maxScenes pos:[10,22.5] width:150 height:18
	edittext scene_name text: sceneName pos:[10,62.5] width:150 height:18
	edittext image_name text: sceneName pos:[10,102.5] width:150 height:18
	
	button make_dir "make_dir" pos:[5,130] width:60 height:20
	button set_imageOut "set_imageOut" pos:[70,130] width:80 height:20
	button explorer "explorer" pos:[95,153] width:55 height:20
	
	checkbox default_dir "default_dir" pos:[5,155] width:80 height:15 across:2
	
	fn make_directory =
	(
			if default_dir.state == true then
				(
					global outputPath = renderOutputDef + "\\" + scene_name.text as string +"\\"+ timeSaveDayOnly
				)
			else
				(
					global outputPath = out_folder.text as string + "\\" + scene_name.text as string  + "\\" + timeSaveDayOnly
				)
			outputpath
	)
	
	on make_dir pressed do
	(
		makedir (make_directory())
	)
	on set_imageOut pressed do
	(
		rendSaveFile = true
		rendOutputFilename = (make_directory()) + "/" + image_name.text as string  + ".exr"
		print rendOutputFilename
	)
	on explorer pressed do
	(
		shellLaunch "explorer.exe" (make_directory())
	)
)
createDialog auto_makedir_
)
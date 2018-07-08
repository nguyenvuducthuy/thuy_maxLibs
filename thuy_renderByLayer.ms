fileIn "\\\\WIN-OTUOK3LQL52\\Users\\Administrator\\Documents\\3dsMax\\script\\thuy_workWithRender.ms"
fileIn "\\\\WIN-OTUOK3LQL52\\Users\\Administrator\\Documents\\3dsMax\\script\\thuy_maxUtils.ms"
-- //////////////////////////////////
-- CHANGE HERE///////////////////////
-- //////////////////////////////////
-- 	submit to backburner >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

_managerName = "WIN-OTUOK3LQL52"
framerange = #(
				#("921-1640"),
				#("601-920"),
				#("1-600"))

cam = #("camera3_921-1640",
		"camera2_601-920",
		"camera1_1-600")

layers = #(
			#("bg1 va 3","camera3_921-1640"),
			#("bg 2 ","camera2_601-920"),
			#("bg1 va 3","camera1_1-600"))

for i = 1 to cam.count do(
	thuy_showLayerInList renderLayers: layers[i]
	submitToBackBurner _managerName framerange[i] cam[i]
)

-- >>>>>>>>>>>>>>
-- test//////////
-- ==============
-- thuy_showLayerInList renderLayers:#("bg1 va 3","camera1_1-600")
-- ==============
-- >>>>>>>>>>>>>>
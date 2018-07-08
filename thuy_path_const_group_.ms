thuy_add_percent = $Point001.modifiers[#Attribute_Holder].anhungxadieu_tool.add_percent
print (thuy_add_percent)


for i = 1 to selection.count do
(
	obj = selection[i].modifiers[1].anhungxadieu_tool --get custom attribute
	obj.index = i
	thePath=$path_ -- add path first selection
	print (ThePath)
	PosCont=selection[i].pos.controller 
	PosCont.Available.controller=path follow:true 
	PosCont.setname 3 "thuy_path"
	PosCont.setactive 3
	PosCont.thuy_path.path=thePath
	PosCont.thuy_path.controller.PERCENT = obj.index *10 + thuy_add_percent

-- 	PosCont.thuy_path.controller.percent.controller = Float_Expression () -- add float expression to percent
)

-- for i in selection do
-- (
-- 	thePath=$path_ -- create shape node for path
-- 	PosCont=i.pos.controller 
-- 	PosCont.Available.controller=path follow:true 
-- 	PosCont.setname 3 "thuy_path"
-- 	PosCont.setactive 3
-- 	PosCont.thuy_path.path=thePath
-- 	PosCont.thuy_path.controller.percent.controller = Float_Expression ()
-- )

-- delete modifier in seleted obj
-- deleteModifier $ 1 
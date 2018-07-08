for m = 1 to 3 do meditmaterials[m] = vraymtl diffuse:(#(red,green,blue)[m]) name:(#("wood_","glass_","metal_")[m])
for o in geometry do
	(
		objName = (filterstring o.name "_")
-- 		print objName[1]
		for m in meditmaterials where  matchPattern m.name pattern: (m.name + "*") do
		(
			o.material = meditmaterials[objName[1] as string + "_"]
		)
	)
	
-- (
-- for i = 1 to 10 do box() --create 10 boxes
--   for i = 1 to 10 do sphere() --create 10 spheres
--   theType = "Box" --define the type to compare the name to
--   for o in objects do 
--     if matchPattern o.name pattern:(theType + "*") then 
--   	o.material = meditmaterials[1]
--     else
--   	format "-The Object % is NOT of type %\n" o.name theType
-- )

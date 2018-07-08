caDef = attributes anhungxadieu_tool

(
	-- UI Parameters
	parameters AnhungxadieuTools rollout: myrollout
	(
		index type:#float UI:index
	)
	-- Attribute Rollout
	rollout myrollout "anhungxadieu_Tool" width:162 height:78
	(
		spinner index "index"

		on index changed val do
		(
			-- Create Empty Array
			gotem = #()
			for j in objects do
			(
				if(getUserprop j "thuy") == true then append gotem j
			)
		)
	)

)

for o in selection do
(
	myMod = addModifier o (EmptyModifier ())
	custAttributes.add o.modifiers[1] caDef
)



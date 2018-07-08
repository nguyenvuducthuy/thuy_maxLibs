-- Create Empty Array

gotem = #()
for j in objects do
(
	if(getUserprop j "thuy") == true then
	append gotem j
)
-- Select Tagged Object Do Something
	
for j in gotem do
    (
		j.segs = 9
	)
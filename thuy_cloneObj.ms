--clone the selected objects
instance $thuy_001

--Loop through the array of object it returns
for i = 1 to nnl.count do
(
    --rename the objects to a unique name
    nnl[i].name = uniqueName "thuy_" numDigits:3
)

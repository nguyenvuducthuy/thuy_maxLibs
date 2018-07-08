/*
XML Reading Tutorial
*/

--Load the xml assemply
dotNet.loadAssembly "system.xml"
--Create an xml document object.
xmlDoc=dotNetObject "system.xml.xmlDocument"

--Open the file in Max to see the file.
xmlPath="C:\\Users\\anhungxadieu\\Desktop\\test.xml"
-- edit xmlPath

fn formatProps ele=
(
	clearListener()

	format "Props:\n"
	showProperties ele

	format "Methods\n"
	showMethods ele
)

fn recurseXml ele parent:undefined=
(
	--Loop through all the children
	for i = 1 to ele.childNodes.count-1 do
	(
		--Get the attribute value called class
		for o = 0 to ele.ChildNodes.itemOf[i].ChildNodes.count-1 do
		(
			objClassStr=ele.ChildNodes.itemOf[i].ChildNodes.itemOf[o].GetAttribute "classOf"
			--Get the attribute value called name
			objNameStr=ele.ChildNodes.itemOf[i].ChildNodes.itemOf[o].GetAttribute "Name"

	-- 		print (objClassStr.GetAttribute "classOf")
			--Check if the class value can be turned into a max class object and is creatable.
			objClass=(execute objClassStr)
			if objClass!=undefined then
			(
				--Create the object
				n=objClass()
				--Name the object
				n.name=objNameStr
				--Set the parent of the object if there is one.
				n.parent=parent
			)
	-- 		recurse the xml tree
	-- 		recurseXml ele.ChildNodes.itemOf[i] parent:n
		)
	)
)

--If the file exists then load it.
if doesFileExist xmlPath then
(
-- 	Load the XML file.
	xmlDoc.load xmlPath
	--Check to make sure the xmlDoc has a root element.
	docEle=xmlDoc.documentElement

	--If the root element exists continue.
	if docEle!=undefined and docEle.name=="root" then
	(
		--Recurse the XML tree.
		recurseXml docEle
	)
)



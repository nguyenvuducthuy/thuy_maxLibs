/*
Doesn't support Ca defs, material trees, key tangent types, mesh generation and much more.
*/

dotnet.loadAssembly "system.xml.dll"
xml=dotNetObject "system.xml.xmlDocument"
-- showProperties root
-- showMethods root
root=xml.CreateElement "root"
xml.AppendChild root
root.SetAttribute "release" ((maxversion())[1] as string)
root.SetAttribute "API" ((maxversion())[2] as string)
root.SetAttribute "SDK" ((maxversion())[3] as string)

sceneDescription=xml.CreateElement "sceneDescription"
root.AppendChild sceneDescription

objectDescription=xml.CreateElement "objectDescription"
root.AppendChild objectDescription

clearListener()

fn formatKeys keys root=
(
	for k in keys do
	(
		node=xml.CreateElement "key"
		node.SetAttribute "time" (k.time as string)
		node.SetAttribute "value" (k.value as string)

		root.AppendChild node
	)
)

fn recurseNumSubs sub root=
(
 	node=xml.CreateElement "subAnim"
 	node.SetAttribute "name" sub.name
 	node.SetAttribute "classOf" ((classOf sub) as string)
   	node.SetAttribute "superClassOf" ((superClassOf sub) as string)
	node.SetAttribute "value" (sub.value as string)
  	node.SetAttribute "index" (sub.index as string)
  	node.SetAttribute "isAnimated" (sub.controller.isAnimated as string)
  	node.SetAttribute "controller" (sub.controller as string)

	if sub.controller!=undefined and sub.controller.keyable then
	(
		formatKeys sub.controller.keys node
	)

	root.AppendChild node
	for i = 1 to sub.numsubs do
	(
		recurseNumSubs sub[i] node
	)
)

fn formatModifiers mod root=
(
	node=xml.CreateElement "Modifier"
	node.SetAttribute "name" mod.name
	node.SetAttribute "classOf" ((classOf mod) as string)
	node.SetAttribute "superClassOf" ((superClassOf mod) as string)
	root.AppendChild node
)

fn sceneToXml obj root=
(
	node=xml.CreateElement "Object"
	node.SetAttribute "Name" obj.name
	node.SetAttribute "wireColor" (obj.wireColor as string)
	node.SetAttribute "transform" (obj.transform as string)
	node.SetAttribute "classOf" ((classOf obj.baseObject) as string)
	node.SetAttribute "superClassOf" ((superClassOf obj.baseObject) as string)
	node.SetAttribute "material" ((obj.material) as string)

	for mod in obj.modifiers do
	(
		formatModifiers mod node
	)

	for i = 1 to obj.numsubs do
	(
 		recurseNumSubs obj[i] node
	)

	root.AppendChild node
	for x in obj.children do
	(
		sceneToXml x node
	)

)

for x in objects do
(
	if x.parent==undefined then
	(
		sceneToXml x objectDescription
	)
)
xml.save "C:\\Users\\anhungxadieu\\Desktop\\test.xml"
edit  "C:\\Users\\anhungxadieu\\Desktop\\test.xml"
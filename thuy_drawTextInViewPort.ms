unRegisterRedrawViewsCallback showObjectNames
fn showObjectNames=
(
gw.setTransform(Matrix3 1)
for o in objects where not o.isHidden and (getUserProp o "thuy" != undefine) do
(
gw.text (o.pos+[0,0,0])(o.name) color:green
-- gw.text (o.pos+[0,0,20])(getUserPropBuffer o) color:yellow
) 
gw.enlargeUpdateRect #whole
gw.updateScreen()
)
registerRedrawViewsCallback showObjectNames
showObjectNames()
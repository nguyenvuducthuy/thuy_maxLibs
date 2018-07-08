for i = 2 to (selection.count) where  (selection[1].wirecolor == selection[i].wirecolor) and (selection[i].ishidden == false) do
(
	polyop.attach selection[1] selection[i]
)
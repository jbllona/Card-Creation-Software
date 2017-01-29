import xml.etree.ElementTree as ET

def getDescription(name):

	def cut(toCut, start, end):
		return toCut[:start]+toCut[end:]


	tree = ET.parse("srd_spells.xml")
	root = tree.getroot()
	item = root.findall(name)

	if len(item) > 0:
		description = item.pop(0)
		description = description.get("description")
	else:
		return "No Description"
	description = description.replace("{br}", "@mynl@")
	while '{' in description and '}' in description:
		description = cut(description, description.find('{'), description.find('}')+1)
	return description

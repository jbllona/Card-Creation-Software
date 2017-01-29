# the important data:
# School, name, casting time, range, components, duration, target, saving throw,
# spell resistance, level, description
import urllib2

def findLevel(block):
	return block[block.index('>')+1:block.find('</')]

def findData(url):
	# info order:
	# level, components
	response = urllib2.urlopen(url)
	html = response.read()

	# FIND LEVEL
	importantBlock = html[html.find("statBlock"):html.find("</p>")]
	importantBlock = importantBlock[importantBlock.find("<td>")+4:]
	info = findLevel(importantBlock)
	while importantBlock[importantBlock.find("</a>")+4:importantBlock.find("</a>")+5] == ',':
		importantBlock = importantBlock[importantBlock.find("</a>")+5:]
		info = info + " " + findLevel(importantBlock)

	# FIND COMPONENTS
	importantBlock = importantBlock[importantBlock.find("<td>")+4:]
	info = info + "\t\t\t\t" + importantBlock[:importantBlock.find("</td>")]
	return info



# "main method"
input = open("spellIndex.html", 'r')
output = open("spellInfo.txt", 'w')
# print findData("http://www.d20srd.org/srd/spells/acidArrow.htm")

lineNum = 0
for line in input:
	lineNum += 1
	print lineNum
	commaLocation = line.index(',')
	url = line[:commaLocation]
	spellName = line[commaLocation+1:len(line)-1]
	output.write(spellName+"\t\t\t\t"+findData(url)+'\n')
	# output.write(findData(url)+'\n')

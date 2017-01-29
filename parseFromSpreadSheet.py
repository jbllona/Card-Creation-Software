# the important data:
# School, name, casting time, range, components, duration, target, saving throw, spell resistance, level, description,    print
#   g       g        g          g        g          g        g           g               g           g    get from web   t|(f|nothing)
import urllib2
from processXML import getDescription
input = open("spells.tsv", 'r')
output = open("tabbedSpells.tsv", 'w')

i = 0
input.readline()
output.write("School\tName\tCasting Time\tRange\tComponents\tDuration\tTarget\tSaving Throw\t Spell Resistance\tLevel\tDescription\tPrint?\n")
for line in input:
	
	line = line[line.index('\t')+1:]
	line = line[line.index('\t')+1:]


	name = line[:line.index('\t')]
	line = line[line.index('\t')+1:]

	school = line[:line.index('\t')]
	line = line[line.index('\t')+1:]

	line = line[line.index('\t')+1:]    # skip sub
	line = line[line.index('\t')+1:]    # skip descriptor

	components = line[:line.index('\t')]
	line = line[line.index('\t')+1:]

	castingTime = line[:line.index('\t')]
	line = line[line.index('\t')+1:]

	range = line[:line.index('\t')]
	line = line[line.index('\t')+1:]

	target = line[:line.index('\t')]
	line = line[line.index('\t')+1:]

	duration = line[:line.index('\t')]
	line = line[line.index('\t')+1:]

	save = line[:line.index('\t')].replace("-", "---")
	line = line[line.index('\t')+1:]

	spellResistance = line[:line.index('\t')].replace("y", "Yes")
	spellResistance = spellResistance.replace("n", "NO")
	line = line[line.index('\t')+1:]

	altDescription = line[:line.index('\t')]
	line = line[line.index('\t')+1:]
	line = line[line.index('\t')+1:] # skip book
	line = line[line.index('\t')+1:] # skip pg

	B = line[:line.index('\t')+1].rstrip()
	line = line[line.index('\t')+1:]

	C = line[:line.index('\t')+1].rstrip()
	line = line[line.index('\t')+1:]

	D = line[:line.index('\t')+1].rstrip()
	line = line[line.index('\t')+1:]

	P = line[:line.index('\t')+1].rstrip()
	line = line[line.index('\t')+1:]

	line = line[line.index('\t')+1:] # skip R
	W = line#[:line.index('\t')+1]
	W = W.strip()
	# line = line[line.index('\t')+1:]

	level = ""

	if len(B) >= 1:
	    level = level + "Brd " + B
	if len(C) >= 1:
	    level = level + " Clr " + C
	if len(D) >= 1:
	    level = level + " Drd " + D
	if len(P) >= 1:
	    level = level + " Pal " + P
	if len(W) >= 1:
	    level = level + " Sor/Wiz " + W
	nameToSearch = name.replace("'", "&apos;")
	description = getDescription(".//thing[@name='"+nameToSearch+"']")
	if description == "No Description":
		doPrint = "flase"
	else:
		doPrint = "true"


	# expand abbreviations
	castingTime = castingTime.replace("std"," Standard action")
	castingTime = castingTime.replace("rds", " Rounds")
	castingTime = castingTime.replace("rd", " Round")
	duration = duration.replace("rds", " Rounds")
	duration = duration.replace("rd", " Round")
	spellResistance = spellResistance.replace("Yes (h/l)", "Yes, Harmless")
	save = save.replace("neg", "negates")
	target = target.replace("obj", "objects")
	save = save.replace("obj", "objects")
	spellResistance = spellResistance.replace("obj", "objects")
	duration = duration.replace("perm", "permanent")
	spellResistance = spellResistance.replace("(h/l)", "Harmless")
	save = save.replace("ref", "Reflex")
	save = save.replace("Fort", "Fortitude")
	range = range.replace("med", "Medium (100 ft. + 10 ft./level)")
	range = range.replace("close", "Close (25 ft. + 5 ft./2 levels)")
	range = range.replace("long", "Long (400 ft. + 40 ft./level)")
	
	if len(target) > 117:
		description += "@mynl@@mynl@" + "Target:@mynl@" + target
		altDescription += "@mynl@@mynl@" + "Target:@mynl@" + target
		target = "See Description"
	newLine = school+'\t'+name+'\t'+castingTime+'\t'+range+'\t'+components+'\t'+duration+'\t'+target+'\t'+save+'\t'+spellResistance+'\t'+level+'\t'+description+'\t'+doPrint+'\t'+altDescription+'\n'
	if doPrint == "true":
		output.write(newLine)
		i += 1
		print i

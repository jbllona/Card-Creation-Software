PImage img;
PImage background;
PFont kq;
Table table;
int lengthErrorCount = 0;
Card[] cards;
ArrayList<String> schools = new ArrayList<String>();
Coords[] cardLoc;

int[] backOrder = {2, 1, 0, 5, 4, 3, 8, 7, 6};

//TODO: load these from a file
int col1 = 175;
int col2 = 500;
int row1 = 230;
int row2 = 300;
int row3 = 370;
int row4 = 440;
int wrapWidth = 300;
int wrapHeight = 55;

void settings()
{
  background = loadImage("../Printout Template All Front.png"); // so size can be set. will be removed when adding multiple to one page
  size(background.width, background.height);
}

void setup() 
{
  image(background, 0, 0);
  cardLoc = new Coords[9];
  for(int i = 0; i < cardLoc.length; i++) cardLoc[i] = new Coords();
  cardLoc[0].x = 100;
  cardLoc[0].y = 25;
  cardLoc[1].x = 937;
  cardLoc[1].y = 25;
  cardLoc[2].x = 1775;
  cardLoc[2].y = 25;
  cardLoc[3].x = 100;
  cardLoc[3].y = 1125;
  cardLoc[4].x = 937;
  cardLoc[4].y = 1125;
  cardLoc[5].x = 1775;
  cardLoc[5].y = 1125;
  cardLoc[6].x = 100;
  cardLoc[6].y = 2225;
  cardLoc[7].x = 937;
  cardLoc[7].y = 2225;
  cardLoc[8].x = 1775;
  cardLoc[8].y = 2225;
  table = loadTable("../tabbedSpells.tsv", "header");
  cards = new Card[table.getRowCount()];
  for(int i = 0; i < table.getRowCount(); i++)
  //for(int i = 0; i < 18; i++)
  {
    if(table.getRow(i).getString(11).equals("true"));
      cards[i] = new Card(table.getRow(i));
  //cards[i].display();
  }
  for(int j = 0; j < table.getRowCount()/9; j++)
  //for(int j = 0; j < 2; j++)
  {
    for(int i = 0; i < 9; i++)
    {
    println(i + j * 9);
    cards[i + j * 9].display(cardLoc[i].x, cardLoc[i].y);
    }
    save("output/sheet"+(j+1)+".png");
    for(int i = 0; i < 9; i++)
    {
      addBack(schools.remove(0), backOrder[i]);
    }
    save("output/back"+(j+1)+".png");
  }
  
  println("done");
  exit();
}
 
void addBack(String school, int loc)
{
  int x = cardLoc[loc].x;
  int y = cardLoc[loc].y;
    if(school.equals("abj")) // Abjuration
    {
      img = loadImage("../cardBacks/BackAbjuration.png"); // so size can be set. will be removed
    }
    if(school.equals("con")) // Conjuration
    {
      img = loadImage("../cardBacks/BackConjuration.png"); // so size can be set. will be removed
    }
    if(school.equals("div")) // Divination
    {
      img = loadImage("../cardBacks/BackDivination.png"); // so size can be set. will be removed
    }
    if(school.equals("ench")) // Enchantment
    {
      img = loadImage("../cardBacks/BackEnchantment.png"); // so size can be set. will be removed
    }
    if(school.equals("evo")) // Evocation
    {
      img = loadImage("../cardBacks/BackEvocation.png"); // so size can be set. will be removed
    }
    if(school.equals("ill")) // Illusion
    {
      img = loadImage("../cardBacks/BackIllusion.png"); // so size can be set. will be removed
    }
    if(school.equals("nec")) // Necromancy
    {
      img = loadImage("../cardBacks/BackNecromancy.png"); // so size can be set. will be removed
    }
    if(school.equals("tran")) // Transmutation
    {
      img = loadImage("../cardBacks/BackTransmutation.png"); // so size can be set. will be removed
    }
    if(school.equals("uni")) // Universal
    {
      img = loadImage("../cardBacks/BackUniversal.png"); // so size can be set. will be removed
    }
    if(school.equals("extendedBack"))
    {
      img = loadImage("../cardBacks/BackExtendedDesc.png"); 
    }
    image(img, x, y); //coordinates will change once adding more than one card to a page
  }

class Card
{
  String school, name, castingTime, range, components, duration, target, savingThrow, spellResistance, level, description;
  boolean print; 
  Card(TableRow line)
  {
    // 30 max characters possible for name
    // 117 max characters possible for castingTime through level
    // 2318 max characters possible for description
    school            = line.getString(0);
    name              = line.getString(1);
    castingTime       = line.getString(2);
    range             = line.getString(3);
    components        = line.getString(4);
    duration          = line.getString(5);
    target            = line.getString(6);
    savingThrow       = line.getString(7);
    spellResistance   = line.getString(8);
    level             = line.getString(9);
    description       = line.getString(10);
    if(description.length() <= 2000)
    {
      schools.add(new String(school));
    }
    else
    {
      schools.add(new String("extendedBack"));
      description = line.getString(12) + "\n\n"+ "See foldout";
    }
    description = description.replaceAll("@mynl@","\n");
    if(castingTime.length() > 117)     println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Casting Time");
    if(range.length() > 117)           println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + " Range");
    if(components.length() > 117)      println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Components");
    if(duration.length() > 117)        println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Duration");
    if(target.length() > 117)          println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Target");
    if(savingThrow.length() > 117)     println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Saving Throw");
    if(spellResistance.length() > 117) println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Spell Resistance");
    if(level.length() > 117)           println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Level");
    if(description.length() > 2000)    println("LENGTH ERROR " + ++lengthErrorCount + ": " + name + ", Alt Description");
  }
  void pickSchool(String school, int x, int y)
  {
    if(school.equals("abj")) // Abjuration
    {
      img = loadImage("../abjurationFront.png"); // so size can be set. will be removed
    }
    if(school.equals("con")) // Conjuration
    {
      img = loadImage("../conjurationFront.png"); // so size can be set. will be removed
    }
    if(school.equals("div")) // Divination
    {
      img = loadImage("../divinationFront.png"); // so size can be set. will be removed
    }
    if(school.equals("ench")) // Enchantment
    {
      img = loadImage("../enchantmentFront.png"); // so size can be set. will be removed
    }
    if(school.equals("evo")) // Evocation
    {
      img = loadImage("../evocationFront.png"); // so size can be set. will be removed
    }
    if(school.equals("ill")) // Illusion
    {
      img = loadImage("../illusionFront.png"); // so size can be set. will be removed
    }
        if(school.equals("nec")) // Necromancy
    {
      img = loadImage("../necromancyFront.png"); // so size can be set. will be removed
    }
    if(school.equals("tran")) // Transmutation
    {
      img = loadImage("../transmutationFront.png"); // so size can be set. will be removed
    }
    if(school.equals("uni")) // Universal
    {
      img = loadImage("../universalFront.png"); // so size can be set. will be removed
    }
    image(img, x, y); //coordinates will change once adding more than one card to a page
  }

  void display(int x, int y)
  {
    pickSchool(school, x, y);
    rectMode(CENTER);
    //if(name.length() > 30) kq = createFont("KnightsQuest.ttf", 30);
    if(name.length() > 17) kq = createFont("KnightsQuest.ttf", 60);
    else kq = createFont("KnightsQuest.ttf", 65);
    textFont(kq);
    textLeading(50);
    fill(0);
    textAlign(CENTER);

    // name
    int trimGreater = name.indexOf(", Greater");
    int trimLesser = name.indexOf(", Lesser");
    int trimMass = name.indexOf(", Mass");
    if(trimGreater >= 0)
    {
      text(name.substring(0, trimGreater), img.width/2+x, 130+y);
      kq = createFont("KnightsQuest.ttf", 65/3);
      textFont(kq);
      text("(Greater)", img.width/2+x, 160+y);
    }
    else if(trimLesser >= 0)
    {
      text(name.substring(0, trimLesser), img.width/2+x, 130+y);
      kq = createFont("KnightsQuest.ttf", 65/3);
      textFont(kq);
      text("(Lesser)", img.width/2+x, 160+y);
    }
    else if(trimMass >= 0)
    {
      text(name.substring(0, trimMass), img.width/2+x, 130+y);
      kq = createFont("KnightsQuest.ttf", 65/3);
      textFont(kq);
      text("(Mass)", img.width/2+x, 160+y);
    }
    else if(name.length() >= 25) text(name, img.width/2+x, 180+y, 500, 225);
    else text(name, img.width/2+x, 140+y);
    kq = createFont("KnightsQuest.ttf", 20);
    textFont(kq);
    textLeading(15);
    // casting time
    text(castingTime, col1+x, row1+y, wrapWidth, wrapHeight);
    //range
    text(range, col2+x, row1+y, wrapWidth, wrapHeight);
    //components
    text(components, col1+x, row2+y, wrapWidth, wrapHeight);
    //duration
    text(duration, col2+x, row2+y, wrapWidth, wrapHeight);
    //target
    text(target, col1+x, row3+y, wrapWidth, wrapHeight);
    //savingThrow
    text(savingThrow, col2+x, row3+y, wrapWidth, wrapHeight);
    //spellResistance
    text(spellResistance, col1+x, row4+y, wrapWidth, wrapHeight);
    //level
    text(level, col2+x, row4+y, wrapWidth, wrapHeight);
    //description
    textAlign(LEFT);
    text(description, img.width/2+x, 700+y, 600, 440);
    //save("output/"+name+".png");
    rectMode(CORNER);
  }
}


class Coords
{
 int x;
 int y;
}

//int find(String line, char target)
//{
//  for (int i = 0; i < line.length(); i++)
//  {
//    if (line.charAt(i) == target)
//      return i;
//  }
//  return -1;
//}
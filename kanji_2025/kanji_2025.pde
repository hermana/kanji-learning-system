PFont jFont;
enum IState {
  CTRL, TRIAL, NO_MORE_PEEKS
}
IState state = IState.TRIAL;
PImage cheatSheet;
int MAX_PEEKS = 10;
int currPeeks;
MemoryString memoryString;
Character target;
String guess = "";

String[][] characters = {{"一", "one", "ichi, itsu", "hito-tsu", "1"}, {"二", "two", "ni, ji", "futa-tsu", "2"}, {"三", "three", "san", "mit-tsu", "3"}, {"四", "four", "shi", "yot-tsu, yon", "5"}, {"五", "five", "go", "itsu-tsu", "4"}, {"六", "six", "roku", "mut-tsu", "4"}, {"七", "seven", "shichi", "nana-tsu, nana", "2"}, {"八", "eight", "hachi", "yat-tsu", "2"}, {"九", "nine", "ku, kyū", "kokono-tsu", "2"}, {"十", "ten", "jū", "tō", "2"}, {"百", "hundred", "hyaku", "momo", "6"}, {"千", "thousand", "sen", "chi", "3"}, {"上", "top, above", "jō", "ue", "3"}, {"下", "bottom, below", "ka, ge", "shita, shimo, moto", "3"}, {"左", "left", "sa", "hidari", "5"}, {"右", "right", "u, yū", "migi", "5"}, {"中", "inside, middle", "chū, jū", "naka", "4"}, {"大", "large", "dai, tai", "ō-kii, ō", "3"}, {"小", "small", "shō", "chii-sai, ko, o", "3"}, {"月", "month, moon", "gatsu, getsu", "tsuki", "4"}, {"日", "day, sun", "nichi, jitsu", "hi, ka", "4"}, {"年", "year", "nen", "toshi", "6"}, {"早", "early", "sō, sa", "haya-i", "6"}, {"木", "tree", "moku, boku", "ki", "4"}, {"林", "woods", "rin", "hayashi", "8"}, {"山", "mountain", "san", "yama", "3"}, {"川", "river", "sen", "kawa", "3"}, {"土", "soil", "to, do", "tsuchi", "3"}, {"空", "sky, empty", "kū", "sora, a-ku, kara", "8"}, {"田", "rice field", "den", "da, ta", "5"}, {"天", "heaven, sky", "ten", "ame, ama", "4"}, {"生", "living, birth, raw", "sei, shō", "i-kiru, u-mu, nama", "5"}, {"花", "flower", "ka", "hana", "7"}, {"草", "grass", "sō", "kusa", "9"}, {"虫", "insect", "chū", "mushi", "6"}, {"犬", "dog", "ken", "inu", "4"}, {"人", "person", "jin, nin", "hito", "2"}, {"名", "name", "mei, myō", "na", "6"}, {"女", "female", "jo, nyo", "on'na", "3"}, {"男", "male", "dan, nan", "otoko", "7"}, {"子", "child", "shi, su", "ko", "3"}, {"目", "eye", "moku", "me", "5"}, {"耳", "ear", "ji, ni", "mimi", "6"}, {"口", "mouth", "kō", "kuchi", "3"}, {"手", "hand", "shu", "te", "4"}, {"足", "foot, suffice", "soku", "ashi, ta-riru", "7"}, {"見", "see", "ken, gen", "mi-ru", "7"}, {"音", "sound", "on", "ne, oto", "9"}, {"力", "power", "riki, ryoku", "chikara", "2"}, {"気", "spirit, air", "ki, ke", "iki", "6"}, {"円", "yen, circle", "en", "maru", "4"}, {"入", "enter", "nyū", "hai-ru, i-ru", "2"}, {"出", "exit", "shutsu", "de-ru", "5"}, {"立", "stand up", "ritsu", "ta-tsu", "5"}, {"休", "rest", "kyū", "yasu-mu", "6"}, {"先", "previous", "sen", "saki", "6"}, {"夕", "evening", "seki", "yū", "3"}, {"本", "book", "hon", "moto", "5"}, {"文", "text", "bun, mon", "fumi", "4"}, {"字", "character", "ji", "aza", "6"}, {"学", "study", "gaku", "mana-bu", "8"}, {"校", "school", "kō", "kase", "10"}, {"村", "village", "son", "mura", "7"}, {"町", "town", "chō", "machi", "7"}, {"森", "forest", "shin", "mori", "12"}, {"正", "correct", "sei, shō", "tada-shii, masa", "5"}, {"水", "water", "sui", "mizu", "4"}, {"火", "fire", "ka", "hi", "4"}, {"玉", "jewel, ball", "gyoku", "tama", "5"}, {"王", "king", "ō", "kimi", "4"}, {"石", "stone", "seki, koku", "ishi", "5"}, {"竹", "bamboo", "chiku", "take", "6"}, {"糸", "thread", "shi", "ito", "6"}, {"貝", "shellfish", "bai", "kai", "7"}, {"車", "vehicle", "sha", "kuruma", "7"}, {"金", "gold, money", "kin", "kane, kana", "8"}, {"雨", "rain", "u", "ame, ama", "8"}, {"赤", "red", "seki", "aka", "7"}, {"青", "blue", "sei, shō", "ao", "8"}, {"白", "white", "haku", "shiro, shira", "5"}};

void setup() {
  size(1000, 1000);

  cheatSheet = loadImage("cheatsheet.png");
  ArrayList<Character> kanji = new ArrayList<>();
  for (String[] spec : characters) {
    kanji.add(new Character(spec[0], spec[1], spec[2], spec[3]));
  }
  currPeeks = 0;
  //initialize memory string
  memoryString = new MemoryString(kanji);

  jFont = createFont("Yu Gothic UI Light", 96);

  textFont(jFont);
  textAlign(CENTER, CENTER);
  nextTarget();
}
void draw() {
  background(220);
  switch (state) {
  case TRIAL:
    target.drawAsTarget();
    textSize(32);
    text(guess, width/2, height/2 + 100);
    text("You may look at the cheatsheet "+str(getRemainingSneakPeeks())+" more times.", 500, 100); 
    memoryString.drawCurrentStreak();
    memoryString.drawMaxStreak();
    break;
  case CTRL:
    image(cheatSheet, 0, 0);
    break;
  case NO_MORE_PEEKS:
    text("You have exceeded the number of times \n you may look at the cheat sheet.", width/2, height/2);
    break;
  }
}

void keyPressed() {
  switch(keyCode) {
  case CONTROL:
    currPeeks+=1;
    state = currPeeks>MAX_PEEKS ? IState.NO_MORE_PEEKS : IState.CTRL;
    break;
  case BACKSPACE:
    guess = guess.substring(0, guess.length()-1);
    break;
  case DELETE:
    guess = guess.substring(0, guess.length()-1);
    break;
  case ENTER:
    if(state == IState.NO_MORE_PEEKS){
      memoryString.restartStreak();
      nextTarget();
      currPeeks = 0;
      state = IState.TRIAL;
    }else{
      if (target.checkGuess(guess)) {
         // correct 
         println("Correct");
         memoryString.updateStreak();
         nextTarget();
      } else {
         // incorrect
         println("Incorrect");
         memoryString.restartStreak();
         nextTarget();
      }
      guess = "";
    }
    break;
  default:
    guess += key;
    break;
  }
  if (keyCode == CONTROL) {
  } else {
  }
}

void keyReleased() {
  if (keyCode == CONTROL && state == IState.CTRL) {
    state = IState.TRIAL;
  }
}


void nextTarget() {
  target = memoryString.getCurrentCharacter();
  state = IState.TRIAL;
}

int getRemainingSneakPeeks(){
  return MAX_PEEKS - currPeeks;
}

void drawCheatSheet() {
  fill(0);
  int row = 0;
  int cols = 10;
  String[] character;
  float x, y;
  int index = 0;
  while (index < characters.length) {
    for (int col = 0; col < cols; col++) {
      if (index < characters.length) {
        character = characters[index];
        index++;
        x = col * 100 + 50;
        y = row * 120 + 50;
        textSize(96);
        text(character[0], x, y);
        textSize(18);
        text(character[1], x, y+50);
      }
    }
    row++;
  }
  //save("cheatsheet.png");
}

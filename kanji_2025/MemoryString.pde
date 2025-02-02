import java.util.Collections;

class MemoryString {

  ArrayList<Character> fullMemoryString;
  int currentIndex;
  int maxStreak;

  public MemoryString (ArrayList<Character> characters) {
    this.fullMemoryString = characters;
    Collections.shuffle(this.fullMemoryString);
    this.currentIndex = 0;
    this.maxStreak = 0;
  }
  
  public Character getCurrentCharacter(){
    return this.fullMemoryString.get(this.currentIndex);
  }
  
  public void updateStreak(){
    this.currentIndex++;
    if(this.currentIndex > this.maxStreak){
      this.maxStreak++;
    }
  }

  public int getMaxStreak(){
    return this.maxStreak;
  }
  
  public void restartStreak(){
    this.currentIndex=0;
  }
 
  public void drawCurrentStreak(){
    text("Current Streak: " + str(this.currentIndex), width-150, height-50);
  }
  
  public void drawMaxStreak(){
    text("Max Streak: " + str(this.maxStreak), 120, height-50);
  }
 
}

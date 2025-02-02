class Character {
  String ideogram;
  String translation;
  String name1;
  String name2;
  ArrayList<String> translations;

  public Character (String ideogram, String translation, String name1, String name2) {
    this.ideogram = ideogram;
    this.translation = translation;
    translations = new ArrayList<>();
    String[] candidates = split(translation, ',');
    for (String candidate : candidates) {
      translations.add(candidate);
    }

    this.name1 = name1;
    this.name2 = name2;
  }

  void drawAsTarget() {
    fill(0);
    textSize(96);
    text(ideogram, width/2, height/2);
  }

  void drawComplete() {
    fill(0);
    textSize(96);
    text(ideogram, width/2, height/2);
    textSize(18);
    text(translation, width/2, height/2 + 50);
  }

  void drawForCompare() {
    fill(0);
    textSize(96);
    text(ideogram, width/2, height/2);
    textSize(18);
    text(translation, width/2, height/2 + 50);
  }

  boolean checkGuess(String guess) {
    return translations.contains(guess);
  }
}

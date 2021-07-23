class Checker {
  //Returns password score on a scale of 0-100, where o is the worst and 100 is the best
  static int checkPassword(String password) {
    if (password.length == 0) {
      return 0;
    }
    //The different values collected from the password
    int numChars = password.length;
    int upperCase = 0;
    int lowerCase = 0;
    int numbers = 0;
    int symbols = 0;
    int middleNumSymb = 0;
    bool requirments = false;

    bool hasSpaces = false;
    bool hasPuctuation = false;
    bool lettersOnly = false;
    bool numsOnly = false;
    int repeated = 0;
    List<String> letters = [];
    List<int> counts = [];

    int conseqUp = 0;
    int conseqLow = 0;
    int conseqNum = 0;

    int sequentialLets = 0;
    int sequentialNums = 0;
    int sequentialSyms = 0;
    String prev = "-1";

    for (int i = 0; i < password.length; i++) {
      String currentLetter = password.substring(i, i + 1);
      if (letters.contains(currentLetter)) {
        int count = counts[letters.indexOf(currentLetter)];
        if (count == null || count == 0) {
          counts[letters.indexOf(currentLetter)] = 1;
        } else {
          counts[letters.indexOf(currentLetter)]++;
          if (count == 2) {
            repeated += 2;
          } else {
            repeated++;
          }
        }
      } else {
        letters.add(currentLetter);
        counts.add(1);
      }
      if (isUppercaseCharacter(currentLetter)) {
        upperCase++;
        if (isUppercaseCharacter(prev)) {
          conseqUp++;
        }
        if ("abcdefghijklmnopqrstuvwxyz"
            .contains("${prev.toLowerCase()}${currentLetter.toLowerCase()}")) {
          sequentialLets++;
        }
      } else if (isNumberCharacter(currentLetter)) {
        numbers++;
        if (i != 0 && i != password.length - 1) {
          middleNumSymb++;
        }
        if (isNumberCharacter(prev)) {
          conseqNum++;
        }
        if (isNumberCharacter(prev) &&
            "${int.parse(prev) + 1}".compareTo(currentLetter) == 0) {
          sequentialNums++;
        }
      } else if (isSymbolCharacter(currentLetter)) {
        symbols++;
        if (!hasPuctuation && isPuctuation(currentLetter)) {
          hasPuctuation = true;
        }
        if (i != 0 && i != password.length - 1) {
          middleNumSymb++;
        }
        if ("!@#\$%^&*()+_-=.;\"':,?!".contains("$prev$currentLetter")) {
          sequentialSyms++;
        }
      } else {
        if (currentLetter.compareTo(" ") == 0) {
          hasSpaces = true;
          lowerCase--;
        } else if (prev.toLowerCase().compareTo(prev) == 0) {
          conseqLow++;
        }
        if ("abcdefghijklmnopqrstuvwxyz"
            .contains("${prev.toLowerCase()}$currentLetter")) {
          sequentialLets++;
        }
        lowerCase++;
      }
      prev = currentLetter;
    }
    requirments = upperCase > 0 &&
        lowerCase > 0 &&
        (numbers > 0 || hasPuctuation) &&
        !hasSpaces;
    lettersOnly = numbers == 0 && symbols == 0;
    numsOnly = lowerCase == 0 && upperCase == 0 && symbols == 0;
    //Adding up all the scores
    int score = (numChars * 4) +
        ((numChars - upperCase) * 2) +
        ((numChars - lowerCase) * 2) +
        (numbers * 4) +
        (symbols * 6) +
        (middleNumSymb * 2) -
        (conseqUp * 2) -
        (conseqLow * 2) -
        (conseqNum * 2) -
        (sequentialNums * 3) -
        (sequentialLets * 3) -
        (sequentialSyms * 3) -
        (repeated<=2?repeated*2:repeated<=6?repeated*4:repeated<=10?repeated*6:repeated*10);
    if (requirments) {
      score += 6;
    }
    if (lettersOnly) {
      score -= numChars;
    }
    if (numsOnly) {
      score -= numChars;
    }
    return score<0?0:score>100?100:score;
  }

  static bool isUppercaseCharacter(String s) {
    if (s.length > 1 || s.isEmpty) {
      return false;
    } else {
      return "ABCDEFGHIJKLMNOPQRSTUVWXYZ".contains(s);
    }
  }

  static bool isNumberCharacter(String s) {
    if (s.length > 1 || s.isEmpty) {
      return false;
    } else {
      return "1234567890".contains(s);
    }
  }

  static bool isLowercaseCharacter(String s) {
    if (s.length > 1 || s.isEmpty) {
      return false;
    } else {
      return "abcdefghijklmnopqrstuvwxyz".contains(s);
    }
  }

  static bool isSymbolCharacter(String s) {
    if (s.length > 1 || s.isEmpty) {
      return false;
    } else {
      return "!@#\$%^&*()+_-=.;\"':,?!".contains(s);
    }
  }

  static bool isPuctuation(String s) {
    if (s.length > 1 || s.isEmpty) {
      return false;
    } else {
      return ".;\"':,?!0-".contains(s);
    }
  }
}

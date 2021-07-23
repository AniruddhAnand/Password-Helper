import 'dart:math';

class Generator{
  static Random _rnd = Random();
  static String getChars(bool lower, bool upper, bool numerical, bool spec) {
    String s = "";
    if (lower) {
      s += "abcdefghijklmnopqrstuvwxyz";
    }
    if (upper) {
      s += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    }
    if (numerical) {
      s += "123456789012345678901234567890";
    }
    if (spec) {
      s += "!@#\$%&*!@#\$%&*!@#\$%&*";
    }
    return s;
  }

  static String getRandomString(
      int length, bool lower, bool upper, bool numerical, bool spec) {
    String chars = getChars(lower, upper, numerical, spec);
    String s = String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_rnd.nextInt(chars.length))));
    if (spec) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(7);
      s = s.substring(0, rndIndex) +
          "!@#\$%&*".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    if (lower) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(26);
      s = s.substring(0, rndIndex) +
          "abcdefghijklmnopqrstuvwxyz".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    if (upper) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(26);
      s = s.substring(0, rndIndex) +
          "ABCDEFGHIJKLMNOPQRSTUVWXYZ".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    if (numerical) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(10);
      s = s.substring(0, rndIndex) +
          "1234567890".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    return s;
  }
}

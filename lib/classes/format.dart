class Format {
  static String moneyFormat(int value) {
    if (value == 0) {
      return "0";
    }

    String result = "";

    int counter = 0;
    while (value > 0) {
      if (counter % 3 == 0 && counter != 0) {
        result = "." + result;
      }
      result = (value % 10).toString() + result;
      value = value ~/ 10;
      counter++;
    }

    return result;
  }
}

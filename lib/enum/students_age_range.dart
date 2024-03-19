enum StudentsAgeRange {
  oneToTwo("1-2 ANOS"),
  threeToFour("3-4 ANOS"),
  fiveToSix("5-6 ANOS"),
  sevenToEight("7-8 ANOS"),
  nineToEleven("9-11 ANOS");

  final String name;
  
  const StudentsAgeRange(this.name);

  String getDescription() {
    return name;
  }
}

enum Month {
  january("Janeiro"),
  february("Fevereiro"),
  march("Março"),
  april("Abril"),
  may("Maio"),
  june("Junho"),
  july("Julho"),
  august("Agosto"),
  september("Setembro"),
  october("Outubro"),
  november("Novembro"),
  december("Dezembro");

  final String description;

  const Month(this.description);

  String getDescription() {
    return description;
  }
}

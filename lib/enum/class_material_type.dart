enum ClassMaterialType {
  smallGroup("PEQUENO GRUPO"),
  largeGroup("GRANDE GRUPO"),
  activity("ATIVIDADE");

  final String name;

  const ClassMaterialType(this.name);

  String getDescription() {
    return name;
  }
}




enum UserRole {
  admin("Administrador(a)"),
  pedagogicalCoordinator("Coordenador(a) Pedagógico"),
  daytimeRoomsCoordinator("Coordenador(a) de Salas Diurnas"),
  nighttimeRoomsCoordinator("Coordenador(a) de Salas Noturnas"),
  manualWorkCoordinator("Coordenador(a) de Trabalhos Manuais"),
  manualWorkColaborator("Colaborador(a) de Trabalhos Manuais"), 
  daytimeTeacher("Professor(a) Diurno"),
  nighttimeTeacher("Professor(a) Noturno");

  final String name;

  const UserRole(this.name);

  String getDescription() {
    return name;
  }
}

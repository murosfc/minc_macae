import 'package:flutter/material.dart';
import 'package:minc_macae/configuration/app-colors.dart';
import 'package:minc_macae/enum/class_material_type.dart';
import 'package:minc_macae/enum/month.dart';
import 'package:minc_macae/enum/students_age_range.dart';
import 'package:minc_macae/model/class_material.dart';
import 'package:minc_macae/service/authentications_service.dart';
import 'package:minc_macae/store/user_store.dart';

class ClassMaterialPage extends StatefulWidget {
  const ClassMaterialPage({required Key key}) : super(key: key);

  @override
  _ClassMaterialPageState createState() => _ClassMaterialPageState();
}

class _ClassMaterialPageState extends State<ClassMaterialPage> {
  List<ClassMaterial> materials = [ClassMaterial(weekNumber: 5, month: Month.april, year: 2024, classMaterialType: ClassMaterialType.smallGroup, ageRange: StudentsAgeRange.fiveToSix)];
  final AuthenticationService _authService = AuthenticationService();
  
  @override
  void initState() {
    super.initState();
    _loadMaterials();
  }

  void _loadMaterials() {
    // Suponha que _fileStore.getActiveMaterials() retorne uma lista de materiais ativos
    //List<ClassMaterial> activeMaterials = _fileStore.getActiveMaterials();
    // setState(() {
    //   materials = activeMaterials;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Materiais ativos', style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.pink,
      ),
      body: ListView.builder(
        itemCount: materials.length,
        itemBuilder: (context, index) {
          ClassMaterial material = materials[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (index == 0 || materials[index - 1].getWeekNumber != material.weekNumber)
                const Divider(color: Colors.grey), // Barra de divisão por semana
              ListTile(
                title: Text('Semana ${material.weekNumber}, ${material.month.name} ${material.year}'),
              ),
              if (index == materials.length - 1 || materials[index + 1].weekNumber != material.weekNumber)
                const Divider(color: Colors.grey), // Barra de divisão por semana
              ListTile(
                title: Text('${material.classMaterialType.name} ${material.ageRange.name}', style: const TextStyle(fontSize: 14),),
                onTap: () {
                  _authService.signOut();
                  //_fileStore.downloadPdf(material.id);
                  // Adicionar aqui o código para iniciar o download do arquivo PDF
                },
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

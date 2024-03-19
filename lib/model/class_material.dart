import 'package:minc_macae/enum/class_material_type.dart';
import 'package:minc_macae/enum/month.dart';
import 'package:minc_macae/enum/students_age_range.dart';

class ClassMaterial {
  String? id;
  int weekNumber;
  Month month;
  int year;
  ClassMaterialType classMaterialType;
  StudentsAgeRange ageRange;
  

  ClassMaterial({
    this.id,
    required this.weekNumber,
    required this.month,
    required this.year,
    required this.classMaterialType,
    required this.ageRange,
    
  });

  String? get getId => id;
  int get getWeekNumber => weekNumber;
  Month get getMonth => month;
  int get getYear => year;
  ClassMaterialType get getMaterialType => classMaterialType;
  StudentsAgeRange get getAgeRange => ageRange;
   
  set setId(String? value) => id = value;
  set setWeekNumber(int value) => weekNumber = value;
  set setMonth(Month value) => month = value;
  set setYear(int value) => year = value;
  set setMaterialType(ClassMaterialType value) => classMaterialType = value;
  set setAgeRange(StudentsAgeRange value) => ageRange = value;

}
import 'package:cct/models/plant.dart';

class PlantRepositories {
  List<Plant> plantDefault = [
    Plant(code: '*', codeName: 'ALL PLANT'),
    Plant(code: '3212', codeName: 'CJ Feed Serang'),
    Plant(code: '3222', codeName: 'CJ Feed Jombang'),
    Plant(code: '3232', codeName: 'CJ Feed Medan'),
    Plant(code: '3242', codeName: 'CJ Feed Lampung'),
    Plant(code: '3252', codeName: 'CJ Feed Semarang'),
    Plant(code: '3262', codeName: 'CJ Feed Kalimantan'),
  ];

  List<Plant> plantOverdue = [
    Plant(code: '*', codeName: 'ALL PLANT'),
    Plant(code: '3210', codeName: 'CJ Feed Serang'),
    Plant(code: '3220', codeName: 'CJ Feed Jombang'),
    Plant(code: '3230', codeName: 'CJ Feed Medan'),
    Plant(code: '3240', codeName: 'CJ Feed Lampung'),
    Plant(code: '3250', codeName: 'CJ Feed Semarang'),
    Plant(code: '3260', codeName: 'CJ Feed Kalimantan'),
  ];

  Future<List<Plant>> getDataPlant(String? userPlant) async {
    if (userPlant != "*") {
      return plantDefault.where((item) => item.code == userPlant).toList();
    }
    return plantDefault;
  }

  Future<List<Plant>> getDataPlantOverdue(String? userPlant) async {
    if (userPlant! != "*") {
      return plantOverdue.where((item) => item.code == userPlant).toList();
    }
    return plantOverdue;
  }
}

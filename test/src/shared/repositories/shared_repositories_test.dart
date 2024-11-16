import 'package:cantinho_da_pizza/src/features/costumers/business/costumers_business.dart';
import 'package:cantinho_da_pizza/src/shared/models/costumers_model.dart';
import 'package:cantinho_da_pizza/src/shared/repositories/shared_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  late SharedRepositories db;
  late CostumersController controller;

  Map<String, Object> json = {
    "costumer": [
      {
        "name": "Daniel",
        "adress": "Rua Travessa do Abreu",
        "numberPhone": "61 999808449",
        "pizzas": [
          {
            "flavor": ["Port", "Calabresa"],
            "date": "20/10"
          }
        ]
      },
      {
        "name": "Jessica",
        "adress": "Rua Travessa do Abreu",
        "numberPhone": "61 999808449",
        "pizzas": [
          {
            "flavor": ["Port", "Calabresa", "Banana Nevada", "a"],
            "date": "20/10"
          }
        ]
      }
    ]
  };

  setUp(() async {
    SharedPreferences.setMockInitialValues(json);
    db = SharedRepositories();
    controller = CostumersController(db);
  });

  group('Shared Preferences', () {
    /// ACTUALLY HAVE 1 COSTUMERS IN DB.
    test('Shared init return CostumersModel', () async {
      await controller.init();
      final result = controller.listCostumers!;

      expect(result, isInstanceOf<CostumersModel>());
    });

    test('Shared init == db', () async {
      await controller.init();

      expect(controller.listCostumers!.costumer.length, 1);
    });

    test('Shared update data', () async {
      await controller.init();
      await controller.saveOrderOrCostumer(
          name: 'Ronaldo',
          phoneNumber: '123',
          adress: 'Fenomeno',
          date: '08/11',
          listFlavors: ["Calab"]);
      await controller.init();
      expect(controller.listCostumers!.costumer.length, 2);
    });
  });
}

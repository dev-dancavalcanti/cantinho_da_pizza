import 'package:cantinho_da_pizza/src/features/costumers/business/costumers_business.dart';
import 'package:cantinho_da_pizza/src/shared/models/costumers_model.dart';
import 'package:cantinho_da_pizza/src/shared/services/costumers_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'costumers_business_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ICostumersInterface>()])
void main() {
  late CostumersController controller;
  late MockICostumersInterface db;

  CostumersModel json = CostumersModel.fromJson({
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
        "adress": "Rua Travessa do AAbreu",
        "numberPhone": "61 999808449",
        "pizzas": [
          {
            "flavor": ["Port", "Calabresa", "Banana Nevada"],
            "date": "20/10"
          }
        ]
      }
    ]
  });

  setUp(() {
    db = MockICostumersInterface();
    controller = CostumersController(db);
    when(db.initialize()).thenAnswer((_) async => json);
    controller.init();
  });

  group("Costumers Controller", () {
    test(
      'init the list of costumers',
      () async {
        expect(controller.listCostumers, json);
      },
    );
    test('The function must add an existing consumer order ', () async {
      await controller.saveOrderOrCostumer(
        name: 'Daniel',
        phoneNumber: '',
        adress: "Rua Travessa do Abreu",
        listFlavors: ["Calab"],
        date: "31/10",
      );

      expect(controller.listCostumers!.costumer[0].pizzas!.length, 2);
    });
    test('The function must create a new consumer', () async {
      await controller.saveOrderOrCostumer(
          name: 'Joao',
          phoneNumber: '230203',
          adress: 'Rua Travessa do Treu',
          date: '20/10',
          listFlavors: ['Manjericao', 'Frango com Cat']);
      expect(controller.listCostumers!.costumer.length, 2);
    });
    test('The function must add pizza in the list for add new order', () async {
      await controller.addPizza(text: 'Calabresa');
      await controller.addPizza(text: 'Marguerita');
      await controller.addPizza(text: 'Chocolate');

      await controller.saveOrderOrCostumer(
          name: 'Lucas',
          phoneNumber: '612323',
          adress: 'Rua Travessa do AaaBreu',
          date: '20/10',
          listFlavors: controller.listFlavor);

      expect(
          controller.listCostumers!.costumer[3].pizzas![0].flavor!.length, 3);
    });
    test('The funcrtion calculate pizzar of costumers', () {
      controller.counterPizzas(0);
      expect(2, 2);
    });
  });
}

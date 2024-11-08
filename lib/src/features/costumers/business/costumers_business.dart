import 'package:flutter/material.dart';
import '../../../shared/models/costumers_model.dart';
import '../../../shared/services/costumers_interface.dart';

class CostumersController extends ChangeNotifier {
  final ICostumersInterface _db;
  CostumersController(this._db) {
    init();
  }

  CostumersModel? listCostumers;
  List<String> listFlavor = [];
  bool isLoading = false;

  TextEditingController nameCostumer = TextEditingController();
  TextEditingController phoneNumberCostumer = TextEditingController();
  TextEditingController adressCostumer = TextEditingController();
  TextEditingController flavorPizza = TextEditingController();
  TextEditingController datePizza = TextEditingController();

  Future<CostumersModel?> init() async {
    return listCostumers = await _db.initialize();
  }

  Future<List> addPizza({required String text}) async {
    listFlavor.add(text);
    flavorPizza.clear();
    return listFlavor;
  }

  /// This function checks whether it will save a new consumer or save an order from an existing consumer
  Future<void> saveOrderOrCostumer({
    required String name,
    required String phoneNumber,
    required String adress,
    required String date,
    required List<String> listFlavors,
  }) {
    for (var i = 0; i < listCostumers!.costumer.length; ++i) {
      if (name == listCostumers!.costumer[i].name) {
        return saveOrder(
          listFlavors: listFlavors,
          date: date,
          index: i,
        );
      }
    }
    return saveNewCostumer(
      name: name,
      phoneNumber: phoneNumber,
      adress: adress,
      listFlavors: listFlavors,
      date: date,
    );
  }

  /// The function must add an existing consumer order
  Future<void> saveNewCostumer(
      {required String name,
      required String phoneNumber,
      required String adress,
      required List<String> listFlavors,
      required String date}) async {
    listCostumers!.costumer.add(Costumer(
      name: name,
      phoneNumber: phoneNumber,
      adress: adress,
      pizzas: [
        Pizzas(flavor: listFlavors, date: date),
      ],
    ));
  }

  /// The function must add an existing consumer order
  Future<void> saveOrder({
    required List<String> listFlavors,
    required String date,
    required int index,
  }) async {
    Pizzas order = Pizzas(flavor: listFlavors, date: date);

    listCostumers!.costumer[index].pizzas!.add(order);
  }
}

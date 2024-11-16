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
  bool isVisible = false;

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController flavor = TextEditingController();
  TextEditingController date = TextEditingController();

  Future<void> init() async {
    await toggleLoading();
    listCostumers = await _db.initialize();
    await toggleLoading();
  }

  String counterPizzas(int index) {
    List orders = [];

    for (var i = 0; i < listCostumers!.costumer[index].pizzas!.length; i++) {
      orders.add(listCostumers!.costumer[index].pizzas![i].flavor!.length);
    }
    final pizzas = orders.reduce((value, element) {
      return value + element;
    });
    return pizzas.toString();
  }

  Future<void> addPizza({required String text}) async {
    isVisible = true;
    listFlavor.add(text);
    flavor.clear();
    listFlavor;
    notifyListeners();
  }

  Future<void> toggleLoading() async {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> removePizza({required int index}) async {
    listFlavor.removeAt(index);
    if (listFlavor.isEmpty) {
      isVisible = false;
    }

    notifyListeners();
  }

  Future<void> clearText() async {
    listFlavor.clear();
    adress.clear();
    date.clear();
    name.clear();
    flavor.clear();
    phoneNumber.clear();
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
      if (name == listCostumers!.costumer[i].name ||
          adress == listCostumers!.costumer[i].adress ||
          phoneNumber == listCostumers!.costumer[i].phoneNumber) {
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
    _db.updateData(listCostumers!);
    isVisible = false;
  }

  /// The function must add an existing consumer order
  Future<void> saveOrder({
    required List<String> listFlavors,
    required String date,
    required int index,
  }) async {
    Pizzas order = Pizzas(flavor: listFlavors, date: date);

    listCostumers!.costumer[index].pizzas!.add(order);
    _db.updateData(listCostumers!);

    isVisible = false;
  }
}

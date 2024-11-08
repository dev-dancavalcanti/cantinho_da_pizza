import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/costumers_model.dart';
import '../services/costumers_interface.dart';

class SharedRepositories implements ICostumersInterface {
  late SharedPreferences _shared;
  final String _key = 'consumers';

  @override
  Future<CostumersModel?> initialize() async {
    _shared = await SharedPreferences.getInstance();

    await firstInit();
    String? jsonEncode = _shared.getString(_key);
    return CostumersModel.fromJson(jsonDecode(jsonEncode!));
  }

  @override
  Future<void> firstInit() async {
    if (_shared.get(_key) == null) {
      Map<String, dynamic> costumerList = {
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
                "flavor": ["Port", "Calabresa", "Banana Nevada"],
                "date": "20/10"
              }
            ]
          }
        ]
      };
      await _shared.setString(_key, jsonEncode(costumerList));
    }
  }

  @override
  Future<void> updateData(CostumersModel costumerList) async {
    await _shared.setString(_key, jsonEncode(costumerList));
  }
}

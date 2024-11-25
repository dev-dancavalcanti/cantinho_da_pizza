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
    String? data = _shared.getString(_key);
    return CostumersModel.fromJson(jsonDecode(data!));
  }

  @override
  Future<void> firstInit() async {
    if (_shared.get(_key) == null) {
      Map<String, dynamic> costumerList = {
        "costumer": [
          {
            "name": "Jantas",
            "adress": "Cantinho da Pizza",
            "phoneNumber": "61 999808449",
            "orders": [
              {
                "flavor": ["Port", "Calabresa"],
                "date": "20/10"
              }
            ]
          },
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

import '../models/costumers_model.dart';

abstract class ICostumersInterface {
  Future initialize() async {}

  Future<void> updateData(CostumersModel costumerList) async {}

  Future<void> firstInit() async {}
}

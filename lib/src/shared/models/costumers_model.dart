class CostumersModel {
  late List<Costumer> costumer;

  CostumersModel({
    required this.costumer,
  });

  CostumersModel.fromJson(Map<String, dynamic> json) {
    if (json['costumer'] != null) {
      costumer = <Costumer>[];
      json['costumer'].forEach((v) {
        costumer.add(Costumer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['costumer'] = costumer.map((v) => v.toJson()).toList();
    return data;
  }
}

class Costumer {
  String? name;
  String? adress;
  String? phoneNumber;
  List<Pizzas>? pizzas;

  Costumer(
      {required this.name,
      required this.adress,
      required this.phoneNumber,
      required this.pizzas});

  Costumer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    adress = json['adress'];
    phoneNumber = json['phoneNumber'];
    if (json['pizzas'] != null) {
      pizzas = <Pizzas>[];
      json['pizzas'].forEach((v) {
        pizzas!.add(Pizzas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['adress'] = adress;
    data['phoneNumber'] = phoneNumber;
    if (pizzas != null) {
      data['pizzas'] = pizzas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pizzas {
  List<dynamic>? flavor;
  String? date;

  Pizzas({
    required this.flavor,
    required this.date,
  });

  Pizzas.fromJson(Map<String, dynamic> json) {
    flavor = json['flavor'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flavor'] = flavor;
    data['date'] = date;
    return data;
  }
}

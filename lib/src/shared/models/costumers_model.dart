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
  List<Order>? orders;

  Costumer(
      {required this.name,
      required this.adress,
      required this.phoneNumber,
      required this.orders});

  Costumer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    adress = json['adress'];
    phoneNumber = json['phoneNumber'];
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['adress'] = adress;
    data['phoneNumber'] = phoneNumber;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  List<String>? flavor;
  String? date;

  Order({
    required this.flavor,
    required this.date,
  });

  Order.fromJson(Map<String, dynamic> json) {
    flavor = json['flavor'].cast<String>();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flavor'] = flavor;
    data['date'] = date;
    return data;
  }
}

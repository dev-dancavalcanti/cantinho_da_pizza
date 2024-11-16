import 'package:cantinho_da_pizza/src/features/costumers/presentation/costumers_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../business/costumers_business.dart';

class CostumersPage extends StatelessWidget {
  const CostumersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CostumersController controller = context.watch<CostumersController>();
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: controller,
        builder: (context, child) {
          if (controller.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.listCostumers!.costumer.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConstumersDetails(index: i)));
                  },
                  child: Card(
                      child: Row(
                    children: [
                      const SizedBox(
                          width: 100, height: 50, child: Icon(Icons.person)),
                      Column(
                        children: [
                          Text(controller.listCostumers!.costumer[i].name!),
                          Row(
                            children: [
                              const Icon(Icons.house),
                              Text(controller
                                  .listCostumers!.costumer[i].adress!),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              Text(controller
                                  .listCostumers!.costumer[i].phoneNumber!),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.local_pizza),
                              Text(controller.counterPizzas(i)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
                );
              },
            );
          }
        },
      ),
    );
  }
}

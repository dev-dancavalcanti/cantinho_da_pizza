import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business/costumers_business.dart';

class ConstumersDetails extends StatelessWidget {
  final int index;
  const ConstumersDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final CostumersController controller = context.watch<CostumersController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.listCostumers!.costumer[index].name!,
            textAlign: TextAlign.center,
          ),
        ),
        body: ChangeNotifierProvider.value(
            value: controller,
            child: ListView.builder(
              itemCount:
                  controller.listCostumers!.costumer[index].pizzas!.length,
              itemBuilder: (context, i) {
                return Card(
                  child: Column(
                    children: [
                      Text(controller
                          .listCostumers!.costumer[index].pizzas![i].date!),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ListView.builder(
                            itemCount: controller.listCostumers!.costumer[index]
                                .pizzas![i].flavor!.length,
                            itemBuilder: (context, ii) {
                              return Text(controller.listCostumers!
                                  .costumer[index].pizzas![i].flavor![ii]);
                            }),
                      )
                    ],
                  ),
                );
              },
            )));
  }
}
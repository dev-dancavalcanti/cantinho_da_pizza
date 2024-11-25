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
                  controller.listCostumers!.costumer[index].orders!.length,
              itemBuilder: (context, numas) {
                return Card(
                  child: Column(
                    children: [
                      Text(controller
                          .listCostumers!.costumer[index].orders![numas].date!),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: ListView.builder(
                            itemCount: controller.listCostumers!.costumer[index]
                                .orders![numas].flavor!.length,
                            itemBuilder: (context, i) {
                              return Text(controller.listCostumers!
                                  .costumer[index].orders![numas].flavor![i]);
                            }),
                      )
                    ],
                  ),
                );
              },
            )));
  }
}

import 'package:cantinho_da_pizza/src/features/costumers/business/costumers_business.dart';
import 'package:cantinho_da_pizza/src/features/splash/presentation/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostumersSignUp extends StatelessWidget {
  const CostumersSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final CostumersController controller = context.watch<CostumersController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: ChangeNotifierProvider.value(
          value: controller,
          child: Column(
            children: [
              SizedBox(
                height: 250,
              ),
              CustomTextField(controller: controller.name, text: 'name'),
              CustomTextField(
                controller: controller.phoneNumber,
                text: 'celular',
              ),
              Container(
                  child: CustomTextField(
                      controller: controller.adress, text: 'endereco')),
              CustomTextField(controller: controller.date, text: 'data'),
              CustomTextField(
                text: 'Sabores',
                controller: controller.flavor,
                add: true,
                function: () {
                  controller.addPizza(text: controller.flavor.text);
                },
              ),
              Visibility(
                  visible: controller.isVisible,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.listFlavor.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4),
                                    child: Text(controller.listFlavor[index]))),
                            Positioned(
                              child: IconButton(
                                  onPressed: () {
                                    controller.removePizza(index: index);
                                  },
                                  icon: const Icon(Icons.highlight_remove)),
                            )
                          ],
                        );
                      },
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    controller.saveOrderOrCostumer(
                        name: controller.name.text,
                        phoneNumber: controller.phoneNumber.text,
                        adress: controller.adress.text,
                        listFlavors: controller.listFlavor,
                        date: controller.date.text);

                    // controller.clearText();
                  },
                  child: const Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}

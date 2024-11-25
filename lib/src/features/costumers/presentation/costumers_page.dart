import 'package:cantinho_da_pizza/src/features/costumers/presentation/costumers_details_page.dart';
import 'package:cantinho_da_pizza/src/features/costumers/presentation/costumers_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../business/costumers_business.dart';

class CostumersPage extends StatefulWidget {
  const CostumersPage({super.key});

  @override
  State<CostumersPage> createState() => _CostumersPageState();
}

class _CostumersPageState extends State<CostumersPage> {
  late PageController pageController;
  int indexPage = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: indexPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CostumersController controller = context.watch<CostumersController>();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          pageController.jumpToPage(value);
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Add',
              icon: Icon(
                Icons.add,
              )),
          BottomNavigationBarItem(
              label: 'List',
              icon: Icon(
                Icons.list,
              ))
        ],
        currentIndex: indexPage,
      ),
      body: ChangeNotifierProvider.value(
        value: controller,
        builder: (context, child) {
          if (controller.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return PageView(
              onPageChanged: (value) {
                setState(() {
                  indexPage = value;
                });
              },
              controller: pageController,
              children: const [
                CostumersSignUp(),
                ListCostumersPage(),
              ],
            );
          }
        },
      ),
    );
  }
}

class ListCostumersPage extends StatelessWidget {
  const ListCostumersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CostumersController controller = context.watch<CostumersController>();
    return ListView.builder(
      itemCount: controller.listCostumers!.costumer.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ConstumersDetails(index: i)));
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertBox(
                  name: controller.listCostumers!.costumer[i].name!,
                  controller: controller,
                  i: i,
                );
              },
            );
          },
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.listCostumers!.costumer[i].name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(controller.listCostumers!.costumer[i].adress!),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 8),
                child: Text(controller.listCostumers!.costumer[i].phoneNumber!),
              ),
            ],
          )),
        );
      },
    );
  }
}

class AlertBox extends StatelessWidget {
  final int i;
  final CostumersController controller;
  final String name;
  const AlertBox(
      {super.key,
      required this.i,
      required this.controller,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Deseja deletar o cliente $name?',
      ),
      scrollable: true,
      backgroundColor: Colors.white,
      content: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                controller.removeCostumer(index: i);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            )
          ],
        ),
      ),
    );
  }
}

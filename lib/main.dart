import 'package:cantinho_da_pizza/src/features/costumers/business/costumers_business.dart';
import 'package:cantinho_da_pizza/src/features/costumers/presentation/costumers_page.dart';
import 'package:cantinho_da_pizza/src/features/costumers/presentation/costumers_sign_up.dart';
import 'package:cantinho_da_pizza/src/shared/repositories/shared_repositories.dart';
import 'package:cantinho_da_pizza/src/shared/services/costumers_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ICostumersInterface>(create: (_) => SharedRepositories()),
          ChangeNotifierProvider<CostumersController>(
            create: (i) => CostumersController(i.read<ICostumersInterface>()),
          ),
        ],
        child: MaterialApp(
          title: 'Cantinho da Pizza',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const CostumersPage(),
            '/signUp': (context) => const CostumersSignUp()
          },
        ));
  }
}

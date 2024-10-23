import 'package:aprendendo_flutter/view/CustomSplashScreen.dart';
import 'package:aprendendo_flutter/view/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:aprendendo_flutter/models/counter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart'; // Importe o Provider

void main() async {
  // Inicializa o Hive
  await Hive.initFlutter();

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          CounterModel(), // Crie uma instância do modelo de contador
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomSplashScreen(),
      routes: {
        '/login': (context) => LoginPage(), // Rota para a tela principal
      },
    );
  }
}

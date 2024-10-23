import 'package:aprendendo_flutter/components/custom_appbar.dart';
import 'package:aprendendo_flutter/view/SearchUserPage.dart';
import 'package:flutter/material.dart';
import 'package:aprendendo_flutter/components/custom_buttom.dart';
import 'package:aprendendo_flutter/components/custom_counter_display.dart';
import 'package:aprendendo_flutter/view/ScreenCounter.dart';
import 'package:aprendendo_flutter/view/ScreenImageLocal.dart';
import 'package:aprendendo_flutter/view/ScreenImageNetwork.dart';
import 'package:aprendendo_flutter/view/LoginPage.dart';
import 'ScreenDrawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Home Page", // Título passado ao AppBar
        showBackButton: false, // Se você quiser esconder a seta de voltar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exibindo o valor do contador
              Text(
                "Contador:",
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height:20),
              const CustomCounterDisplay(), // Usando o novo componente
              const SizedBox(height:20),
              CustomButtom(
                buttonText: "Lista de Imagens",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenDrawer()),
                  );
                },
              ),
              const SizedBox(height:20),
              CustomButtom(
                buttonText: "Procura Usuário",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchUserPage()),
                  );
                },
              ),
              const SizedBox(height:20),
              CustomButtom(
                buttonText: "Contador",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenCounter()),
                  );
                },
              ),
              const SizedBox(height:20),
              CustomButtom(
                buttonText: "Imagem Local",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenImageLocal()),
                  );
                },
              ),
              const SizedBox(height:20),
              CustomButtom(
                buttonText: "Imagem Web",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenImageNetwork()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

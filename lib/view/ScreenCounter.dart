import 'package:aprendendo_flutter/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:aprendendo_flutter/components/custom_counter_display.dart';
import 'package:aprendendo_flutter/models/counter.dart';
import 'package:provider/provider.dart';

class ScreenCounter extends StatelessWidget {
  const ScreenCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Contador", // Título passado ao AppBar
        showBackButton: false, // Se você quiser esconder a seta de voltar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CustomCounterDisplay(), // Exibe o contador personalizado
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contador:',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context)
                        .primaryColor, // Tamanho da fonte // Cor da fonte
                  ),
                ),
                const SizedBox(
                    height: 40), // Espaçamento entre o contador e os botões
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        Provider.of<CounterModel>(context, listen: false)
                            .decrement(); // Chama o método para diminuir
                      },
                      iconSize: 40, // Tamanho do ícone
                      color: Theme.of(context).primaryColor, // Cor do ícone
                    ),
                    const SizedBox(width: 20), // Espaço entre os botões
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Provider.of<CounterModel>(context, listen: false)
                            .increment(); // Chama o método para aumentar
                      },
                      iconSize: 40, // Tamanho do ícone
                      color: Theme.of(context).primaryColor, // Cor do ícone
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

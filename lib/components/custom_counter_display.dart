import 'package:flutter/material.dart';
import 'package:aprendendo_flutter/models/counter.dart';
import 'package:provider/provider.dart';

class CustomCounterDisplay extends StatelessWidget {
  const CustomCounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (context, counterModel, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 241, 248),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Cor da sombra
                      spreadRadius: 1, // Expansão da sombra
                      blurRadius: 1, // Desfoque da sombra
                      offset: Offset(0,
                        3), // Posição da sombra (deslocamento horizontal e vertical)
                    ),
                  ],
                ),
                child: Text(
                  '${counterModel.counter ~/ 10}',
                  style: TextStyle(
                    fontSize: 80,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                ':',
                style: TextStyle(
                  fontSize: 80,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 241, 248),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Cor da sombra
                      spreadRadius: 1, // Expansão da sombra
                      blurRadius: 1, // Desfoque da sombra
                      offset: Offset(0,
                        3), // Posição da sombra (deslocamento horizontal e vertical)
                    ),
                  ],
                ),
                child: Text(
                  '${counterModel.counter % 10}',
                  style: TextStyle(
                    fontSize: 80,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

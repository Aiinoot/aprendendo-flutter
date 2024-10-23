import 'package:aprendendo_flutter/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:aprendendo_flutter/components/custom_dropdown.dart';
import 'package:aprendendo_flutter/components/custom_notification.dart'; // Importe o componente de notificação
import 'package:aprendendo_flutter/components/custom_buttom.dart';
import 'package:aprendendo_flutter/view/Home.dart'; // Importe o botão customizado

class ScreenDrawer extends StatefulWidget {
  const ScreenDrawer({super.key});

  @override
  _ScreenDrawerState createState() => _ScreenDrawerState();
}

class _ScreenDrawerState extends State<ScreenDrawer>
    with TickerProviderStateMixin {
  String? selectedValue; // Variável para armazenar o valor selecionado

  // Lista de itens para o dropdown
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  void _showPopup(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Item Selecionado"),
          content: Text("Você selecionou: $item"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Drawer", // Título passado ao AppBar
        showBackButton: false, // Se você quiser esconder a seta de voltar
      ),
      // Adicionando o Drawer ao Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                // Adicione a navegação ou funcionalidade desejada aqui
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                // Adicione a navegação ou funcionalidade desejada aqui
              },
            ),
            ListTile(
              title: const Text('Sair Para o Menu'),
              onTap: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ); // Fecha o drawer
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CustomDropdownButton
            CustomDropdownButton(
              value: selectedValue,
              items: items,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue;
                });

                // Mostra o popup quando um item é selecionado
                if (newValue != null) {
                  _showPopup(newValue);
                }
              },
            ),
            const SizedBox(height: 20),
            //Botão de Notificação do Topo
            CustomButtom(
              buttonText: "Notificação Topo",
              onPressed: () {
                // Mostra a notificação do topo (de cima para o centro)
                CustomNotification.showNotification(
                  context: context,
                  vsync: this, // Passa o vsync do StatefulWidget
                  isTop: true,
                  message: "Notificação do Topo",
                  beginOffset:
                      const Offset(0, -2), // Começa fora da tela (em cima)
                  endOffset: Offset.zero, // Termina no centro
                  duration: const Duration(seconds: 1), // Duração da animação
                );
              },
            ),
            const SizedBox(height: 20), // Espaço entre os botões
            //Botão de Notificação Inferior
            CustomButtom(
              buttonText: "Notificação Inferior",
              onPressed: () {
                // Mostra a notificação inferior (de baixo para o centro)
                CustomNotification.showNotification(
                  context: context,
                  vsync: this, // Passa o vsync do StatefulWidget
                  isTop: false,
                  message: "Notificação Inferior",
                  beginOffset:
                      const Offset(0, 2), // Começa fora da tela (em baixo)
                  endOffset: Offset.zero, // Termina no centro
                  duration: const Duration(seconds: 1), // Duração da animação
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

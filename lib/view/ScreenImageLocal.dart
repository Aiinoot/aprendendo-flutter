import 'package:aprendendo_flutter/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:aprendendo_flutter/components/custom_buttom.dart';
import 'package:aprendendo_flutter/components/custom_notification.dart'; // Importe o componente de notificação

class ScreenImageLocal extends StatefulWidget {
  const ScreenImageLocal({super.key});

  @override
  _ScreenImageLocalState createState() => _ScreenImageLocalState();
}

class _ScreenImageLocalState extends State<ScreenImageLocal>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Imagem Local", // Título passado ao AppBar
        showBackButton: false, // Se você quiser esconder a seta de voltar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/wallpaper.jpg",
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            CustomButtom(
              buttonText: "Notificação Top",
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

import 'package:aprendendo_flutter/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:aprendendo_flutter/components/custom_buttom.dart';
import 'package:aprendendo_flutter/components/custom_notification.dart'; // Importe o componente de notificação

class ScreenImageNetwork extends StatefulWidget {
  const ScreenImageNetwork({super.key});

  @override
  _ScreenImageNerworkState createState() => _ScreenImageNerworkState();
}

class _ScreenImageNerworkState extends State<ScreenImageNetwork>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Imagem Network", // Título passado ao AppBar
        showBackButton: false, // Se você quiser esconder a seta de voltar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adicionando o loadingBuilder e o errorBuilder
            Image.network(
              'https://img.freepik.com/fotos-gratis/vista-do-modelo-de-carro-3d_23-2151138955.jpg?size=626&ext=jpg&ga=GA1.1.2069200294.1728067978&semt=ais_hybrid',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Center(
                  child: Text(
                    'Erro ao carregar a imagem',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              },
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

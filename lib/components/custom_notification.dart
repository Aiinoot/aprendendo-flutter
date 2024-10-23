import 'package:flutter/material.dart';

class CustomNotification {
  // Método genérico para mostrar a notificação com animação embutida
  static void showNotification({
    required BuildContext context,
    required TickerProvider vsync, // Recebe o vsync de um widget com estado
    required bool isTop, // Define se é uma notificação "Top" ou "Under"
    required String message, // Mensagem a ser exibida
    required Offset beginOffset, // Posição inicial da animação
    required Offset endOffset, // Posição final da animação
    required Duration duration, // Duração da animação
  }) {
    final overlay = Overlay.of(context);
    late AnimationController animationController;
    late Animation<Offset> offsetAnimation;

    // Inicializa o controlador de animação
    animationController = AnimationController(
      vsync: vsync, // Usa o vsync passado
      duration: duration, // Define a duração da animação
    );

    // Configura o Tween para definir o início e o final da animação
    offsetAnimation = Tween<Offset>(
      begin: beginOffset, // Posição inicial
      end: endOffset, // Posição final
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    // Cria um OverlayEntry para ser exibido
    final overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: isTop ? 16 : null, // Se for "Top", define a margem superior
              bottom: !isTop
                  ? 16
                  : null, // Se for "Under", define a margem inferior
              left: 16,
              right: 16,
              child: SlideTransition(
                position: offsetAnimation, // Aplica a animação de deslocamento
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Theme.of(context).primaryColor, // Cor de fundo
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Adiciona a notificação ao overlay
    overlay.insert(overlayEntry);

    // Inicia a animação
    animationController.forward();

    // Remove a notificação após alguns segundos
    Future.delayed(duration, () {
      animationController.reverse().then((_) {
        overlayEntry.remove(); // Remove a notificação
        animationController.dispose(); // Libera o controlador de animação
      });
    });
  }
}

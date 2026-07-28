import 'package:flutter/material.dart';

class BotaoForm extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color gradient1;
  final Color gradient2;
  const BotaoForm({super.key, required this.label, required this.onPressed, required this.gradient1, required this.gradient2});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundBuilder: (context, states, child) {
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [gradient1, gradient2],
              ),
            ),
            child: child,
          );
        },
      ),
      onPressed: onPressed,
      child: Text("Iniciar Consulta", style: TextStyle(color: Colors.white)),
    );
  }
}

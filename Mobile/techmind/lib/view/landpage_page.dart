import 'package:flutter/material.dart';
import 'package:techmind/view/consulta_conteudo_view.dart';

class Landpage extends StatelessWidget {
  const Landpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.amber, Colors.blue],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Text(
                  "Descubra o que seus dados realmente significam",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Analise informações rapidamente através do nosso "
                  "sistema de classificação de dados. Informe o conteúdo desejado"
                  " e receba um resultado detalhado com a categoria identificada, "
                  "o tipo correspondente e o nível de probabilidade da classificação.",
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ConsultaConteudoView()),
                    );
                  },
                  child: Text("Iniciar Consulta"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
            image: DecorationImage(
              image: AssetImage('assets/plano_de_fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Organização Inteligente",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: " de Conhecimento Técnico",
                        style: TextStyle(color: const Color(0xFF000EA7)),
                      ),
                    ],
                  ),
                ),
                Text(
                  "organização inteligente de conteúdo técnico, facilitando sua classificação,"
                  " consulta e reutilização",
                  style: TextStyle(fontSize: 18, color: Color(0xFF707070)),
                  textAlign: TextAlign.center,
                ),
                Image.asset("assets/logo.png", scale: 2),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundBuilder: (context, states, child) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              const Color(0xFF000EA7),
                              const Color(0xFF000541),
                            ],
                          ),
                        ),
                        child: child,
                      );
                    },
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ConsultaConteudoView()),
                    );
                  },
                  child: Text(
                    "Iniciar Consulta",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

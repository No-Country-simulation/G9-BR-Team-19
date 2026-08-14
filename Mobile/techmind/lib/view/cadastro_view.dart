import 'package:flutter/material.dart';
import 'package:techmind/shared/widgets/botao_form.dart';
import 'package:techmind/shared/widgets/input_form.dart';

class CadastroView extends StatelessWidget {
  CadastroView({super.key});

  final TextEditingController ctlLogin = TextEditingController();
  final TextEditingController ctlEmail = TextEditingController();
  final TextEditingController ctlSenha = TextEditingController();
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
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cadastrar",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Já possui um conta?",
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Entrar"),
                    ),
                  ],
                ),
                InputForm(
                  controller: ctlLogin,
                  label: "Nome do usuário",
                  icon: Icon(Icons.people, color: Colors.white),
                ),
                InputForm(
                  controller: ctlEmail,
                  label: "E-mail",
                  icon: Icon(Icons.email_outlined, color: Colors.white),
                ),
                InputForm(
                  controller: ctlSenha,
                  label: "Senha",
                  obscureText: true,
                  icon: Icon(Icons.lock, color: Colors.white),
                ),
                const SizedBox(height: 12),
                BotaoForm(
                  label: "Cadastrar",
                  onPressed: () {},
                  gradient1: const Color(0xFF000EA7),
                  gradient2: const Color(0xFF000541),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

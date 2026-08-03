import 'package:flutter/material.dart';
import 'package:techmind/shared/widgets/botao_form.dart';
import 'package:techmind/shared/widgets/input_form.dart';
import 'package:techmind/view/consulta_conteudo_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController ctlLogin = TextEditingController();
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
                  "Entrar",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Ainda não possui um conta?",
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    TextButton(onPressed: () {}, child: Text("Cadastrar-se")),
                  ],
                ),
                InputForm(
                  controller: ctlLogin,
                  label: "Nome do usuário ou Email",
                  icon: Icon(Icons.people, color: Colors.white),
                ),
                InputForm(
                  controller: ctlSenha,
                  label: "Senha",
                  obscureText: true,
                  icon: Icon(Icons.lock, color: Colors.white),
                ),
                const SizedBox(height: 12),
                BotaoForm(
                  label: "Login",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ConsultaConteudoView()),
                    );
                  },
                  gradient1: Color(0xFF000EA7),
                  gradient2: Color(0xFF000541),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

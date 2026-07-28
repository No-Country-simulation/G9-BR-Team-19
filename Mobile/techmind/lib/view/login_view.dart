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
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Entrar",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    "Ainda não possui um conta?",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                  TextButton(onPressed: () {}, child: Text("Cadastrar-se")),
                ],
              ),
              InputForm(
                controller: ctlLogin,
                label: "Nome do usuário ou Email",
                icon: Icon(Icons.people),
              ),
              InputForm(
                controller: ctlSenha,
                label: "Senha",
                icon: Icon(Icons.lock),
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
                gradient1: Color(0xff270551),
                gradient2: Color(0xff4515A3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:techmind/view/landpage_page.dart';
import 'package:techmind/viewmodels/consulta_conteudo_viewmodels.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ConsultaConteudoViewmodels(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Mind',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Landpage(),
    );
  }
}

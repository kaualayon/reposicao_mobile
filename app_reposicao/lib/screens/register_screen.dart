import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register(BuildContext context) async {
    bool success = await ApiService.registerUser(
      emailController.text,
      passwordController.text,
    );
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuário cadastrado!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro no cadastro.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Senha")),
            ElevatedButton(onPressed: () => register(context), child: Text("Cadastrar"))
          ],
        ),
      ),
    );
  }
}

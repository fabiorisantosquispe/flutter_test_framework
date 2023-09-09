import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorText = '';
  bool _showError = false;
  final Key title = const Key('title_key');
  final Key cpfKey = const Key('cpf_key');
  final Key passwordKey = const Key('password_key');
  final Key loginButtonKey = const Key('login_button');
  final Key clearButtonKey = const Key('clear_button');
  final Key forgotPasswordKey = const Key('forgot_password');
  final Key logoutButtonKey = const Key('logout_button');
  final Key loginSuccessBody = const Key('login_success_body');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', key: title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                key: cpfKey,
                controller: _cpfController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  semanticLabel: 'Campo de CPF'
                ),
              ),
              TextField(
                key: passwordKey,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  semanticLabel: 'Campo de senha'),
              ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: _showError,
                child: Text(
                  _errorText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                key: loginButtonKey,
                semanticLabel: 'Entrar',
                onPressed: () {
                  final cpf = _cpfController.text;
                  final password = _passwordController.text;

                  if (cpf == '27696205099' && password == '1234') {
                    // Login bem-sucedido, navegue para a segunda tela.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(),
                      ),
                    );
                  } else {
                    setState(() {
                      _errorText = 'CPF ou senha incorretos.';
                      _showError = true;
                    });
                  }
                },
                child: const Icon(Icons.login),
              ),
              ElevatedButton(
                key: clearButtonKey,
                onPressed: () {
                  // Limpar campos
                  _cpfController.clear();
                  _passwordController.clear();
                  setState(() {
                    _errorText = '';
                    _showError = false;
                  });
                },
                child: const Icon(Icons.clear),
                semanticLabel: 'Limpar campos',
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Esqueci a Senha', key: title),
                        content: const Text(
                            'Entre em contato com o administrador para redefinir sua senha.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Fechar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Esqueci a senha',
                  key: forgotPasswordKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Efetuado com Sucesso', key: title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout, 
              key: logoutButtonKey
              semanticLabel: 'Sair'),
            onPressed: () {
              // Navegue de volta à tela de login.
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: const Center(
        key: loginSuccessBody,
        child: Text('Bem-vindo à sua conta!'),
      ),
    );
  }
}

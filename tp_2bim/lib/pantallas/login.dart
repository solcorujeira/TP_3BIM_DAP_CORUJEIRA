import 'package:flutter/material.dart';
import 'package:tp_2bim/pantallas/lista.dart';

class Usuario {
  String username;
  String mail;
  String password;

  Usuario(this.username, this.mail, this.password);
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  String mensaje = '';

  List<Usuario> usuarios = [
    Usuario("Sol", "sol@gmail.com", "1234"),
    Usuario("Pablo", "juan@gmail.com", "abcd"),
    Usuario("Mia", "mia@gmail.com", "hola"),
    Usuario("Messi", "messi@gmail.com", "meencantaelfulbo"),
    Usuario("Antonio", "antonio@gmail.com", "cambridge"),
    Usuario("Trueno", "trueno@gmail.com", "comuna4"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Usuario",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 220,
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Mail",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 220,
                child: TextField(
                  controller: mailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Contraseña",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 220,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              ElevatedButton(
                onPressed: () {

                  String username = usernameController.text;
                  String password = passwordController.text;
                  String mail = mailController.text;

                  if (username.isEmpty ||
                      password.isEmpty ||
                      mail.isEmpty) {

                    mensaje = "Complete todos los campos";

                  } else {

                    bool encontrado = false;

                    for (Usuario usuario in usuarios) {

                      if (usuario.username == username &&
                          usuario.password == password &&
                          usuario.mail == mail) {

                        encontrado = true;
                        break;
                      }
                    }

                    if (encontrado) {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Lista(),
                        ),
                      );

                      return;

                    } else {

                      mensaje = "Usuario o contraseña incorrectos";
                    }
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(mensaje),
                    ),
                  );
                },
                child: const Text("Ingresar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
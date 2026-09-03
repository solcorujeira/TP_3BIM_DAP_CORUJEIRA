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
  TextEditingController confirmarPasswordController =
      TextEditingController();
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
    String username = '';
    String password = '';
    String confirmarPassword = '';
    String mail = '';

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'Usuario',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: 220,
              height: 45,
              child: TextField(
                controller: usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Ingrese su usuario",
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Mail',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: 220,
              height: 45,
              child: TextField(
                controller: mailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Ingrese su mail",
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Contraseña',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: 220,
              height: 45,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Ingrese su contraseña",
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Confirmar contraseña',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: 220,
              height: 45,
              child: TextField(
                controller: confirmarPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Repita su contraseña",
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            ElevatedButton(
              onPressed: () {
                username = usernameController.text;
                password = passwordController.text;
                confirmarPassword =
                    confirmarPasswordController.text;
                mail = mailController.text;

                setState(() {
                  if (username.isEmpty ||
                      password.isEmpty ||
                      confirmarPassword.isEmpty ||
                      mail.isEmpty) {
                    mensaje = "Complete todos los campos";

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          mensaje,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (password != confirmarPassword) {
                    mensaje = "Las contraseñas no coinciden";

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          mensaje,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    bool encontrado = false;

                    for (Usuario usuario in usuarios) {
                      if (username == usuario.username &&
                          password == usuario.password &&
                          mail == usuario.mail) {
                        encontrado = true;
                        break;
                      }
                    }

                    if (encontrado) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Lista(),
                        ),
                      );
                    } else {
                      mensaje =
                          "Usuario, mail o contraseña incorrectos";

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            mensaje,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                });
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 12,
                ),
              ),

              child: const Text(
                "Ingresar",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
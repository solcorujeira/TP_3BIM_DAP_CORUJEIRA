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
    String username = '';
    String password = '';
    String mail = '';

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                'Usuario',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 220,
                child: TextField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Ingrese su usuario",
                    hintStyle: TextStyle(color: Colors.white54),
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

              const SizedBox(height: 25),

              const Text(
                'Mail',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 220,
                child: TextField(
                  controller: mailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Ingrese su mail",
                    hintStyle: TextStyle(color: Colors.white54),
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

              const SizedBox(height: 25),

              const Text(
                'Contraseña',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 220,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Ingrese su contraseña",
                    hintStyle: TextStyle(color: Colors.white54),
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

              const SizedBox(height: 35),

              ElevatedButton(
                onPressed: () {

                  username = usernameController.text;
                  password = passwordController.text;
                  mail = mailController.text;

                  setState(() {

                    if (username.isEmpty ||
                        password.isEmpty ||
                        mail.isEmpty) {

                      mensaje = "Complete todos los campos";

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

                        mensaje = "Usuario, mail o contraseña incorrectos";

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              mensaje,
                              style: const TextStyle(color: Colors.white),
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
                    vertical: 15,
                  ),
                ),

                child: const Text(
                  "Ingresar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
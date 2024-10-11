import 'package:flutter/material.dart';
import 'package:trilhaapp/Page/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  var senhaController = TextEditingController(text: "");
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Image.network(
                          "https://hermes.digitalinnovation.one/assets/diome/logo.png"),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Já tem o Cadastro?",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Faça seu login e Make The Change_",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  alignment: Alignment.center,
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(Icons.person,
                                    color: Color.fromARGB(225, 90, 16, 101)))),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(height: 15),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    height: 30,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: TextField(
                                obscureText: isObscureText,
                                controller: senhaController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 0),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              225, 90, 16, 101))),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(225, 90, 16, 101)),
                                  ),
                                  hintText: "Senha",
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Color.fromARGB(225, 90, 16, 101)),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscureText = !isObscureText;
                                      });
                                    },
                                    child: Icon(
                                        isObscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color.fromARGB(
                                            225, 90, 16, 101)),
                                  ),
                                )))
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                          );
                          if (emailController.text.trim() ==
                                  "guipaiter@email.com" &&
                              senhaController.text.trim() == "123") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Erro ao efetuar um login!")));
                          }
                          debugPrint(emailController.text);
                          debugPrint(senhaController.text);
                        },
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromARGB(225, 90, 16, 101))),
                        child: const Text("ENTRAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400))),
                  ),
                ),
                Expanded(child: Container()),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text("Esqueci minha senha!",
                      style: TextStyle(
                          color: Colors.yellow, fontWeight: FontWeight.w400)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text("Criar Conta!",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w400)),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ));
  }
}

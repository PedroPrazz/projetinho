import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetinho/src/auth/sign_up_screen.dart';
import 'package:projetinho/src/config/custom_colors.dart';
import '../../api/service/getFindbyIDService.dart';
import '../../api/service/loginService.dart';
import 'components/custom_text_field.dart';
import 'homePage.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/logobranca.png'),
                    // Text.rich(
                    //   TextSpan(
                    //     style: const TextStyle(
                    //       fontSize: 40,
                    //     ),
                    //     children: [
                    //       const TextSpan(
                    //         text: 'Prognosti',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: 'Care',
                    //         style: TextStyle(
                    //           color: Colors.pink,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    //   child: DefaultTextStyle(
                    //     style: const TextStyle(
                    //       fontSize: 25,
                    //     ),
                    //     child: AnimatedTextKit(
                    //       pause: Duration.zero,
                    //       repeatForever: true,
                    //       animatedTexts: [
                    //         FadeAnimatedText('Conectando-se com o futuro da sua Saúde'),
                    //         FadeAnimatedText('Exames'),
                    //         FadeAnimatedText('Prontuários'),
                    //         FadeAnimatedText('Consultas'),
                    //         FadeAnimatedText('Agendamentos'),
                    //         FadeAnimatedText('Vacinas'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: (email) {
                          if (email == null || email.isEmpty)
                            return 'Digite seu email!';

                          if (email.isEmail) return 'Digite um email válido!';

                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (senha) {
                          if (senha == null || senha.isEmpty) {
                            return 'Digite sua senha!';
                          }
                          if (senha.length < 8) {
                            return 'Digite uma senha com pelo menos 7 caracteres.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () async {
                            bool loggedIn = await LoginService.getLogin(
                                emailController.text, passwordController.text);
                            if (_formKey.currentState!.validate()) {
                              print('Todos os campos estão válidos');
                            } else {
                              print('Campos não válidos');
                            }
                            if (loggedIn) {
                              if (passwordController.text == 'abcdefgh') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                                GetFindbyIDService.getFindbyID();
                              }
                            } else {
                              print(
                                  'Seu email e senha não correspondem. Tente novamente!');
                            }
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {},
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.pink,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (c) {
                                return SignUpScreen();
                              }),
                            );
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
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

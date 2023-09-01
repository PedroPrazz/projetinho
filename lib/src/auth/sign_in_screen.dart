import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:projetinho/src/config/custom_colors.dart';
import '../../api/service/getFindbyIDService.dart';
import '../../api/service/loginService.dart';
import 'components/custom_text_field.dart';
import 'homePage.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Prognosti',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Care',
                        style: TextStyle(
                          color: Colors.pink,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                    child: AnimatedTextKit(
                      pause: Duration.zero,
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText('Conectando-se com o futuro da sua Saúde'),
                        FadeAnimatedText('Exames'),
                        FadeAnimatedText('Prontuários'),
                        FadeAnimatedText('Consultas'),
                        FadeAnimatedText('Agendamentos'),
                        FadeAnimatedText('Vacinas'),
                      ],
                    ),
                  ),
                ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: emailController,
                  icon: Icons.email,
                  label: 'Email',
                ),
                CustomTextField(
                  controller: passwordController,
                  icon: Icons.lock,
                  label: 'Senha',
                  isSecret: true,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async{
                      bool loggedIn = await LoginService.getLogin(emailController.text, passwordController.text);
                      if (loggedIn) {
                    if (passwordController.text == 'abcdefgh') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      GetFindbyIDService.getFindbyID();
                    }
                  } else {
                    print('Seu email e senha não correspondem. Tente novamente!');
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
                    onPressed: () async{
                  //     bool loggedIn = await LoginService.getLogin(_email.text, _password.text);
                  //     if (loggedIn) {
                  //   if (_password.text == 'abcdefgh') {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  //   } else {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  //     GetFindbyIDService.getFindbyID();
                  //   }
                  // } else {
                  //   print('Seu email e senha não correspondem. Tente novamente!');
                  // }
                    },
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
                    onPressed: () {},
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
        ],
      ),
    );
  }
}

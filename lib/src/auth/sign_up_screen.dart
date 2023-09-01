import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projetinho/src/auth/components/custom_text_field.dart';
import 'package:projetinho/src/config/custom_colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final cpfFormartter = MaskTextInputFormatter(
    mask: '###-#####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final dataFormartter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-8]')},
  );

  // final phoneFormartter = MaskTextInputFormatter(
  //   mask: '###.###.###-##',
  //   filter: {'#': RegExp( r'[0-9]')},
  // );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
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
                            icon: Icons.file_copy,
                            label: 'CPF',
                            inputFormatters: [cpfFormartter],
                          ),
                          CustomTextField(
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
                            icon: Icons.date_range,
                            label: 'Data de Nascimento',
                            inputFormatters: [dataFormartter],
                          ),
                          CustomTextField(
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
                          const CustomTextField(
                            icon: Icons.lock,
                            label: 'Confirmar Senha',
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
                              onPressed: () {

                                if(_formKey.currentState!.validate()){
                                  print('Todos os campos estão válidos');
                                }else{
                                  print('Campos não válidos');
                                }
                              },
                              child: const Text(
                                'Cadastrar',
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
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
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

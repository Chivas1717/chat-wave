import 'package:clean_architecture_template/core/helper/validators.dart';
import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/style/text_styles.dart';
import 'package:clean_architecture_template/core/widgets/buttons/primary_button.dart';
import 'package:clean_architecture_template/core/widgets/text_fields/outlined_text_field.dart';
import 'package:clean_architecture_template/core/widgets/transitions/transitions.dart';
import 'package:clean_architecture_template/features/auth/presentation/widgets/auth_screens_template.dart';
import 'package:clean_architecture_template/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:clean_architecture_template/features/chats/presentation/screens/main_chats_screen.dart';
import 'package:flutter/material.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showNameError = false;
  String errorMessage = '';

  bool nameValid = false;
  final TextEditingController codeController = TextEditingController();

  bool get activeButton => nameValid;
  @override
  Widget build(BuildContext context) {
    return AuthScreensTemplate(
      appBar: const CustomAppBar(
        title: 'Авторизація',
      ),
      floatingButton: PrimaryButton(
        active: activeButton,
        title: 'Підтвердити',
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            FadePageTransition(
              child: const MainChatsScreen(),
            ),
            (route) => false,
          );
          // signInCubit.signIn(
          //   SignInInfo(
          //     email: emailController.value.text,
          //     password: passwordController.value.text,
          //   ),
          // );
        },
      ),
      screenTitle: 'Введіть ваш телефон',
      children: [
        const SizedBox(height: 30),
        Center(
          child: Text(
            'Останній крок!',
            textAlign: TextAlign.center,
            style: CTextStyle.titleExtraLarge.copyWith(color: CColors.white),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: Text(
            'Введіть ваше імʼя нижче',
            style: CTextStyle.titleMedium.copyWith(color: CColors.white),
          ),
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            children: [
              BasicOutlinedTextField(
                validator: (value) {
                  if (showNameError) {
                    return errorMessage;
                  } else {
                    return null;
                  }
                },
                controller: codeController,
                hint: '',
                label: 'Імʼя',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    nameValid = NameValidator.isValid(value);
                    showNameError = false;
                    errorMessage = '';
                    _formKey.currentState!.validate();
                  });
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

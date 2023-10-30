import 'package:clean_architecture_template/core/helper/validators.dart';
import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/style/text_styles.dart';
import 'package:clean_architecture_template/core/widgets/buttons/primary_button.dart';
import 'package:clean_architecture_template/core/widgets/text_fields/outlined_text_field.dart';
import 'package:clean_architecture_template/core/widgets/transitions/transitions.dart';
import 'package:clean_architecture_template/features/auth/presentation/screens/enter_name_screen.dart';
import 'package:clean_architecture_template/features/auth/presentation/widgets/auth_screens_template.dart';
import 'package:clean_architecture_template/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showCodeError = false;
  String errorMessage = '';

  bool codeValid = false;
  final TextEditingController codeController = TextEditingController();

  bool get activeButton => codeValid;
  @override
  Widget build(BuildContext context) {
    return AuthScreensTemplate(
      appBar: CustomAppBar(
        title: 'Авторизація',
      ),
      floatingButton: PrimaryButton(
        active: activeButton,
        title: 'Підтвердити',
        onTap: () {
          Navigator.of(context).push(
            FadePageTransition(child: const EnterNameScreen()),
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
            'Вам було надіслано код підтвердження!',
            textAlign: TextAlign.center,
            style: CTextStyle.titleExtraLarge.copyWith(color: CColors.white),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: Text(
            'Введіть код нижче',
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
                  if (showCodeError) {
                    return errorMessage;
                  } else {
                    return null;
                  }
                },
                controller: codeController,
                hint: '',
                label: 'Код підтвердження',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    codeValid = OtpValidator.isValid(value);
                    showCodeError = false;
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

import 'package:clean_architecture_template/core/helper/validators.dart';
import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/style/text_styles.dart';
import 'package:clean_architecture_template/core/widgets/buttons/primary_button.dart';
import 'package:clean_architecture_template/core/widgets/text_fields/outlined_text_field.dart';
import 'package:clean_architecture_template/core/widgets/transitions/transitions.dart';
import 'package:clean_architecture_template/features/auth/presentation/blocs/send_otp_cubit/send_otp_cubit.dart';
import 'package:clean_architecture_template/features/auth/presentation/screens/enter_otp_screen.dart';
import 'package:clean_architecture_template/features/auth/presentation/widgets/auth_screens_template.dart';
import 'package:clean_architecture_template/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({super.key});

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  late final SendOtpCubit sendOtpCubit;
  final _formKey = GlobalKey<FormState>();

  bool showPhoneError = false;
  String errorMessage = '';

  bool phoneValid = false;
  final TextEditingController phoneController = TextEditingController();

  bool get activeButton => phoneValid;

  @override
  void initState() {
    sendOtpCubit = sl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendOtpCubit, SendOtpState>(
        bloc: sendOtpCubit,
        listener: (context, state) {
          print(state);
          if (state is OtpSuccess) {
            Navigator.of(context).push(
              FadePageTransition(
                child: EnterOtpScreen(
                  phoneNumber: phoneController.text,
                ),
              ),
            );
          } else if (state is OtpFailure) {
            setState(() {
              errorMessage = state.errorMessage;
              showPhoneError = true;
              _formKey.currentState!.validate();
            });
          }
        },
        builder: (context, state) {
          return AuthScreensTemplate(
            appBar: const CustomAppBar(
              title: 'Авторизація',
            ),
            floatingButton: PrimaryButton(
              active: activeButton,
              title: 'Надіслати код',
              onTap: () {
                sendOtpCubit.sendOtp(phoneController.text);
              },
            ),
            screenTitle: 'Введіть ваш телефон',
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Вітаємо!',
                  style:
                      CTextStyle.titleExtraLarge.copyWith(color: CColors.white),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'Введіть ваш номер телефону нижче',
                  style: CTextStyle.titleMedium.copyWith(color: CColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    BasicOutlinedTextField(
                      validator: (value) {
                        if (showPhoneError) {
                          return errorMessage;
                        } else {
                          return null;
                        }
                      },
                      controller: phoneController,
                      hint: '',
                      label: 'Номер телефону',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          phoneValid = PhoneValidator.isValid(value);
                          showPhoneError = false;
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
        });
  }
}

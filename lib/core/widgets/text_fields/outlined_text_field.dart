import 'package:clean_architecture_template/core/helper/images.dart';
import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/style/text_styles.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicOutlinedTextField extends StatefulWidget {
  const BasicOutlinedTextField({
    required this.hint,
    this.controller,
    this.initialValue,
    this.label,
    this.inputFormatters,
    this.keyboardType,
    this.prefix,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.floatingLabelBehavior,
    this.autocorrect = false,
    this.obscure = false,
    this.showObscureSwitch = false,
    this.isPhoneNumber = false,
    this.enabled = true,
    this.focusNode,
    this.restorationId,
    this.maxLenght,
    this.showCounter = false,
    this.autovalidateMode,
    this.fieldKey,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hint;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool autocorrect;
  final bool obscure;
  final bool showObscureSwitch;
  final bool isPhoneNumber;
  final bool enabled;
  final FocusNode? focusNode;
  final String? restorationId;
  final int? maxLenght;
  final bool showCounter;
  final AutovalidateMode? autovalidateMode;
  final GlobalKey<FormFieldState>? fieldKey;

  @override
  State<StatefulWidget> createState() => _BasicOutlinedTextFieldState();
}

class _BasicOutlinedTextFieldState extends State<BasicOutlinedTextField> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.obscure || widget.showObscureSwitch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          autovalidateMode: widget.autovalidateMode,
          key: widget.fieldKey,
          restorationId: widget.restorationId,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          maxLength: widget.maxLenght,
          enableSuggestions: false,
          initialValue: widget.initialValue,
          controller: widget.controller,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          onChanged: widget.onChanged,
          autocorrect: widget.autocorrect,
          obscureText: _obscure,
          cursorColor: CColors.white,
          cursorWidth: 1,
          cursorHeight: 24,
          buildCounter: widget.showCounter
              ? null
              : (context,
                      {required currentLength,
                      required isFocused,
                      maxLength}) =>
                  const SizedBox.shrink(),
          style: CTextStyle.bodyLarge.copyWith(
            color: widget.enabled ? CColors.white : CColors.white,
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: widget.floatingLabelBehavior,
            hintText: widget.hint,
            errorMaxLines: 2,
            hintStyle: CTextStyle.bodyLarge.copyWith(color: CColors.grey),
            labelText: widget.label,
            labelStyle: CTextStyle.bodyLarge.copyWith(color: CColors.white),
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: CColors.white),
                borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: CColors.white),
                borderRadius: BorderRadius.circular(100)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: CColors.error),
                borderRadius: BorderRadius.circular(100)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: CColors.error),
                borderRadius: BorderRadius.circular(100)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: CColors.white),
                borderRadius: BorderRadius.circular(100)),
            prefixIcon: widget.prefix,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            suffix:
                widget.showObscureSwitch ? const SizedBox(width: 40.0) : null,
            prefixIconConstraints: widget.isPhoneNumber
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
          ),
        ),
        if (widget.showObscureSwitch)
          Positioned(
            top: _obscure ? 21.5 : 20,
            right: 18,
            child: ExpandTapWidget(
              tapPadding: const EdgeInsets.all(20),
              onTap: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
              child: SvgPicture.asset(
                _obscure ? SvgIcons.eye : SvgIcons.eyeCrossed,
                color: _obscure ? CColors.green : CColors.grey,
                width: 18.0,
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isObscure;
  final TextInputType? inputType;
  final bool isFinalField;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int? maxLength;
  final bool readOnly;
  final TextAlign textAlign;
  final TextStyle? valueTextStyle;
  final TextStyle? hintTextStyle;
  final String? hintText;
  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscure = false,
    this.inputType,
    this.isFinalField = false,
    this.validator,
    this.onSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.focusNode,
    this.nextFocusNode,
    this.maxLength,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.valueTextStyle,
    this.hintTextStyle,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isObscure,
      keyboardType: inputType,
      readOnly: readOnly,
      textAlign: textAlign,
      onChanged: onChanged,
      inputFormatters:
          inputFormatters ??
          [
            if (TextInputType.number == inputType ||
                TextInputType.phone == inputType)
              FilteringTextInputFormatter.digitsOnly,
            if (TextInputType.name == inputType)
              FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s.'-]")),
            if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
          ],
      textInputAction: isFinalField
          ? TextInputAction.done
          : TextInputAction.next,
      style: valueTextStyle ?? Theme.of(context).textTheme.bodyMedium,
      validator: validator,
      onFieldSubmitted: (value) {
        if (isFinalField) {
          focusNode?.unfocus();
        } else {
          nextFocusNode?.requestFocus();
        }
        if (onSubmitted != null) {
          onSubmitted!(value);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText ?? label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: "",
        hintStyle: hintTextStyle,
      ),
    );
  }
}

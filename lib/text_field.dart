import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class GlobalTextField extends StatelessWidget {
  final String attribute, initialVal, label;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Brightness brightness;

  final Color fillColor, textFieldColor;
  final bool isDense, autoFocus, isPassWord, obscure;
  final FormFieldValidator<String> validators;

  final TextEditingController tec;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final int maxLength, maxLines, minLines;
  final ValueChanged changed;
  final Function showPass, hidePass;
  final Function(String) submit;
  final AutovalidateMode autoValidateMode;
  final InputDecorationTheme decoration;

  const GlobalTextField({
    Key key,
    this.attribute,
    this.initialVal,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.isDense,
    this.autoFocus,
    this.isPassWord = false,
    this.obscure = true,
    this.validators,
    this.tec,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.changed,
    this.showPass,
    this.hidePass,
    this.submit,
    this.brightness = Brightness.light,
    this.textFieldColor,
    this.autoValidateMode,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          textTheme: context.textTheme,
          brightness: brightness,
          hintColor: textFieldColor != null
              ? textFieldColor
              : brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
          fixTextFieldOutlineLabel: true,
          hoverColor: Theme.of(context).primaryColor.withOpacity(.2),
          focusColor: Theme.of(context).primaryColor.withOpacity(.2),
          splashColor: Theme.of(context).primaryColor.withOpacity(.2),
          highlightColor: Theme.of(context).primaryColor.withOpacity(.2),
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
          accentColor: context.theme.accentColor,
          inputDecorationTheme: decoration.copyWith(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: textFieldColor != null
                    ? textFieldColor
                    : brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
        child: FormBuilderTextField(
          autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
          name: attribute,
          autofocus: autoFocus ?? false,
          controller: tec ?? null,
          focusNode: focusNode,
          initialValue: initialVal ?? null,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          buildCounter: (BuildContext context,
              {int currentLength, int maxLength, bool isFocused}) {
            if (maxLength != null && maxLength >= 0) {
              return AnimatedOpacity(
                opacity: isFocused ? 1 : 0,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInCubic,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  height: isFocused ? 15 : 0,
                  child: Text(
                    '$currentLength/$maxLength ',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: context.theme.primaryColor,
                    ),
                  ),
                ),
              );
            } else {
              return null;
            }
          },
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          obscureText: isPassWord ? obscure : false,
          onChanged: changed,
          onSubmitted: submit,
          validator: validators,
          style: TextStyle(
              color: textFieldColor != null
                  ? textFieldColor
                  : brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
              letterSpacing: 1),
          decoration: inputDeco(
            hidePass: hidePass,
            isDense: isDense,
            isPassWord: isPassWord,
            label: label,
            obscure: obscure,
            prefixIcon: prefixIcon,
            showPass: showPass,
            suffixIcon: suffixIcon,
            brightness: brightness,
            textFieldColor: textFieldColor,
          ),
        ));
  }
}

InputDecoration inputDeco({
  bool isPassWord = false,
  bool isDense = false,
  String label,
  Function showPass,
  Function hidePass,
  bool obscure = true,
  Widget suffixIcon,
  Widget prefixIcon,
  Color textFieldColor,
  Brightness brightness = Brightness.light,
}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: textFieldColor != null
            ? textFieldColor
            : brightness == Brightness.light
                ? Colors.black
                : Colors.white,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: textFieldColor != null
            ? textFieldColor
            : brightness == Brightness.light
                ? Colors.black
                : Colors.white,
        width: 2,
      ),
    ),
    labelText: isPassWord ? label ?? 'Password' : label,
    isDense: isDense ?? true,
    suffixIcon: isPassWord
        ? AnimatedCrossFade(
            firstChild: Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                icon: Icon(Icons.visibility),
                iconSize: 28,
                onPressed: showPass,
              ),
            ),
            secondChild: Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                icon: Icon(Icons.visibility_off),
                onPressed: hidePass,
                iconSize: 28,
              ),
            ),
            duration: 200.milliseconds,
            crossFadeState:
                obscure ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          )
        : suffixIcon,
    prefixIcon: isPassWord
        ? Icon(
            Icons.lock_outlined,
            size: 28,
          )
        : prefixIcon,
    filled: true,
    fillColor: Colors.white10,
  );
}

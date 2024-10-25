import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  // Controller and Callbacks
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? validator;
  final VoidCallback? function;

  // Text and Style
  final String hintText;
  final bool isCapital;
  final bool? isAllCapital;
  final bool isShowCounter;
  final bool isPhoneNo;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final int? maxLines;
  final bool? obSecure;
  final bool readOnly;
  final bool isEnabled;
  final bool showLabel;

  // Icons and Prefixes
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? countryCode;
  final String? phoneNoPrefixString;

  // Appearance
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? height;
  final bool? isBold;
  final bool isExpandable;

  // Focus and Scrolling
  final FocusNode? focusNode;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;

  // Autofill
  final Iterable<String>? autofillHints;

  // Phone Number
  final String? countryName;

  const CustomTextField({
    this.controller,
    this.onChange,
    this.validator,
    this.function,
    this.hintText = "",
    this.isCapital = false,
    this.isAllCapital = false,
    this.isShowCounter = false,
    this.isPhoneNo = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
    this.maxLines = 1,
    this.obSecure,
    this.readOnly = false,
    this.isEnabled = true,
    this.showLabel = false,
    this.prefixIcon,
    this.suffixIcon,
    this.countryCode,
    this.phoneNoPrefixString,
    this.color,
    this.textColor,
    this.borderColor,
    this.radius,
    this.height,
    this.isBold = false,
    this.isExpandable = false,
    this.focusNode,
    this.scrollPhysics,
    this.scrollController,
    this.countryName,
    this.autofillHints,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorMessage;
  bool shouldFormat = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: widget.autofillHints,
      enabled: widget.isEnabled,
      smartQuotesType: SmartQuotesType.disabled,
      textCapitalization: (widget.isAllCapital!)
          ? TextCapitalization.characters
          : (widget.isCapital)
              ? TextCapitalization.sentences
              : TextCapitalization.none,
      focusNode: widget.focusNode,
      scrollPhysics: widget.scrollPhysics,
      scrollController: widget.scrollController,
      maxLines: widget.maxLines,
      obscureText: widget.obSecure ?? false,
      controller: widget.controller,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: (widget.isBold!) ? FontWeight.bold : FontWeight.normal,
          ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      /* cursorColor: (widget.isLight!)
          ? CustomColor.text.value
          : CustomColor.textFieldText.value, */ // changethis
      onTap: widget.function,
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
        if (widget.isPhoneNo) {
          setState(() {
            if (widget.controller != null &&
                widget.controller!.text.length > 2) {
              shouldFormat = true;
            } else {
              shouldFormat = false;
            }
          });
        }
      },
      validator: (value) {
        setState(() {
          errorMessage = widget.validator!(value!);
          // return ' ';
        });
        return widget.validator!(value!);
      },
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: widget.isExpandable || errorMessage != null
              ? 65
              : ((widget.height != null) ? widget.height : 40)!,
        ),
        enabled: true,
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.red,
            ),
        errorMaxLines: 10,
        hoverColor: Theme.of(context).highlightColor,
        contentPadding: widget.maxLines != 1
            ? const EdgeInsets.only(top: 20)
            : const EdgeInsets.all(5),
        filled: true,
        counterText: widget.isShowCounter ? null : "",
        fillColor: widget.isEnabled
            ? widget.color ?? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        // fillColor: Colors.red,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 25),
          borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 25),
          borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 25),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 25),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 25),
          borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 25),
          borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
        ),
        // focusColor: CustomColor.lightThemeColor,
        hintText: widget.hintText,

        hintStyle: Theme.of(context).textTheme.bodyMedium,
        prefixIconConstraints: BoxConstraints(
          maxWidth: widget.isPhoneNo ? 120 : 100,
        ),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        prefix: Padding(
          padding: (widget.maxLines == 1)
              ? const EdgeInsets.only(left: 10)
              : const EdgeInsets.all(10),
        ),
      ),
    );
  }
}

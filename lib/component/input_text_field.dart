import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
  // Properties for customization
  final String? Function(String?)?
      validation; // Validation function for the input
  final Function()? onEditComplete; // Callback when editing is complete
  final TextEditingController?
      textEditingController; // Controller for the input text
  final String hint; // Hint text for the input
  final TextInputType? textInputType; // Type of keyboard input
  final List<TextInputFormatter>? inputFormatters; // List of input formatters
  final bool enable; // Enable or disable the input
  final String title; // Label for the input
  final String? initialValue; // Initial value for the input
  final bool
      obsecureText; // Whether the input should be obscured (e.g., for passwords)
  final TextAlign textAlign; // Text alignment within the input field
  final TextInputAction
      textInputAction; // Action to take on pressing the keyboard's action button
  final Function(String val)? onChange; // Callback for value change
  final double? width; // Width of the input field
  final double? height; // Height of the input field

  // Constructor to initialize the properties
  const InputTextField({
    Key? key,
    this.width,
    this.height,
    this.validation,
    this.textEditingController,
    this.hint = "",
    this.onChange,
    this.textInputType,
    required this.title,
    this.inputFormatters,
    this.enable = true,
    this.initialValue,
    this.obsecureText = false,
    this.textAlign = TextAlign.left,
    this.onEditComplete,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isVisible = false; // Toggle for password visibility

  @override
  void initState() {
    _isVisible = widget
        .obsecureText; // Initialize visibility based on the obsecureText property
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Return a SizedBox containing a TextFormField with specific styling and functionality
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        controller: widget.textEditingController,
        initialValue: widget.initialValue,
        validator: widget.validation ??
            (val) {
              return null; // Default validation returns no error
            },
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        enabled: widget.enable,
        onChanged: (val) {
          // Execute the onChange callback if provided
          if (widget.onChange != null) {
            widget.onChange!(val);
          }
        },
        onEditingComplete: widget.onEditComplete,
        obscureText: _isVisible,
        style:
            const TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
        textAlign: widget.textAlign,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.title,
          labelStyle: const TextStyle(color: Colors.black54),
          suffixIcon: widget.obsecureText
              ? GestureDetector(
                  child: _isVisible
                      ? const Icon(
                          Icons.visibility_off,
                          size: 18,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility,
                          size: 18,
                          color: Colors.grey,
                        ),
                  onTap: () => setState(() {
                    _isVisible = !_isVisible; // Toggle password visibility
                  }),
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          hintStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
        ),
      ),
    );
  }
}

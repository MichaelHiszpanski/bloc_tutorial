import 'package:bloc_tutorial/sign_in_app/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<String>? errorMessages;

  const CustomTextInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Pallete.borderColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Pallete.gradient2,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: hintText,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.shade700,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.shade700,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        if (errorMessages != null && errorMessages!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: errorMessages!
                  .map(
                    (error) => Text(
                      error,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 12,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}

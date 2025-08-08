import 'package:flutter/cupertino.dart';
import 'package:range_visualizer_app/logic/notifiers.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  int? input;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: CupertinoTextField(
            padding: const EdgeInsets.all(16.0),
            keyboardType: TextInputType.number,
            placeholder: 'Enter a range',
            onChanged: (value) => input = int.tryParse(value),
            onSubmitted: (value) => Notifiers.input.value = int.tryParse(value),
          ),
        ),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 48.0,
          child: CupertinoButton.filled(
            onPressed: () => Notifiers.input.value = input,
            child: const Icon(CupertinoIcons.arrow_right),
          ),
        ),
      ],
    );
  }
}

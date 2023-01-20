import 'package:delayed_future/delayed_future.dart';
import 'package:flutter/material.dart';
import 'package:iosish_shaker/iosish_shaker.dart';
import 'package:pinput/pinput.dart';

class PinPage extends StatefulWidget {
  const PinPage({Key? key}) : super(key: key);

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  static const _baseDecoration = BoxDecoration(
    shape: BoxShape.circle,
    borderRadius: null,
  );
  static const _baseTheme = PinTheme(
    height: 12.0,
    width: 12.0,
    decoration: _baseDecoration,
  );

  final controller = TextEditingController();

  String? error;

  Color submittedColor = Colors.blue;

  bool showError = false;

  final shakeController = ShakerController();

  Future<void> verify(String pin) async {
    /// Pretending to fetch from local storage ...
    await Future.delayed(const Duration(milliseconds: 100));

    if (pin != '123456') {
      throw const FormatException();
    }
  }

  Future<void> onSubmitted(String pin) async {
    try {
      setState(() {
        // Making the pin go a bit lighter indicating that the pin is being validated.
        submittedColor = Colors.lightBlueAccent;
      });

      // Notice the delay 👇
      await verify(pin)
          .delayResult(duration: const Duration(milliseconds: 850));

      // If no exception — we're good!
      setState(() {
        submittedColor = Colors.lightGreen;
      });

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.of(context).pop();
      }
      // Navigate the user further ...
    } on Exception {
      shakeController.shake();

      setState(() {
        error = "Pin is incorrect.";
        showError = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      controller.text = '';
      setState(() {
        showError = false;
        submittedColor = Colors.blue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Pin Example')),
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Shaker(
              controller: shakeController,
              child: Pinput(
                showCursor: false,
                obscureText: true,
                forceErrorState: showError,
                onChanged: (value) {
                  if (showError) {
                    return;
                  }

                  if (error != null) {
                    setState(() {
                      error = null;
                    });
                  }
                },
                length: 6,
                controller: controller,
                obscuringWidget: const SizedBox(),
                onSubmitted: onSubmitted,
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                onCompleted: onSubmitted,
                focusedPinTheme: _baseTheme.copyDecorationWith(
                  color: Colors.blueGrey,
                ),
                errorPinTheme: _baseTheme.copyDecorationWith(
                  color: Colors.red,
                ),
                defaultPinTheme: _baseTheme.copyDecorationWith(
                  color: Colors.grey,
                ),
                submittedPinTheme: _baseTheme.copyDecorationWith(
                  color: submittedColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            error ?? '',
            style: const TextStyle(color: Colors.red),
          ),
          const Spacer(),
          MaterialButton(
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

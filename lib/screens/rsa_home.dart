import 'package:flutter/material.dart';
import 'package:rsa_cracking_app/utils/rsa_core.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class RsaHomeScreen extends StatefulWidget {
  const RsaHomeScreen({Key? key}) : super(key: key);

  @override
  State<RsaHomeScreen> createState() => _RsaHomeScreenState();
}

class _RsaHomeScreenState extends State<RsaHomeScreen> {
  final TextEditingController _encController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _encController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RSA"),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your message to be encrypted',
                  textInputType: TextInputType.text,
                  textEditingController: _encController,
                ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () {
                    rsa(_encController.text);
                  },
                  child: Container(
                    child: const Text(
                      'Encrypt',
                      style: TextStyle(color: Colors.white),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Encoded text",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    child: const Text(
                      'Decrypt',
                      style: TextStyle(color: Colors.white),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Decrypted text",
                  style: TextStyle(color: Colors.black),
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
              ],
            ),
          ),
        ));
  }
}

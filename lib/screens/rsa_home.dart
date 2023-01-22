import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:rsa_cracking_app/utils/rsa_core.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class RsaHomeScreen extends StatefulWidget {
  @override
  State<RsaHomeScreen> createState() => _RsaHomeScreenState();
}

class _RsaHomeScreenState extends State<RsaHomeScreen> {
  final TextEditingController _encController = TextEditingController();
  @override
  @override
  void dispose() {
    super.dispose();
    _encController.dispose();
  }

  String encText = '';
  String decText = '';
  @override
  Widget build(BuildContext context) {
    Future encrypt() async {
      final publicPem = await rootBundle.loadString('keys/public.pem');
      final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
      final privatePem = await rootBundle.loadString('keys/private.pem');
      final privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;

      final encrypter =
          Encrypter(RSA(publicKey: publicKey, privateKey: privKey));

      var encrypted = encrypter.encrypt(_encController.text);

      setState(() {
        encText = encrypted.base64.toString();
      });
    }

    Future decrypt() async {
      final publicPem = await rootBundle.loadString('keys/public.pem');
      final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
      final privatePem = await rootBundle.loadString('keys/private.pem');
      final privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;

      final encrypter =
          Encrypter(RSA(publicKey: publicKey, privateKey: privKey));

      final encrypted = encrypter.encrypt(_encController.text);
      final de = encrypter.decrypt(encrypted);
      setState(() {
        decText = de;
      });
    }

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
                  onPressed: () async {
                    await encrypt();
                    print(encText);
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
                  encText,
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () async {
                    await decrypt();
                    print(decText);
                  },
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
                  decText,
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

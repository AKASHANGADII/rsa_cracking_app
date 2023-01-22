import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RsaCore {
  Future<RSAPublicKey> getPublicKey() async {
    final publicPem = await rootBundle.loadString('keys/public.pem');
    final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
    return publicKey;
  }

  Future<RSAPrivateKey> getPrivateKey() async {
    final privatePem = await rootBundle.loadString('keys/private.pem');
    final privateKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;
    return privateKey;
  }

  enc(String text) {
    final encrypter = Encrypter(RSA(
        publicKey: getPublicKey() as RSAPublicKey,
        privateKey: getPrivateKey() as RSAPrivateKey));
    final enctext = encrypter.encrypt(text);
    return enctext.base64;
  }

  dec(String text) {
    final encrypter = Encrypter(RSA(
        publicKey: getPublicKey() as RSAPublicKey,
        privateKey: getPrivateKey() as RSAPrivateKey));
    final dectext = encrypter.decrypt(enc(text));
    return dectext;
  }
}

Future<void> rsa(String text) async {
  final publicPem = await rootBundle.loadString('keys/public.pem');
  final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
  final privatePem = await rootBundle.loadString('keys/private.pem');
  final privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;

  final plainText = text;
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));

  final encrypted = encrypter.encrypt(plainText);
  final decrypted = encrypter.decrypt(encrypted);

  print(encrypted.base64);
  print(decrypted);
}

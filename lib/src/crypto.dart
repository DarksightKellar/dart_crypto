
import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/export.dart';
import 'package:secp256k1/secp256k1.dart' as lib_secp256k1;
import 'package:convert/convert.dart';
import 'package:base58check/base58check.dart';

class Crypto {

  static const prefixP2pkh = 0;
  static const prefixP2sh = 5;

  static String sha256(String seed) {
    var sha256 = SHA256Digest();

    var bytesSeed = utf8.encode(seed);
    var bytesSha256 = sha256.process(Uint8List.fromList(bytesSeed)).toList();

    return hex.encode(bytesSha256);
  }

  static String secp256k1(String privateKey) {
    var pk = lib_secp256k1.PrivateKey.fromHex(privateKey);
    return pk.publicKey.toHex();
  }

  static String secp256k1Compressed(String privateKey) {
    var pk = lib_secp256k1.PrivateKey.fromHex(privateKey);
    return pk.publicKey.toCompressedHex();
  }
  
  static Uint8List sha256Ripemd160(String publicKey) {
    var sha256 = SHA256Digest();
    var ripemd160 = RIPEMD160Digest();

    var bytes = utf8.encode(publicKey);

    var bytesSha256 = sha256.process(Uint8List.fromList(bytes));
    return ripemd160.process(bytesSha256);
    
  }

  static String p2pkh(String publicKey) {
    var bytesRipemd160 = sha256Ripemd160(publicKey);
    
    var base58checkCodec = Base58CheckCodec.bitcoin();
    var base58PCheckPayload = Base58CheckPayload(prefixP2pkh, bytesRipemd160);

    return base58checkCodec.encode(base58PCheckPayload);
  }

  static String p2sh(String publicKey) {
    var bytesRipemd160 = sha256Ripemd160(publicKey);

    var base58checkCodec = Base58CheckCodec.bitcoin();
    var base58PCheckPayload = Base58CheckPayload(prefixP2sh, bytesRipemd160);

    return base58checkCodec.encode(base58PCheckPayload);
  }

  static Uint8List hmacBytes(String message, String secret, Digest digest, int blockLength) {
    var messageBytes = utf8.encode(message);
    var secretBytes = utf8.encode(secret);

    var hmac = HMac(digest, blockLength);
    hmac.init(KeyParameter(Uint8List.fromList(secretBytes)));

    return hmac.process(Uint8List.fromList(messageBytes));
  }

  static String hmacSha256(String message, String secret) {
    var bytesHmac = hmacBytes(message, secret, SHA256Digest(), 64);
    return hex.encode(bytesHmac);
  }

  static String hmacSha512(String message, String secret) {
    var bytesHmac = hmacBytes(message, secret, SHA512Digest(), 128);
    return hex.encode(bytesHmac);
  }

}
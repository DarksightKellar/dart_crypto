
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';

import '../../../dart_crypto.dart';

class HdCkdItem {

  late final int _index;
  late final String _path;
  late final String _privateKey;
  late final String _publicKey;
  late final String _chainCode;
  late final String _address;

  HdCkdItem.derivation(String parentPublicKey, String parentChainCode, int index, String path) {

    _index = index;
    _path = path;

    // TODO
    var hmac = HMac(SHA512Digest(), 128);
    var parentPublicKeyBits = Uint8List.fromList(utf8.encode(parentPublicKey));
    var parentChainCodeBits = Uint8List.fromList(utf8.encode(parentChainCode));
    var indexBits = Uint8List.fromList(utf8.encode(index.toString()));

    var combindedBits = Uint8List.fromList([parentPublicKeyBits, parentChainCodeBits, indexBits].expand((x) => x).toList());

    var hmacBits = hmac.process(combindedBits);

    var leftBits = Wallet.left256Bits(hmacBits);
    var rightBits = Wallet.right256Bits(hmacBits);

    _publicKey = hex.encode(leftBits);
    _chainCode = hex.encode(rightBits);
  }

  HdCkdItem.hardenedDerivation(String parentPrivateKey, String parentChainCode, int index, String path) {

    _index = index;
    _path = path;

    // TODO
    var hmac = HMac(SHA512Digest(), 128);
    var parentPrivateKeyBits = Uint8List.fromList(utf8.encode(parentPrivateKey));
    var parentChainCodeBits = Uint8List.fromList(utf8.encode(parentChainCode));
    var indexBits = Uint8List.fromList(utf8.encode(index.toString()));

    var combindedBits = Uint8List.fromList([parentPrivateKeyBits, parentChainCodeBits, indexBits].expand((x) => x).toList());

    var hmacBits = hmac.process(combindedBits);

    var leftBits = Wallet.left256Bits(hmacBits);
    var rightBits = Wallet.right256Bits(hmacBits);

    _privateKey = hex.encode(leftBits);
    _publicKey = Crypto.secp256k1Compressed(_privateKey);
    _chainCode = hex.encode(rightBits);
  }

}
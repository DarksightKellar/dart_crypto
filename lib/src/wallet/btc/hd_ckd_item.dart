
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_crypto/src/wallet/adapter/coin_adapter.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';

import '../../../dart_crypto.dart';

class HdCkdItem extends Wallet {

  HdCkdItem.derivation(String parentPublicKey, String parentChainCode, int index, String path, CoinAdapter adapter) {

    var hmac = HMac(SHA512Digest(), 128);
    var parentPublicKeyBits = Uint8List.fromList(utf8.encode(parentPublicKey));
    var parentChainCodeBits = Uint8List.fromList(utf8.encode(parentChainCode));
    var indexBits = Uint8List.fromList(utf8.encode(index.toString()));

    var combindedBits = Uint8List.fromList([parentPublicKeyBits, parentChainCodeBits, indexBits].expand((x) => x).toList());

    var hmacBits = hmac.process(combindedBits);

    var leftBits = left256Bits(hmacBits);
    var rightBits = right256Bits(hmacBits);

    this.index = index;
    this.path = path;
    this.adapter = adapter;
    privateKey = 'NULL';
    publicKey = hex.encode(leftBits);
    chainCode = hex.encode(rightBits);
    address = adapter.createAddress(publicKey);
  }

  HdCkdItem.hardenedDerivation(String parentPrivateKey, String parentChainCode, int index, String path, CoinAdapter adapter) {

    var hmac = HMac(SHA512Digest(), 128);
    var parentPrivateKeyBits = Uint8List.fromList(utf8.encode(parentPrivateKey));
    var parentChainCodeBits = Uint8List.fromList(utf8.encode(parentChainCode));
    var indexBits = Uint8List.fromList(utf8.encode(index.toString()));

    var combindedBits = Uint8List.fromList([parentPrivateKeyBits, parentChainCodeBits, indexBits].expand((x) => x).toList());

    var hmacBits = hmac.process(combindedBits);

    var leftBits = left256Bits(hmacBits);
    var rightBits = right256Bits(hmacBits);

    this.index = index;
    this.path = path;
    this.adapter = adapter;
    privateKey = hex.encode(leftBits);
    publicKey = Crypto.secp256k1Compressed(privateKey);
    chainCode = hex.encode(rightBits);
    address = adapter.createAddress(publicKey);
  }

}
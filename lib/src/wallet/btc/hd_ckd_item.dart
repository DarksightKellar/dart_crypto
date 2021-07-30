
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';

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
  }

  HdCkdItem.hardenedDerivation(String parentPrivateKey, String parentChainCode, int index, String path) {

    _index = index;
    _path = path;

    // TODO
    var hmac = HMac(SHA512Digest(), 128);
  }

}
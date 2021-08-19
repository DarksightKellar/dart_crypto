
import 'package:dart_crypto/dart_crypto.dart';
import 'package:dart_crypto/src/crypto.dart';
import 'package:dart_crypto/src/wallet/adapter/coin_adapter.dart';
import 'package:dart_crypto/src/wallet/adapter/null_adapter.dart';
import 'package:dart_crypto/src/wallet/btc/hd_ckd_item.dart';
import 'package:dart_crypto/src/wallet/wallet.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:convert/convert.dart';
import 'dart:convert';

class HDWallet extends Wallet {

  Map<String, HdCkdItem> ckdChilds = {};

  HDWallet.fromSeed(Seed seed) {

    index = 0;
    path = Wallet.BIP0044_STANDARD_MASTER;

    var hmac = HMac(SHA512Digest(), 128);
    var hmacBits = hmac.process(seed.seed);

    var leftBits = left256Bits(hmacBits);
    var rightBits = right256Bits(hmacBits);

    privateKey = hex.encode(leftBits);
    chainCode = hex.encode(rightBits);
    publicKey = Crypto.secp256k1Compressed(privateKey);
    address = 'NULL';

  }

  void generate(String path) {

    var currentPath = '';

    for (var pathFragment in path.split('/')) {

      var parentPath = currentPath;
      var currentIndex = pathFragment.replaceAll("'", '');

      currentPath = updateCurrentPath(currentPath, pathFragment);

      if (currentPath.toLowerCase() == Wallet.BIP0044_STANDARD_MASTER || ckdChilds.containsKey(currentPath)) {
        continue;
      }

      var ckdChild = createCkdChild(currentIndex, currentPath, parentPath, pathFragment);
      ckdChilds[currentPath] = ckdChild;
    }

  }

  HdCkdItem createCkdChild(String currentIndex, String currentPath, String parentPath, String pathFragment) {
    if (parentPath.toLowerCase() == Wallet.BIP0044_STANDARD_MASTER) {
      if (isHardenedChild(pathFragment)) {
        return HdCkdItem.hardenedDerivation(privateKey, chainCode, int.parse(currentIndex), currentPath, NullAdapter());
      }

      return HdCkdItem.derivation(publicKey, chainCode, int.parse(currentIndex), currentPath, NullAdapter());
    }

    var parentCkd = ckdChilds[parentPath];
    var adapter = getAdapter(currentIndex, parentPath, parentCkd!);

    if (isHardenedChild(pathFragment)) {
      return HdCkdItem.hardenedDerivation(parentCkd.privateKey, parentCkd.chainCode, int.parse(currentIndex), currentPath, adapter);
    }

    return HdCkdItem.derivation(parentCkd.publicKey, parentCkd.chainCode, int.parse(currentIndex), currentPath, adapter);

  }

  CoinAdapter getAdapter(String currentIndex, String parentPath, HdCkdItem parentCkd) {
    if (parentPath == Wallet.BIP0044_STANDARD_PREFIX) {
      return readAdapter(currentIndex);
    }

    return parentCkd.adapter;
  }

  String updateCurrentPath(String currentPath, String pathFragment) {
    if (currentPath == '') {
      return pathFragment;
    }

    return currentPath + '/' + pathFragment;
  }

  bool isHardenedChild(String path) {
    return path.contains("'");
  }

}
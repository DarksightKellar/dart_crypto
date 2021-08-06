
import 'package:dart_crypto/dart_crypto.dart';
import 'package:dart_crypto/src/crypto.dart';
import 'package:dart_crypto/src/wallet/adapter/btc_adapter.dart';
import 'package:dart_crypto/src/wallet/btc/hd_ckd_item.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:convert/convert.dart';

class HDWallet extends Wallet {

  late final String _path = 'm';

  late Map<String, HdCkdItem> ckdChilds;

  HDWallet.fromSeed(Seed seed) {

    adapterMap = {
      Wallet.ADAPTER_TYPE_BTC : BtcAdapter()
    };

    var hmac = HMac(SHA512Digest(), 128);
    var hmacBits = hmac.process(seed.seed);

    var leftBits = left256Bits(hmacBits);
    var rightBits = right256Bits(hmacBits);

    masterPrivateKey = hex.encode(leftBits);
    masterChainCode = hex.encode(rightBits);
    masterPublicKey = Crypto.secp256k1Compressed(masterPrivateKey);
    masterAddress = readAdapter(Wallet.ADAPTER_TYPE_BTC).createAddress(masterPublicKey);

  }

  void generate(String path) {

    var childs = path.split('/');

    for (var child in childs) {

      print(child);
    }

    print(path.split('/'));


  }

  generateCkdChilds(String currentPath, String finalPath)
  {
    if (currentPath == finalPath && ckdChilds.containsKey(currentPath)) {
      return ckdChilds[currentPath];
    }

    var currentPathElements = currentPath.split('/');
    var finalPathElements = finalPath.split('/');
    for(var i = 0; i <= finalPathElements.length; i++) {

    }

  }

}
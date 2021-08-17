
import 'dart:typed_data';

import 'package:dart_crypto/dart_crypto.dart';
import 'package:dart_crypto/src/wallet/adapter/bch_adapter.dart';
import 'package:dart_crypto/src/wallet/adapter/coin_adapter.dart';

abstract class Wallet {

  static const BIP0044_STANDARD_MASTER = 'm';
  static const BIP0044_STANDARD_PREFIX = "m/44'";

  late final int index;
  late final String path;
  late final String privateKey;
  late final String publicKey;
  late final String chainCode;
  late final String address;
  late final CoinAdapter adapter;

  var adapterMap = {
    CoinAdapter.ADAPTER_TYPE_BTC : BtcAdapter(),
    CoinAdapter.ADAPTER_TYPE_BCH : BchAdapter(),
  };

  Map toJson() => {
    'index': index,
    'path': path,
    'privateKey': privateKey,
    'publicKey': publicKey,
    'chainCode': chainCode,
    'address': address,
  };

  List<int> left256Bits(Uint8List hmacSha512Bits) {
    return hmacSha512Bits.getRange(0, 32).toList();
  }

  List<int> right256Bits(Uint8List hmacSha512Bits) {
    return hmacSha512Bits.getRange(32, hmacSha512Bits.length).toList();
  }

  CoinAdapter readAdapter(String type) {
    return adapterMap[type] as CoinAdapter;
  }

}
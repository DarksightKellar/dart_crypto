
import 'dart:typed_data';

import 'adapter/adapter.dart';

abstract class Wallet {

  // Btc Adapter
  static const ADAPTER_TYPE_BTC = 'btc';

  // Eth Adapter
  static const ADAPTER_TYPE_ETH = 'eth';

  // Regular address type for btc
  static const ADDRESS_TYPE_P2PKH = 'p2pkh';

  // Advanced address type for btc
  static const ADDRESS_TYPE_P2SH = 'p2sh';

  // Advanced address type for eth
  static const ADDRESS_TYPE_KECCAK256 = 'keccak256';

  late final String privateKey;
  late final String publicKey;
  late final String chainCode;
  late final String address;

  var adapterMap;

  static List<int> left256Bits(Uint8List hmacSha512Bits) {
    return hmacSha512Bits.getRange(0, 32).toList();
  }

  static List<int> right256Bits(Uint8List hmacSha512Bits) {
    return hmacSha512Bits.getRange(32, hmacSha512Bits.length).toList();
  }

  Adapter readAdapter(String type) {
    return adapterMap[type] as Adapter;
  }

}
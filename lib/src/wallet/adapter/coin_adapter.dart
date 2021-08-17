
import 'package:dart_crypto/dart_crypto.dart';

abstract class CoinAdapter extends Adapter {

  // Null Pattern Adapter
  static const ADAPTER_TYPE_NULL = '-1';

  // Btc Adapter
  static const ADAPTER_TYPE_BTC = '0';

  // Testnet Adapter
  static const ADAPTER_TYPE_TESTNET = '1';

  // Ltc Adapter
  static const ADAPTER_TYPE_LTC = '2';

  // BCH Adapter
  static const ADAPTER_TYPE_BCH = '145';

  // TODO continue coin types...

  // Eth Adapter
  static const ADAPTER_TYPE_ETH = 'eth';

  // Regular address type for btc
  static const ADDRESS_TYPE_P2PKH = 'p2pkh';

  // Advanced address type for btc
  static const ADDRESS_TYPE_P2SH = 'p2sh';

  // Advanced address type for btc
  static const ADDRESS_TYPE_BECH32 = 'bech32';

  // Advanced address type for eth
  static const ADDRESS_TYPE_KECCAK256 = 'keccak256';

  String getAddressType();

}
import 'package:dart_crypto/src/crypto.dart';

import 'coin_adapter.dart';

class BtcAdapter extends CoinAdapter {

  late String _addressType;

  BtcAdapter() {
    _addressType = CoinAdapter.ADDRESS_TYPE_P2PKH;
  }

  @override
  String createAddress(String publicKey) {
    return Crypto.p2pkh(publicKey);
  }

  @override
  String getAddressType() {
    return _addressType;
  }
}
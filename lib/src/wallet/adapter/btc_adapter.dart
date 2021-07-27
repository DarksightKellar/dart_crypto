import 'package:dart_crypto/src/crypto.dart';
import 'package:dart_crypto/src/wallet/adapter/adapter.dart';
import 'package:dart_crypto/src/wallet/wallet.dart';

class BtcAdapter extends Adapter {

  late String _addressType;

  BtcAdapter() {
    _addressType = Wallet.ADDRESS_TYPE_P2PKH;
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
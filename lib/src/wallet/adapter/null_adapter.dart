
import 'package:dart_crypto/src/wallet/adapter/coin_adapter.dart';

class NullAdapter extends CoinAdapter {

  @override
  String createAddress(String publicKey) {
    return 'NULL';
  }

  @override
  String getAddressType() {
    return 'NULL';
  }

}
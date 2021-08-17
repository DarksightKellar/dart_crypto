
import 'package:dart_crypto/src/crypto.dart';
import 'package:dart_crypto/src/seed/seed.dart';
import 'package:dart_crypto/src/wallet/adapter/coin_adapter.dart';
import 'package:dart_crypto/src/wallet/wallet.dart';

class PaperWallet extends Wallet {

  PaperWallet.fromSeed(Seed seed) {

    privateKey = Crypto.sha256(seed.mnemonic);
    publicKey = Crypto.secp256k1Compressed(privateKey);
    address = readAdapter(CoinAdapter.ADAPTER_TYPE_BTC).createAddress(publicKey);

  }

}
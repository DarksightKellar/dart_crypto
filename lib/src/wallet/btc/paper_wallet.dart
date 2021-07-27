
import 'package:dart_crypto/src/crypto.dart';
import 'package:dart_crypto/src/seed/seed.dart';
import 'package:dart_crypto/src/wallet/wallet.dart';

class PaperWallet extends Wallet {

  PaperWallet.fromSeed(Seed seed) {

    masterPrivateKey = Crypto.sha256(seed.mnemonic);
    masterPublicKey = Crypto.secp256k1Compressed(masterPrivateKey);
    masterAddress = readAdapter(Wallet.ADAPTER_TYPE_BTC).createAddress(masterPublicKey);

  }

}
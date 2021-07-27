
import 'package:dart_crypto/dart_crypto.dart';
import 'package:dart_crypto/src/crypto.dart';
import 'package:dart_crypto/src/wallet/adapter/btc_adapter.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:convert/convert.dart';

class HDWallet extends Wallet {

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

}
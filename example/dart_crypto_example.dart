import 'package:dart_crypto/dart_crypto.dart';
import 'dart:convert';

void main() {

  // Create some simple HD Wallet
  var seed = Seed();
  var wallet = HDWallet.fromSeed(seed);

  //Bip44 for bitcoin wallet
  var path = "m/44'/0'/0'/0/1";

  // generate some new wallet address by path
  wallet.generate(path);

  print(wallet.privateKey);
  // Master private key 57f9130368c2e7bae6c945476910e3ffac68fbea0a3c4378a0dcba1b721bceed

  print(wallet.ckdChilds[path]);
  // Wallet Address by bip44 {"index":1,"path":"m/44'/0'/0'/0/1","privateKey":"NULL","publicKey":"7414deff78c92d2bb18017cd841786f7018dcb087007b0b54585d50691fbdfe6","chainCode":"778512d28a448a8f642f34ab8d3bb3e70389d81f7debb8fe81831e3db0b639db","address":"1MjadsmDWx7onXsEBtD3fxYoxCv9evm5Zi"}

}

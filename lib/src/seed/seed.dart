import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;

class Seed {

  late final String _mnemonic;

  Seed() {
     _mnemonic = bip39.generateMnemonic();
  }

  Seed.fromMnemonic(Strin mnemonic) {
     _mnemonic = mnemonic;
  }

  String get mnemonic => _mnemonic;
  Uint8List get seed => bip39.mnemonicToSeed(_mnemonic);
}
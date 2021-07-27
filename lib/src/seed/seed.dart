import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;

class Seed {

  final String _mnemonic = bip39.generateMnemonic();

  String get mnemonic => _mnemonic;
  Uint8List get seed => bip39.mnemonicToSeed(_mnemonic);
}
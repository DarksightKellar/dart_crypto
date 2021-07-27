# Cryptographic library for basic blockchain encryptions & wallets.

A library for Dart developers.

Set of basic encryptions to use in context of blockchain wallets, such as bitcon or ethereum.

Included cryptos:

* seed generation
* mnemonic
* different types of private key generation
* public key generation
* common bitcoin address formats such es p2pkh & p2sh

Included wallets:

* hd wallets based on bip32, bip 39 & bip44


## Usage

A simple usage example:

```dart
import 'package:dart_crypto/dart_crypto.dart';

main() {
  var awesome = new Awesome();
  // awsome
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/steidler-eu/dart_crypto/issues

## License

Provided under MIT [license](https://github.com/steidler-eu/dart_crypto/blob/main/LICENSE).

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

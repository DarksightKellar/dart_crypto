# Cryptographic for blockchain encryptions & wallets.

---
**NOTE**

A library for Dart developers.

---

## Description

Set of basic encryptions to use in context of blockchain wallets, such as bitcon or ethereum.

**Included features:**
* seed generation
* mnemonic
* different types of private key generation
* public key generation
* common bitcoin address formats such es p2pkh & p2sh
* determenistic key generation and wallets
* papper wallets

## Cryptos

**Supported crypto standards:**
[BIP0033](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki),
[BIP0039](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki),
[BIP0044](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki),
sha256,
sha512,
secp256k1,
RIPEMD160,
p2pkh,
p2sh,
hmac

**Coin types supported, referred to [SLIP0044](https://github.com/satoshilabs/slips/blob/master/slip-0044.md):** Bitcoin, Bitcoin Cash



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

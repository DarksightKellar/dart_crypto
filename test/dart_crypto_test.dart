
import 'package:dart_crypto/src/crypto.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:test/test.dart';

void main() {
  group('Crypto Lib Tests', () {

    setUp(() {
      // Nothing to do
    });

    test('Sha256 by seed', () {
      var pk = Crypto.sha256('some seeed');

      print('sha256 ' + pk);
      expect(pk, '83d9256a2d86634b2675f3564c5c4d2f8592ebe355f907c9e98971da8e9b2f23');
    });

    test('secp256k1 by sha256 hash', () {
      var pk = '83d9256a2d86634b2675f3564c5c4d2f8592ebe355f907c9e98971da8e9b2f23';
      var pub = Crypto.secp256k1(pk);

      print('secp256k1 ' + pub);
      expect(pub, '049c443eb3710153f31e5fc4757b6eb2ee72e3ef01b8ee547d9340ad0b1b5dc7cae35d77d83a2ed8fb317ddfc218fe5fb325dcec6d1d3286078b322e1b4edbdfc2');
    });

    test('secp256k1 compressed by sha256 hash', () {
      var pk = '83d9256a2d86634b2675f3564c5c4d2f8592ebe355f907c9e98971da8e9b2f23';
      var pub = Crypto.secp256k1Compressed(pk);

      print('secp256k1 compressed ' + pub);
      expect(pub, '029c443eb3710153f31e5fc4757b6eb2ee72e3ef01b8ee547d9340ad0b1b5dc7ca');
    });

    test('p2pkh', () {
      var pub = '049c443eb3710153f31e5fc4757b6eb2ee72e3ef01b8ee547d9340ad0b1b5dc7cae35d77d83a2ed8fb317ddfc218fe5fb325dcec6d1d3286078b322e1b4edbdfc2';
      var address = Crypto.p2pkh(pub);

      print('p2pkh ' + address);
      expect(address, '1DUgxTZrFtbiJWCTWy4whMqKiDckCxZLL4');
    });

    test('p2sh', () {
      var pub = '049c443eb3710153f31e5fc4757b6eb2ee72e3ef01b8ee547d9340ad0b1b5dc7cae35d77d83a2ed8fb317ddfc218fe5fb325dcec6d1d3286078b322e1b4edbdfc2';
      var address = Crypto.p2sh(pub);

      print('p2pkh ' + address);
      expect(address, '3EAht14Honv6Pftte4jY7zCFrjuTk4fVeH');
    });

    test('Hmac 1', () {
      var pk = '83d9256a2d86634b2675f3564c5c4d2f8592ebe355f907c9e98971da8e9b2f23';
      var hash = Crypto.hmac('Hello World', pk);

      expect(hash, '2ad752bc0723d46c4f117e0dd3f8c1977fc41162366cba1d4ee8e07204f50840');
    });

    test('Hamc 2', () {
      var pub = '049c443eb3710153f31e5fc4757b6eb2ee72e3ef01b8ee547d9340ad0b1b5dc7cae35d77d83a2ed8fb317ddfc218fe5fb325dcec6d1d3286078b322e1b4edbdfc2';
      var hash = Crypto.hmac('Hello World', pub);

      expect(hash, 'b9c1bf3412ad82a0adc110ba88fc7fc56c69f630964f970c35fa41be0a8f6d30');
    });

    test('Verify', () {
      var pk = Crypto.sha256('some seeed');
      var pub = Crypto.secp256k1(pk);

      var pkObject = PrivateKey.fromHex(pk);
      var hash = Crypto.hmac('Hello World', pub);

      var sig = pkObject.signature(hash);
      return sig.verify(pkObject.publicKey, hash);
    });

  });
}

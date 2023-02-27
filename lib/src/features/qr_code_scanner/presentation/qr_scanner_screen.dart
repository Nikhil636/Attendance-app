import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../app/providers/qr_providers.dart';
import '../domain/qr_state.dart';

class QrScannerScreen extends ConsumerWidget {
  QrScannerScreen({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QrState controller = ref.watch(qrScreenControllerProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                    style: IconButton.styleFrom(shape: const CircleBorder()),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Text>[
                          Text(
                            'Scan QR Code',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: size.height * 0.70,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: ref
                      .watch(qrScreenControllerProvider.notifier)
                      .onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderWidth: 5,
                    borderColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: size.width * 0.95,
                  height: size.height * 0.1,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: controller.when(
                            initial: () => const Text('Scan your QR Code'),
                            scanning: () => const Text('Scanning...'),
                            loaded: (Barcode data) {
                              if (data.code == null) {
                                return const Text('No QR Code Found');
                              }
                              return Text(data.code!);
                            },
                            error: (String? error) {
                              return const Text('Couldn\'t scan QR Code');
                            },
                          ),
                        ),
                        controller.when(
                          initial: () => const Icon(Icons.qr_code_scanner),
                          scanning: () => const Icon(Icons.qr_code_scanner),
                          loaded: (Barcode data) {
                            return GestureDetector(
                              onTap: () => ref
                                  .read(qrScreenControllerProvider.notifier)
                                  .resumeCamera(),
                              child: const Icon(Icons.refresh_rounded),
                            );
                          },
                          error: (String? error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

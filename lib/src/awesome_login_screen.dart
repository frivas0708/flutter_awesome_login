import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'awesome_login_config.dart';
import 'widgets/awesome_login_card.dart';

/// Pantalla principal expuesta por el paquete.
/// Se coloca el logo flotando sobre la tarjeta con flip animation interna.
class AwesomeLoginScreen extends StatelessWidget {
  final AwesomeLoginConfig config;

  const AwesomeLoginScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: config.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _buildLoginContent(constraints);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginContent(BoxConstraints constraints) {
    final isWide = constraints.maxWidth > 700;
    final width = isWide ? 520.0 : constraints.maxWidth * 0.95;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: SizedBox(
        width: width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Logo
            SizedBox(
              height: 160,
              child: config.logo ??
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: config.primaryColor,
                    child:
                        Icon(Icons.lock, color: config.accentColor, size: 40),
                  ),
            ),
            // if (kDebugMode && config.showURL)
            //   SizedBox(
            //       height: 10,
            //       child: Center(
            //         child: Text(
            //           (config.apiUrl.contains('dev.') ? 'QA' : 'PROD'),
            //           style: TextStyle(
            //             color: Colors.white.withValues(alpha: 0.7),
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       )),
            if (kDebugMode && config.showURL)
              SizedBox(
                  height: 310,
                  child: Center(
                    child: Text(
                      config.apiUrl,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),

            // Card (se coloca con padding para que el logo quede encima)
            Padding(
              padding: const EdgeInsets.only(top: 145.0),
              child: AwesomeLoginCard(config: config),
            ),
          ],
        ),
      ),
    );
  }
}

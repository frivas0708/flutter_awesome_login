import 'package:flutter/material.dart';
import 'awesome_login_config.dart';
import 'tabs/awesome_login_tab.dart';

/// Widget principal expuesto por el paquete
class AwesomeLoginScreen extends StatefulWidget {
  final AwesomeLoginConfig config;

  /// Callbacks: devolverán null si OK o String con mensaje de error/resultado
  final Future<String?> Function(String email, String password) onLogin;
  final Future<String?> Function(String name, String email, String password)?
      onRegister;
  final Future<String?> Function(String email)? onRecover;

  const AwesomeLoginScreen({
    super.key,
    required this.config,
    required this.onLogin,
    this.onRegister,
    this.onRecover,
  });

  @override
  State<AwesomeLoginScreen> createState() => _AwesomeLoginScreenState();
}

class _AwesomeLoginScreenState extends State<AwesomeLoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isWide = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double _cardWidthFor(double maxWidth) {
    if (maxWidth > 1000) return 720;
    if (maxWidth > 700) return 560;
    if (maxWidth > 450) return 420;
    return maxWidth * 0.95;
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.config;

    return Scaffold(
      backgroundColor: cfg.backgroundColor,
      body: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cardWidth = _cardWidthFor(width);
        isWide = width > 700;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              width: cardWidth,
              padding: EdgeInsets.all(isWide ? 28 : 18),
              child: Card(
                elevation: cfg.cardElevation,
                shadowColor: cfg.cardShadowColor,
                color: cfg.cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      if (cfg.logo != null)
                        SizedBox(
                            height: 100,
                            child: Center(child: cfg.logo))
                      else
                        Icon(Icons.lock_outline,
                            size: 90, color: cfg.primaryColor),

                      const SizedBox(height: 14),

                      // Tabs
                      TabBar(
                        controller: _tabController,
                        labelColor: cfg.accentColor,
                        unselectedLabelColor: Colors.black54,
                        indicator: BoxDecoration(
                          color: cfg.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tabs: [
                          Tab(text: cfg.loginTitle),
                          Tab(text: cfg.registerTitle),
                          Tab(text: cfg.recoverTitle),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Tab views
                      SizedBox(
                        height: isWide ? 420 : 420,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            AwesomeLoginTab.login(
                              config: cfg,
                              onSubmit: widget.onLogin,
                            ),
                            AwesomeLoginTab.register(
                              config: cfg,
                              onSubmit: widget.onRegister,
                            ),
                            AwesomeLoginTab.recover(
                              config: cfg,
                              onSubmit: widget.onRecover,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

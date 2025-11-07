import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/providers/favorites_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesProvider>(context, listen: false);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Settings', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Theme card
                  _GlassCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Theme', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: const Text('System default (Material 3)'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Theme selection placeholder')),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Clear favorites card
                  _GlassCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Clear favorites', style: TextStyle(fontWeight: FontWeight.w600)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: () {
                          fav.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Favorites cleared')),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Privacy section
                  Text('Privacy & Offline', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  _GlassCard(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'This app stores all data locally and does not transmit any user data.',
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Frosted glass card used throughout settings
class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

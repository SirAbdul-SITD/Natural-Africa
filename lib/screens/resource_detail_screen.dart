import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/providers/favorites_provider.dart';

class ResourceDetailScreen extends StatelessWidget {
  static const routeName = '/resource';
  const ResourceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final ds = Provider.of<DataService>(context, listen: false);
    final r = ds.resourceById(id)!;
    final countries = ds.countriesForResource(r.id);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // AppBar with title & favorite button
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 140,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        r.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Consumer<FavoritesProvider>(
                      builder: (_, fav, __) {
                        final marked = fav.isFavorite(r.id);
                        return GestureDetector(
                          onTap: () => fav.toggle(r.id),
                          child: AnimatedScale(
                            scale: marked ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutCubic,
                            child: Icon(
                              marked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: marked ? cs.primary : cs.onBackground,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Description card (frosted glass)
                  _GlassCard(
                    child: Text(
                      r.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Category
                  _SectionHeader(title: 'Category'),
                  _GlassCard(child: Text(r.category, style: Theme.of(context).textTheme.bodyMedium)),

                  const SizedBox(height: 12),
                  _SectionHeader(title: 'Uses'),
                  _GlassCard(child: Text(r.uses, style: Theme.of(context).textTheme.bodyMedium)),

                  const SizedBox(height: 12),
                  _SectionHeader(title: 'Found in'),
                  ...countries.map((c) => _LinkTile(
                        title: c.name,
                        onTap: () => Navigator.pushNamed(context, '/country', arguments: c.id),
                      )),

                  const SizedBox(height: 12),
                  _SectionHeader(title: 'Export destinations'),
                  ...r.exportDestinations.map((e) => _LinkTile(title: e)),
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

/// Minimal, elegant section header
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700, color: cs.onBackground)),
    );
  }
}

/// Frosted glass card container
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
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 12, offset: const Offset(0, 6))],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Minimal link tile (used for countries & export destinations)
class _LinkTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _LinkTile({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.65),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.015), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium)),
                if (onTap != null)
                  Icon(Icons.chevron_right, color: cs.onBackground.withOpacity(0.6)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

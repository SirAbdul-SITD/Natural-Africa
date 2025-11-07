import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/screens/country_list_screen.dart';
import 'package:natural_africa/screens/resource_list_screen.dart';
import 'package:natural_africa/screens/favorites_screen.dart';
import 'package:natural_africa/screens/search_screen.dart';
import 'package:natural_africa/screens/about_screen.dart';
import 'package:natural_africa/screens/settings_screen.dart';

/// Apple-inspired minimal HomeScreen for Natural Africa.
/// Drop into lib/screens/home_screen.dart (replace existing).
class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  static const double _heroHeight = 220;

  @override
  Widget build(BuildContext context) {
    final ds = Provider.of<DataService>(context, listen: false);
    final countryCount = ds.allCountries().length;
    final resourceCount = ds.allResources().length;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cs.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Transparent app bar row
            SliverToBoxAdapter(child: _TopBar()),

            // Hero section with frosted glass and subtle parallax
            SliverToBoxAdapter(
              child: SizedBox(
                height: _heroHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Soft background gradient
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.9, -0.6),
                          end: Alignment(0.8, 0.9),
                          colors: [
                            Color(0xFFF6F7F9),
                            Color(0xFFEFF2F6),
                          ],
                        ),
                      ),
                    ),

                    // Gentle decorative accent circle (very subtle)
                    Positioned(
                      right: -60,
                      top: -40,
                      child: Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              cs.primary.withOpacity(0.06),
                              cs.primary.withOpacity(0.02),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Frosted glass card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.white.withOpacity(0.6)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Left column: title + description (parallax)
                                Expanded(
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 650),
                                    curve: Curves.easeOutCubic,
                                    builder: (context, val, child) {
                                      // val used to slightly translate title for an elegant entrance
                                      return Transform.translate(
                                        offset: Offset(0, (1 - val) * 8),
                                        child: Opacity(opacity: val, child: child),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Natural Africa',
                                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: cs.onBackground,
                                                letterSpacing: 0.1,
                                              ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Explore the continent’s natural resources with elegant, offline content curated for learning and discovery.',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: cs.onBackground.withOpacity(0.75),
                                                height: 1.35,
                                              ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            _StatPill(label: 'Countries', value: countryCount.toString()),
                                            const SizedBox(width: 8),
                                            _StatPill(label: 'Resources', value: resourceCount.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Right column: subtle glyph (using an icon as placeholder; no image)
                                Container(
                                  width: 68,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    color: cs.primary.withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    Icons.clear_rounded,
                                    color: cs.primary,
                                    size: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Spacer so floating tiles can overlap hero visually
            SliverToBoxAdapter(child: const SizedBox(height: 18)),

            // Floating dashboard cards (glass style)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: _DashboardArea(
                  countryCount: countryCount,
                  resourceCount: resourceCount,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 18)),

            // Section header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Featured',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onBackground,
                      ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // Featured resource list (compact, airy)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, idx) {
                  final resources = ds.allResources();
                  if (idx >= resources.length) return null;
                  final r = resources[idx];
                  // limit to 6 items on home
                  if (idx > 5) return null;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: _FeaturedCard(
                      title: r.name,
                      subtitle: r.category,
                      onTap: () => Navigator.pushNamed(context, '/resource', arguments: r.id),
                    ),
                  );
                },
                childCount: ds.allResources().length > 6 ? 6 : ds.allResources().length,
              ),
            ),

            // End spacing
            SliverToBoxAdapter(child: const SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}

/// Top bar: minimal with centered title and subtle leading/trailing buttons.
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      child: Row(
        children: [
          // IconButton(
          //   icon: Icon(Icons.menu_rounded, color: cs.onBackground.withOpacity(0.9)),
          //   onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu placeholder'))),
          //   tooltip: 'Menu',
          // ),
          // const Spacer(),
          Text(
            'Home',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, color: cs.onBackground.withOpacity(0.9)),
                onPressed: () => Navigator.pushNamed(context, SearchScreen.routeName),
                tooltip: 'Search',
              ),
              IconButton(
                icon: Icon(Icons.settings_outlined, color: cs.onBackground.withOpacity(0.9)),
                onPressed: () => Navigator.pushNamed(context, SettingsScreen.routeName),
                tooltip: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small rounded stat pill used in the hero (countries, resources).
class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  const _StatPill({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}

/// Dashboard area: responsive layout switching from grid to row on wide screens.
class _DashboardArea extends StatelessWidget {
  final int countryCount;
  final int resourceCount;

  const _DashboardArea({Key? key, required this.countryCount, required this.resourceCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      _GlassTile(
        title: 'Countries',
        subtitle: '$countryCount total',
        icon: Icons.public,
        onTap: () => Navigator.pushNamed(context, CountryListScreen.routeName),
      ),
      _GlassTile(
        title: 'Resources',
        subtitle: '$resourceCount total',
        icon: Icons.landscape_rounded,
        onTap: () => Navigator.pushNamed(context, ResourceListScreen.routeName),
      ),
      _GlassTile(
        title: 'Favorites',
        subtitle: 'Saved items',
        icon: Icons.favorite_rounded,
        onTap: () => Navigator.pushNamed(context, FavoritesScreen.routeName),
      ),
      _GlassTile(
        title: 'About',
        subtitle: 'Learn more',
        icon: Icons.info_outline_rounded,
        onTap: () => Navigator.pushNamed(context, AboutScreen.routeName),
      ),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 720;
      if (isWide) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children.map((c) => Expanded(child: Padding(padding: const EdgeInsets.all(8), child: c))).toList(),
        );
      } else {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.05,
          children: children,
        );
      }
    });
  }
}

/// Frosted-glass tile with subtle press animation.
class _GlassTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _GlassTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_GlassTile> createState() => _GlassTileState();
}

class _GlassTileState extends State<_GlassTile> {
  bool _pressed = false;

  void _setPressed(bool v) => setState(() => _pressed = v);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: '${widget.title}. ${widget.subtitle}',
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) {
          _setPressed(false);
          widget.onTap();
        },
        child: AnimatedScale(
          scale: _pressed ? 0.985 : 1.0,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.55)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 6))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                      child: Icon(widget.icon, color: Theme.of(context).colorScheme.primary),
                    ),
                    const Spacer(),
                    Text(widget.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(widget.subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Featured resource card (minimal, airy).
class _FeaturedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeaturedCard({Key? key, required this.title, required this.subtitle, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: '$title, $subtitle',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 6))],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.eco_outlined, color: cs.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[700])),
                  ]),
                ),
                Icon(Icons.chevron_right, color: cs.onSurface.withOpacity(0.6)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

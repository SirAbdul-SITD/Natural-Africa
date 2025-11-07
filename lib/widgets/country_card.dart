import 'package:flutter/material.dart';
import 'package:natural_africa/models/country.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback? onTap;
  const CountryCard({required this.country, this.onTap, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical:6.0, horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Text(country.name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(country.region),
        trailing: Text('${country.resources.length} resources'),
      ),
    );
  }
}

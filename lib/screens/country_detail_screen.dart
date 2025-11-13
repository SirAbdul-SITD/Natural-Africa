import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/widgets/resource_card.dart';
import 'package:natural_africa/providers/favorites_provider.dart';

class CountryDetailScreen extends StatelessWidget {
  static const routeName = '/country';
  const CountryDetailScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final ds = Provider.of<DataService>(context, listen: false);
    final country = ds.countryById(id)!;
    final resources = ds.resourcesForCountry(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        actions: [
          Consumer<FavoritesProvider>(builder: (_, fav, __){
            final marked = fav.isFavorite(country.id);
            return IconButton(
              icon: Icon(marked? Icons.favorite : Icons.favorite_border),
              onPressed: ()=>fav.toggle(country.id),
            );
          })
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(country.description),
            ),
          ),
          const SizedBox(height:12),
          Text('Resources in ${country.name}', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:8),
          ...resources.map((r)=>ResourceCard(resource: r, onTap: ()=>Navigator.pushNamed(context, '/resource', arguments: r.id))).toList(),
          const SizedBox(height:12),
          Text('Export partners', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:8),
          ...country.exportPartners.map((p)=>ListTile(title: Text(p), leading: const Icon(Icons.outbond))).toList(),
        ],
      ),
    );
  }
}

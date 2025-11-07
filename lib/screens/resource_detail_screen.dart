import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/models/resource.dart';
import 'package:natural_africa/providers/favorites_provider.dart';

class ResourceDetailScreen extends StatelessWidget {
  static const routeName = '/resource';
  const ResourceDetailScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final ds = Provider.of<DataService>(context, listen: false);
    final r = ds.resourceById(id)!;
    final countries = ds.countriesForResource(r.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(r.name),
        actions: [
          Consumer<FavoritesProvider>(builder: (_, fav, __){
            final marked = fav.isFavorite(r.id);
            return IconButton(
              icon: Icon(marked? Icons.favorite : Icons.favorite_border),
              onPressed: ()=>fav.toggle(r.id),
            );
          })
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Card(
            child: Padding(padding: const EdgeInsets.all(12.0), child: Text(r.description)),
          ),
          const SizedBox(height:12),
          Text('Category: ${r.category}', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:8),
          Text('Uses', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:6),
          Text(r.uses),
          const SizedBox(height:12),
          Text('Found in', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:6),
          ...countries.map((c)=>ListTile(title: Text(c.name), onTap: ()=>Navigator.pushNamed(context, '/country', arguments: c.id))).toList(),
          const SizedBox(height:12),
          Text('Export destinations', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:8),
          ...r.exportDestinations.map((e)=>ListTile(title: Text(e))).toList(),
        ],
      ),
    );
  }
}

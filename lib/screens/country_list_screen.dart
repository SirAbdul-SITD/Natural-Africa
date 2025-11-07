import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/widgets/country_card.dart';
import 'package:natural_africa/screens/country_detail_screen.dart';

class CountryListScreen extends StatelessWidget {
  static const routeName = '/countries';
  const CountryListScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    final ds = Provider.of<DataService>(context);
    final countries = ds.allCountries();
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (_, i){
          final c = countries[i];
          return CountryCard(country: c, onTap: ()=>Navigator.pushNamed(context, CountryDetailScreen.routeName, arguments: c.id));
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:natural_africa/models/country.dart';
import 'package:natural_africa/models/resource.dart';

class DataService {
  final Map<String, Country> countries = {};
  final Map<String, ResourceModel> resources = {};

  Future<void> loadAll() async {
    await _loadCountries();
    await _loadResources();
  }

  Future<void> _loadCountries() async {
    final s = await rootBundle.loadString('assets/data/countries.json');
    final list = json.decode(s) as List<dynamic>;
    for (final item in list) {
      final c = Country.fromJson(item as Map<String, dynamic>);
      countries[c.id] = c;
    }
  }

  Future<void> _loadResources() async {
    final s = await rootBundle.loadString('assets/data/resources.json');
    final list = json.decode(s) as List<dynamic>;
    for (final item in list) {
      final r = ResourceModel.fromJson(item as Map<String, dynamic>);
      resources[r.id] = r;
    }
  }

  List<Country> allCountries() => countries.values.toList()..sort((a,b)=>a.name.compareTo(b.name));
  List<ResourceModel> allResources() => resources.values.toList()..sort((a,b)=>a.name.compareTo(b.name));

  Country? countryById(String id) => countries[id];
  ResourceModel? resourceById(String id) => resources[id];

  List<ResourceModel> resourcesForCountry(String countryId) {
    return resources.values.where((r) => r.countries.contains(countryId)).toList();
  }

  List<Country> countriesForResource(String resourceId) {
    final r = resources[resourceId];
    if (r == null) return [];
    return r.countries.map((cid)=>countries[cid]).whereType<Country>().toList();
  }

  List<dynamic> search(String q) {
    final qL = q.toLowerCase();
    final foundCountries = countries.values.where((c) => c.name.toLowerCase().contains(qL) || c.description.toLowerCase().contains(qL)).toList();
    final foundResources = resources.values.where((r) => r.name.toLowerCase().contains(qL) || r.description.toLowerCase().contains(qL) || r.category.toLowerCase().contains(qL)).toList();
    return [...foundCountries, ...foundResources];
  }
}

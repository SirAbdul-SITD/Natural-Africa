class Country {
  final String id;
  final String name;
  final String iso2;
  final String description;
  final List<String> resources; // resource ids
  final List<String> exportPartners;
  final String region;

  Country({
    required this.id,
    required this.name,
    required this.iso2,
    required this.description,
    required this.resources,
    required this.exportPartners,
    required this.region,
  });

  factory Country.fromJson(Map<String, dynamic> j) => Country(
        id: j['id'] as String,
        name: j['name'] as String,
        iso2: j['iso2'] as String? ?? '',
        description: j['description'] as String? ?? '',
        resources: List<String>.from(j['resources'] ?? []),
        exportPartners: List<String>.from(j['exportPartners'] ?? []),
        region: j['region'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iso2': iso2,
        'description': description,
        'resources': resources,
        'exportPartners': exportPartners,
        'region': region,
      };
}

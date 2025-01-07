class Country {
  final String name;
  final String iso2;
  final String iso3;
  final String? phonecode;
  final String? capital;
  final String? currency;
  final String? nativeName;
  final String? emoji;
  final String? region;
  final String? subregion;
  final String? tld;
  final String? latitude;
  final String? longitude;

  Country({
    required this.name,
    required this.iso2,
    required this.iso3,
    this.phonecode,
    this.capital,
    this.currency,
    this.nativeName,
    this.emoji,
    this.region,
    this.subregion,
    this.tld,
    this.latitude,
    this.longitude,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      iso2: json['iso2'],
      iso3: json['iso3'],
      phonecode: json['phonecode'] as String?,
      capital: json['capital'] as String?,
      currency: json['currency'] as String?,
      nativeName: json['native'] as String?,
      emoji: json['emoji'] as String?,
      region: json['region'] as String?,
      subregion: json['subregion'] as String?,
      tld: json['tld'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iso2': iso2,
      'iso3': iso3,
      'phonecode': phonecode,
      'capital': capital,
      'currency': currency,
      'native': nativeName,
      'emoji': emoji,
      'region': region,
      'subregion': subregion,
      'tld': tld,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

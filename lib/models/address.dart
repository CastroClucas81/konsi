class Address {
  final int? id;
  final String? cep;
  final String? street;
  final String? district;
  final String? city;
  final String? uf;

  Address({
    this.id,
    this.cep,
    this.street,
    this.district,
    this.city,
    this.uf,
  });

  Address copyWith({
    int? id,
    String? cep,
    String? street,
    String? district,
    String? city,
    String? uf,
  }) {
    return Address(
      cep: cep ?? this.cep,
      street: street ?? this.street,
      district: district ?? this.district,
      city: city ?? this.city,
      uf: uf ?? this.uf,
    );
  }

  factory Address.fromJson(dynamic json) {
    final address = Address(
      id: json['id'] ?? 0,
      cep: json['cep'],
      street: json['logradouro'] ?? json['street'],
      district: json['bairro'] ?? json['district'],
      city: json['localidade'] ?? json['city'],
      uf: json['uf'] ?? json['uf'],
    );

    return address;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['cep'] = this.cep;
    data['street'] = this.street;
    data['district'] = this.district;
    data['city'] = this.city;
    data['uf'] = this.uf;

    return data;
  }

  String toString() {
    return "$street $district, $city, $uf $cep";
  }
}

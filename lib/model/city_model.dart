class CityProvince {
  Rajaongkir? rajaongkir;

  CityProvince({this.rajaongkir});

  CityProvince.fromJson(Map<String, dynamic> json) {
    rajaongkir = json['rajaongkir'] != null
        ? new Rajaongkir.fromJson(json['rajaongkir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rajaongkir != null) {
      data['rajaongkir'] = this.rajaongkir!.toJson();
    }
    return data;
  }
}

class Rajaongkir {
  Query? query;
  Status? status;
  List<Results>? results;

  Rajaongkir({this.query, this.status, this.results});

  Rajaongkir.fromJson(Map<String, dynamic> json) {
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Query {
  String? key;

  Query({this.key});

  Query.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}

class Status {
  int? code;
  String? description;

  Status({this.code, this.description});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class Results {
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  Results(
      {this.cityId,
      this.provinceId,
      this.province,
      this.type,
      this.cityName,
      this.postalCode});

  Results.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['province_id'] = this.provinceId;
    data['province'] = this.province;
    data['type'] = this.type;
    data['city_name'] = this.cityName;
    data['postal_code'] = this.postalCode;
    return data;
  }

  static List<Results> fromJsonList(List list) {
    if (list.length == 0) return List<Results>.empty();
    return list.map((item) => Results.fromJson(item)).toList();
  }
}

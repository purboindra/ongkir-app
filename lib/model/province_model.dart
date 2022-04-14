class ResultsProvince {
  String? provinceId;
  String? province;

  ResultsProvince({this.provinceId, this.province});

  ResultsProvince.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['province'] = this.province;
    return data;
  }

  static List<ResultsProvince> fromJsonList(List list) {
    if (list.length == 0) return List<ResultsProvince>.empty();
    return list.map((item) => ResultsProvince.fromJson(item)).toList();
  }
}

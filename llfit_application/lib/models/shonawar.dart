// To parse this JSON data, do
//
//     final shonawars = shonawarsFromJson(jsonString);

import 'dart:convert';

Shonawars shonawarsFromJson(String str) => Shonawars.fromJson(json.decode(str));

String shonawarsToJson(Shonawars data) => json.encode(data.toJson());

class Shonawars {
    bool success;
    List<Datum> data;

    Shonawars({
        required this.success,
        required this.data,
    });

    factory Shonawars.fromJson(Map<String, dynamic> json) => Shonawars(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    double weight;
    DateTime createdAt;

    Datum({
        required this.weight,
        required this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        weight: json["weight"]?.toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "weight": weight,
        "created_at": createdAt.toIso8601String(),
    };
}

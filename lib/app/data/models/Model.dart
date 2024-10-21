class Model {
  Data? data;
  Model({this.data});

  Model.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Characters? characters;

  Data({this.characters});

  Data.fromJson(Map<String, dynamic> json) {
    characters = json['characters'] != null
        ? new Characters.fromJson(json['characters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.characters != null) {
      data['characters'] = this.characters!.toJson();
    }
    return data;
  }
}

class Characters {
  Info? info;
  List<Results>? results;

  Characters({this.info, this.results});

  Characters.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? pages;
  int? next;
  int? prev;

  Info({this.pages, this.next, this.prev});

  Info.fromJson(Map<String, dynamic> json) {
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pages'] = this.pages;
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}

class Results {
  String? id;
  String? name;
  String? image;
  String? status;

  Results({this.id, this.name, this.image, this.status});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
class TaskModel {
  String? category, sDate, eDate, discrp;

  TaskModel({this.category, this.discrp, this.sDate, this.eDate});

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "sDate": sDate,
      "eDate": eDate,
      "discrp": discrp,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map)
      : category = map["category"],
        sDate = map["sDate"],
        eDate = map["eDate"],
        discrp = map["discrp"];
}

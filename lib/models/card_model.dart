class CardModel {
  String? cardHolderName;
  String? cardNumber;
  String? expiryDate;
  String? securityCode;
  String? createdAt;
  String? updatedAt;
  bool? isPinned;

  CardModel(
      {cardHolderName,
      cardNumber,
      expiryDate,
      securityCode,
      createdAt,
      updatedAt,
      isPinned = false
      });

  CardModel.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    expiryDate = json['expiryDate'];
    securityCode = json['securityCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isPinned = json['isPinned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardHolderName'] = cardHolderName;
    data['cardNumber'] = cardNumber;
    data['expiryDate'] = expiryDate;
    data['securityCode'] = securityCode;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isPinned'] = isPinned;
    return data;
  }
}

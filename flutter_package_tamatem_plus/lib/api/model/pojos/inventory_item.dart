class InventoryItem {
  String? codeValue;
  String? gamePlayerId;
  String? id;
  bool? isRedeemed;
  bool? isVerified;
  String? name;
  String? playerFullName;
  String? playerSerialNumber;

  InventoryItem({
    this.codeValue,
    this.gamePlayerId,
    this.id,
    this.isRedeemed,
    this.isVerified,
    this.name,
    this.playerFullName,
    this.playerSerialNumber,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        codeValue: json["code_value"],
        gamePlayerId: json["game_player_id"],
        id: json["id"],
        isRedeemed: json["is_redeemed"],
        isVerified: json["is_verified"],
        name: json["name"],
        playerFullName: json["player_full_name"],
        playerSerialNumber: json["player_serial_number"],
      );

  Map<String, dynamic> toJson() => {
        "code_value": codeValue,
        "game_player_id": gamePlayerId,
        "id": id,
        "is_redeemed": isRedeemed,
        "is_verified": isVerified,
        "name": name,
        "player_full_name": playerFullName,
        "player_serial_number": playerSerialNumber,
      };
}

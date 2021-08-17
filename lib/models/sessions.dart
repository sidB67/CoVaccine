class Session {
    Session({
       
       required this.name,
       required this.address,
      required  this.feeType,
        required this.availableCapacity,
       required  this.fee,
        required this.minAgeLimit,
       required this.vaccine,
       required this.slots,
    });

    
    late String name;
    late String address;
    late String feeType;
    late int availableCapacity;
    late String fee;
    late int minAgeLimit;
    late String vaccine;
    late List<String> slots;

    factory Session.fromJson(Map<String, dynamic> json) => Session(
        
        name: json["name"],
        address: json["address"],
       
        feeType: json["fee_type"],
       
        availableCapacity: json["available_capacity"],
        fee: json["fee"],
        minAgeLimit: json["min_age_limit"],
        vaccine: json["vaccine"],
        slots: List<String>.from(json["slots"].map((x) => x)),
    );
}
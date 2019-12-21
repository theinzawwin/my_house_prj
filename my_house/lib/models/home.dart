class Home{
  int id;
  String name;
  String address;
  double area;
  double qty;
  double rate;
  double tax;
  String remark;
   Home({this.id,this.name,this.address,this.area,this.qty,this.rate,this.tax,this.remark});
factory Home.fromJson(Map<String,dynamic> json) => Home(
  id: json["id"],
  name: json["name"],
  address: json["address"],
  area: json["area"].toDouble(),
  qty: json["qty"]!=null?json["qty"].toDouble()??0:0,
  rate: json["rate"].toDouble()??0,
  tax: json["tax"]!=null?json["tax"].toDouble():0,
  remark: json["remark"]
);
   Map<String, dynamic> toJson() => {
        "id":this.id,
        "name":this.name,
        "address":this.address,
        "area":this.area,
        "qty":this.qty,
        "rate":this.rate,
        "tax":this.tax,
        "remark":this.remark
      };
}
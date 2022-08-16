void main(){
  List<Map<String,dynamic>> getCartHistoryList=[
    {}
  ];
  Map<String,int> cartItemsPerOrder = Map();
  for(int i =0; i<getCartHistoryList.length;i++){
    if(cartItemsPerOrder.containsKey(getCartHistoryList[i]["time"])){
      cartItemsPerOrder.update(getCartHistoryList[i]["time"], (value) => ++value);
    }else{
      cartItemsPerOrder.putIfAbsent(getCartHistoryList[i]["time"],()=>1);

    }
  }
  List<int> cartOrderTimeToList(){
    return cartItemsPerOrder.entries.map((e) => e.value).toList();

  }
  List<int> orderTimes = cartOrderTimeToList();
var saveCounter=0;
for(int x=0; x<cartItemsPerOrder.length;x++){
  for(int y =0; y<orderTimes.length; y++){
    print("my order is "+getCartHistoryList[saveCounter++].toString());
  }
}
}
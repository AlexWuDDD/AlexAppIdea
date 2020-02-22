

bool isZEROorONE(String s){
  if(s.isEmpty){
    return false;
  }
  for(var r in s.runes){
    if(r ^ 0x30 != 0 && r ^ 0x30 != 1){
      return false;
    }
  }
  return true;
}
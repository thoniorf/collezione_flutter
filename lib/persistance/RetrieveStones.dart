import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveStones {
  static Firestore _instance = Firestore.instance;
  static final String _stonesCollectionName = "stones";

  static CollectionReference _getAllStonesQuery() {
    return _instance.collection(_stonesCollectionName);
  }

  static Future<List<DocumentSnapshot>> getAllStonesDocuments() async{
    QuerySnapshot snapshot =  await _getAllStonesQuery().getDocuments();
    return snapshot.documents;
  }

  static Future<void> removeStone(String id){
    return _getAllStonesQuery().document(id).delete();
  }
}
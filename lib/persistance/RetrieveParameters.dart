import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveParameters {
  static Firestore _instance = Firestore.instance;
  static final String _parametersCollectionName = "parameters";

  static CollectionReference _getAllParametersQuery() {
    return _instance.collection(_parametersCollectionName);
  }

  static Future<List<DocumentSnapshot>> getAllParametersDocuments(String language) async{
    QuerySnapshot snapshot =  await _getAllParametersQuery().getDocuments();
    return snapshot.documents;
  }

  static Stream<QuerySnapshot> getAllParametersQueryStream() {
    return _getAllParametersQuery().snapshots();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/character.dart';

class FirestoreService {
  static final ref =
      FirebaseFirestore.instance.collection('characters').withConverter(
            //factory methods that make inserting and getting from firestore simple
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character c, _) => c.toFirestore(),
          );

  //add a new character
  static Future<void> addCharacter(Character character) async {
    await ref.doc(character.id).set(character);
  }

  //get chatacters once
  static Future<QuerySnapshot<Character>> getCharacters() {
    return ref.get();
  }

  //update a character

  //delete a character
}

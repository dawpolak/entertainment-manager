import 'dart:developer';

import 'package:entertainmentmanager/model/book.dart';
import 'package:entertainmentmanager/model/game.dart';
import 'package:entertainmentmanager/model/movie.dart';
import 'package:firebase_database/firebase_database.dart';


class RldbRepository{


  final FirebaseDatabase _db = FirebaseDatabase.instance;



  Future<bool> addGame(String uid, Game game) async{
    DatabaseReference reference = _db.reference().child('db').child('v1').child(uid).child('games').push();
    try{
      reference.set(game.toJson());
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> editGame(String uid, Game game) async{
    try{
      _db.reference().child('db').child('v1').child(uid).child('games').child(game.key).set(game.toJson());
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> deleteGame(String uid, Game game) async{
    try{
      _db.reference().child('db').child('v1').child(uid).child('games').child(game.key).remove();
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> addBook(String uid, Book book) async{
    DatabaseReference reference = _db.reference().child('db').child('v1').child(uid).child('books').push();
    try{
      reference.set(book.toJson());
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> editBook(String uid, Book book) async{
    try{
      _db.reference().child('db').child('v1').child(uid).child('books').child(book.key).set(book.toJson());
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> deleteBook(String uid, Book book) async{
    try{
      _db.reference().child('db').child('v1').child(uid).child('books').child(book.key).remove();
      return true;
    } catch(e){
      log("Eroor: ${e}");
      return false;
    }
  }

  Future<bool> addMovie(String uid, Movie movie, {isSeries=false}) async{
    String collection = isSeries ? 'series' : 'movies';
    DatabaseReference reference = _db.reference().child('db').child('v1').child(uid).child(collection).push();
    try{
      reference.set(movie.toJson());
      return true;
    } catch(e){

      return false;
    }
  }

  Future<bool> editMovie(String uid, Movie movie, {isSeries=false}) async{
    String collection = isSeries ? 'series' : 'movies';
    try{
      _db.reference().child('db').child('v1').child(uid).child(collection).child(movie.key).set(movie.toJson());
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> deleteMovie(String uid, Movie movie, {isSeries=false}) async{
    String collection = isSeries ? 'series' : 'movies';
    try{
      _db.reference().child('db').child('v1').child(uid).child(collection).child(movie.key).remove();
      return true;
    } catch(e){
      log(e);
      return false;
    }
  }
}
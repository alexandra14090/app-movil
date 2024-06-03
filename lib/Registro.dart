import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  @override
  RegistroApp createState() => RegistroApp();
}

class RegistroApp extends State<Registro> {
  TextEditingController usuario = TextEditingController();
  TextEditingController doc = TextEditingController();
  TextEditingController pass = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  registroUsuario() async {
    try {
      await firebase.collection("Users").doc().set({
        "Nombre": usuario.text,
        "Documento": doc.text,
        "Password": pass.text,
      });
      print("Usuario registrado exitosamente.");
    } catch (e) {
      print("ERROR: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro Usuario"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 50, right: 10),
              child: TextField(
                controller: usuario,
                decoration: InputDecoration(
                  labelText: "Nombre Usuario",
                  hintText: "Digite nombre usuario",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: TextField(
                controller: doc,
                decoration: InputDecoration(
                  labelText: "Documento Usuario",
                  hintText: "Digite documento usuario",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Digite contraseña usuario",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(60),
              child: ElevatedButton(
                onPressed: () {
                  print("enviando.....");
                  registroUsuario();
                },
                child: Text("Enviar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

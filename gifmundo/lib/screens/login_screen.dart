import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Esto elimina la flecha de retroceso
        title: const Text('Iniciar Sesión'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Agregar el logo aquí
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/icons/GifMundo.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Muestra el SnackBar y luego navega a la pantalla de búsqueda
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Inicio de sesión exitoso'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Espera 2 segundos antes de navegar a la pantalla de búsqueda
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushReplacementNamed(context, '/');
                      });
                    },
                    child: const Text('Iniciar Sesión'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

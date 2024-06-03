import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiénes Somos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/icons/GifMundo1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nuestra Misión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nuestra misión es proporcionar los mejores servicios de GIFs y recursos gráficos para que nuestros usuarios puedan expresarse de manera creativa y divertida.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nuestra Visión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nuestra visión es convertirnos en la plataforma líder en la búsqueda y descarga de GIFs, ofreciendo una experiencia de usuario inigualable y contenido de alta calidad.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nuestros Valores',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Innovación: Siempre buscamos nuevas formas de mejorar y sorprender a nuestros usuarios.\n'
                '• Calidad: Nos comprometemos a ofrecer contenido y servicios de la más alta calidad.\n'
                '• Comunidad: Valoramos y apoyamos a nuestra comunidad de usuarios y colaboradores.\n'
                '• Diversión: Creemos que la diversión es esencial y nos esforzamos por hacer que cada interacción sea agradable.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Sobre Nosotros',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Somos un equipo apasionado por la creatividad y la tecnología, dedicado a proporcionar las mejores herramientas y recursos para que nuestros usuarios puedan expresarse de manera única y divertida.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Contáctanos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Si tienes alguna pregunta o sugerencia, no dudes en contactarnos a través de nuestro formulario de contacto en la sección correspondiente.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                  Navigator.pushNamed(context, '/contact');
                  },
                  icon: const Icon(Icons.mail),
                  label: const Text('Contáctanos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Color del botón
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

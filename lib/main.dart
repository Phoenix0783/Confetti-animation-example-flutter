import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        isPlaying = controller.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Confetti Animation'),
            ),
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.network(
                      'https://i.pinimg.com/originals/12/f6/ac/12f6accc21f3cad0047fc68fc282569c.gif'),
                ),
                // Center(
                // child:

                Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isPlaying) {
                        controller.stop();
                      } else {
                        controller.play();
                      }
                    },
                    child: Text(isPlaying ? 'Stop Confetti' : 'Play Confetti'),
                  ),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: controller,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.directional,
            numberOfParticles: 20,
            minBlastForce: 10,
            maxBlastForce: 100,
            emissionFrequency: 0.2,
            gravity: 0.2,
            colors: const [
              Colors.red,
              Colors.yellow,
              Colors.blueAccent,
              Colors.pink,
              Colors.green,
            ],
            // createParticlePath: (size) {
            //   final path = Path();

            //   path.addOval(Rect.fromCircle(center: Offset.zero, radius: 10));
            //   return path;
            // },
          ),
          ConfettiWidget(
            confettiController: controller,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 20,
            minBlastForce: 10,
            maxBlastForce: 100,
            emissionFrequency: 0.2,
            gravity: 0.3,
            colors: const [
              Colors.red,
              Colors.yellow,
              Colors.blueAccent,
              Colors.pink,
              Colors.green,
            ],
            createParticlePath: (size) {
              final path = Path();

              path.addOval(Rect.fromCircle(center: Offset.zero, radius: 10));
              return path;
            },
          )
        ],
      ),
    );
  }
}

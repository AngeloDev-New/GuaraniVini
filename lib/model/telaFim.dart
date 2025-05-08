    import 'package:flutter/material.dart';

class endPerguntas extends StatelessWidget{
  final void Function() resetFrases;
  final Color forestGreen;
  final Color darkBrown;
  
  const endPerguntas({
    Key? key,
    required this.resetFrases,
    required this.forestGreen,
    required this.darkBrown,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'As frases acabaram!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkBrown),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: resetFrases,
            icon: Icon(Icons.replay),
            label: Text("Reiniciar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: forestGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
    
}
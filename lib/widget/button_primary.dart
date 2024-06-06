import 'package:appmedic/theme.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback? onTap; // Utilisation de VoidCallback pour le type du callback

  ButtonPrimary({ this.text = '', this.onTap}); // Ajout de required pour les paramètres obligatoires

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text, ),
        style: ElevatedButton.styleFrom(
          backgroundColor: purpleColor,
          foregroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

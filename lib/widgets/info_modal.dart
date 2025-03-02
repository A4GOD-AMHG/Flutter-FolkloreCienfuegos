import 'package:flutter/material.dart';

void showCustomModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _CustomAnimatedDialog();
    },
  );
}

class _CustomAnimatedDialog extends StatefulWidget {
  @override
  _CustomAnimatedDialogState createState() => _CustomAnimatedDialogState();
}

class _CustomAnimatedDialogState extends State<_CustomAnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Dialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFEBDDBC),
              borderRadius: BorderRadius.circular(45.0),
            ),
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEBDDBC),
                border: Border.all(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.circular(45.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                      height: 170,
                      width: 170,
                      child: Image.asset('assets/images/identity.png')),
                  SizedBox(height: 10),
                  Text(
                    'Diseño:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'D.I. Félix E. Estrada Varela',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Desarrollo:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Ing. Alexis M. Hurtado García',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '2025',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

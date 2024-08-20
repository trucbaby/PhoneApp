import 'package:flutter/widgets.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key,}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}
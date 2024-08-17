import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget iconButton(int posisiGambar, int total) {
  var icon = Icons.arrow_right_alt_outlined;
  if (posisiGambar == total - 1) {
    icon = Icons.check;
  }
  return Icon(
    icon,
    color: Colors.white,
  );
}

class TopScreenImage extends StatelessWidget {
  const TopScreenImage({super.key, required this.screenImageName});
  final String screenImageName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/img/$screenImageName'),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.isOutlined = false,
      required this.onPressed,
      this.width = 280,
      this.fontSize = 20
      });
  final String buttonText;
  final bool isOutlined;
  final Function onPressed;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 4,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.white : const Color(0xFF4879C5),
            border: Border.all(color: const Color(0xFF4879C5), width: 2.5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: isOutlined ? const Color(0xFF4879C5) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration myDecoration(String hintText, Icon icon, {IconButton? suffix}) {
  return InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      prefixIcon: icon,
      suffixIcon: suffix != null ? suffix : null,
      filled: true);
}

Scaffold template(String title, Widget child,{List<Widget>? actionBtn}) {
  return Scaffold(
    appBar: AppBar(
      elevation: 2,
        shadowColor:Colors.black,
      // title: Text(title),
      actions: actionBtn ?? null,
      title: Text(title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      )
    ),
    body: child,
    bottomNavigationBar: BottomAppBar(
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Get.offAllNamed('/main');
              },
              icon: Icon(
                Icons.home,
                color: Get.currentRoute == '/main' ? Colors.blue : Colors.black,
              )),
          IconButton(
              onPressed: () {
                Get.offAllNamed('/maps');
              },
              icon: Icon(
                Icons.pin_drop_outlined,
                color: Get.currentRoute == '/maps' ? Colors.blue : Colors.black,
              )),
          IconButton(
              onPressed: () {
                Get.offAllNamed('/truck');
              },
              icon: Icon(
                Icons.local_shipping,
                color:
                    Get.currentRoute == '/truck' ? Colors.blue : Colors.black,
              )),
          IconButton(
              onPressed: () {
                Get.offAllNamed('/profile');
              },
              icon: Icon(
                Icons.person,
                color:
                    Get.currentRoute == '/profile' ? Colors.blue : Colors.black,
              )),
        ],
      ),
    ),
    // floatingActionButton: Container(
    //   width: 50,
    //   height: 50,
    //   decoration: BoxDecoration(
    //       color: Colors.blue, borderRadius: BorderRadius.circular(40)),
    //   child: RawMaterialButton(
    //     onPressed: () {},
    //     child: const Icon(
    //       Icons.camera_alt_outlined,
    //       color: Colors.white,
    //       size: 30,
    //     ),
    //   ),
    // ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
}

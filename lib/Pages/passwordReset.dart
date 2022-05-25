import 'package:flutter/material.dart';
import 'package:maestro2/Services/resetPasswordService.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  final passwordResetController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Şifremi Unuttum"),
      ),
      body: Row(
        children: [
          Spacer(),
          Flexible(
            child: Column(
              children: [
                Spacer(flex: 5,),
                Flexible(child: Text("Şifresi Unutulan Hesabın E-Postası",style: TextStyle(fontSize: 18),)),
                Spacer(),
                Flexible(child: TextField(controller: passwordResetController,)),
                Spacer(),
                Container(width: 250,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(),
                      backgroundColor: Colors.black,
                      child: Text("Şifreyi Sıfırla"),
                      onPressed: (){
                        resetPassword(passwordResetController.text);
                      }),
                ),Spacer(flex: 5,)
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

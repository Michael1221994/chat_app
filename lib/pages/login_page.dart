import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Services/Auth/auth_service.dart';
import 'package:minimal_chat_app/components/my_button.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  //email and password controllers
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();

  //tap to go to register page
  final void Function()? onTap;

   LoginPage({super.key, required this.onTap});

   void login(BuildContext context) async{
    //auth service
    final AuthService authService= AuthService();

    //try login
    try{
      await authService.signinwithEmailandPassword(_emailController.text, _passwordController.text);
    }catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),));
    }
    
   }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, //wagwan 
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
             Icon(Icons.message, size: 60, color: Theme.of(context).colorScheme.primary, ),
            const SizedBox(height: 50),
            //welcome back message
            Text(
              "Welcome back you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              ),

              const SizedBox(height: 25,),

              //email textfield
              MyTextfield(hintText: "Email", obscureText: false, controller: widget._emailController),

              const SizedBox(height: 10,),
              //password textfield
              MyTextfield(hintText: "Password", obscureText: true, controller: widget._passwordController,),

               const SizedBox(height: 10,),

              //login Button
              Mybutton(text: "Login", onTap: () => widget.login(context),),

              const SizedBox(height: 20,),

              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Register now ", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),))
                ],
              )
          ],
        ),
      ),
    );
  }

}
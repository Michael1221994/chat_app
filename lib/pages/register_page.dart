import 'package:flutter/material.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';

import '../components/my_button.dart';

class RegisterPage extends StatefulWidget {
   final TextEditingController _emailController= TextEditingController();
   final TextEditingController _passwordController= TextEditingController();
   final TextEditingController _confirmpasswordController= TextEditingController();
   final void Function()? onTap;
   RegisterPage({super.key, required this.onTap});

   void register (){}

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              "Let's create an account for you!",
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

              //confirm password Textfield
              MyTextfield(hintText: "Confirm password", obscureText: true, controller: widget._confirmpasswordController,),


               const SizedBox(height: 10,),

              //login Button
              Mybutton(text: "Register", onTap: widget.register,),

              const SizedBox(height: 20,),

              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(" Login now ", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),))
                ],
              )
          ],
        ),
      ),
    );
  }
}
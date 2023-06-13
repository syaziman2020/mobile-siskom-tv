import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siskom_tv_dosen/pages/profile_page.dart';
import 'package:siskom_tv_dosen/theme.dart';
import 'package:siskom_tv_dosen/widgets/custom_form.dart';

import '../cubit/manage_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteC,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.width * 0.32,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/logo-untan.png',
                    width: size.width * 0.2,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'Prodi Rekayasa Sistem Komputer',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Color.fromARGB(255, 243, 221, 23),
                        shadows: const [
                          Shadow(
                            blurRadius: 5, // shadow blur
                            color: Colors.black, // shadow color
                            offset:
                                Offset(1, 1), // how much shadow will be shown
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.width * 0.08,
              ),
              Text(
                'Login',
                style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              Text(
                'Masukkan email dan password kamu yang sudah terdaftar',
                style: greyTextStyleB,
              ),
              SizedBox(
                height: size.width * 0.1,
              ),
              CustomTextFormField(
                labelText: 'Email',
                hintText: 'Masukkan email kamu',
                keyboardType: TextInputType.emailAddress,
                controller: emailC,
              ),
              SizedBox(
                height: size.width * 0.025,
              ),
              CustomTextFormField(
                labelText: 'Password',
                hintText: 'Masukkan password kamu',
                keyboardType: TextInputType.visiblePassword,
                controller: passC,
                obscureText: true,
                action: TextInputAction.done,
              ),
              SizedBox(
                height: size.width * 0.025,
              ),
              BlocConsumer<ManageCubit, ManageState>(
                listener: (context, state) {
                  if (state is LoginFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is LoginSucces) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 226, 208, 8)),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 226, 208, 8),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7))),
                      onPressed: () {
                        context
                            .read<ManageCubit>()
                            .login(emailC.text, passC.text);
                      },
                      child: Text(
                        'Login Sekarang',
                        style: whiteTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 13),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

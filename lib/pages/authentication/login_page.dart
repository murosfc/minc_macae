import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:minc_macae/components/bottom_nav_bar.dart';
import 'package:minc_macae/pages/authentication/error/errors.dart';
import 'package:minc_macae/configuration/app-colors.dart';
import 'package:minc_macae/service/authentications_service.dart';
import 'package:minc_macae/service/contracts/authentication_service_interface.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final IAuthenticationService _authService = AuthenticationService();

  final TextEditingController _phoneController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  bool _showContainer = false;
  bool _isValidPhoneNumber = false;
  String _error = "";
  bool _isLoading = false;
  bool _wasCodeSentToUser = false;
  String _verificationId = "";

  final List<String> _codeDigits = List<String>.filled(6, '', growable: false);
  final List<TextEditingController> _codeControllers =
      List.generate(6, (_) => TextEditingController());
  bool _isCodeNumber = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_handlePhoneNumberChange);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showContainer = true;
      });
    });

    for (int i = 0; i < 6; i++) {
      _codeControllers[i].addListener(() {});
    }
  }

  void _validatePhoneNumber(String input) {
    setState(() {
      _isValidPhoneNumber =
          RegExp(r'[0-9]{11}').hasMatch(maskFormatter.getUnmaskedText());
      _phoneController.text.isEmpty;
    });
  }

  void _handlePhoneNumberChange() {
    setState(() {
      _error = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/minc-background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom:
                _showContainer ? 0 : -MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: !_wasCodeSentToUser
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20.0),
                        const Text(
                          'Bem-vindo ao MinC Macaé!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20.0),
                        Center(
                          child: Image.asset(
                            'assets/icon/android-chrome-192x192.png',
                            width: 64,
                            height: 64,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Digite seu telefone para entrar:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 20.0),
                              TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [maskFormatter],
                                onChanged: _validatePhoneNumber,
                                decoration: InputDecoration(
                                  labelText: 'Número do telefone',
                                  hintText: '(99) 99999-9999',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: (_isValidPhoneNumber ||
                                              _phoneController.text.isEmpty)
                                          ? Colors.white
                                          : Colors.red,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: (_isValidPhoneNumber ||
                                              _phoneController.text.isEmpty)
                                          ? Colors.white
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                maxLength: maskFormatter.getMask()?.length,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_isValidPhoneNumber && _error.isEmpty) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      await _authService.verifyPhoneNumber(
                                        maskFormatter.getUnmaskedText(),
                                        (PhoneAuthCredential credential) {
                                          _authService
                                              .signInWithCredential(credential);
                                          navigateToHome();
                                        },
                                        (FirebaseAuthException e) {                                          
                                          setState(() {
                                            _error = Errors.getError(e.code)!;
                                            _isLoading = false;
                                          });
                                        },
                                        (String verificationId,
                                            int? resendToken) {
                                          getSmsCode(verificationId);
                                        },
                                        (String verificationId) {
                                          getSmsCode(verificationId);
                                        },
                                      );
                                    } catch (e) {
                                      setErrors(e);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      (_isValidPhoneNumber && _error.isEmpty)
                                          ? AppColors.lightBlue
                                          : Colors.grey,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width - 40,
                                      0),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Visibility(
                                      visible: !_isLoading,
                                      child: Text('Entrar',
                                          style: TextStyle(
                                              color: _isValidPhoneNumber
                                                  ? Colors.white
                                                  : Colors.grey[600])),
                                    ),
                                    Visibility(
                                      visible: _isLoading,
                                      child:
                                          const CircularProgressIndicator(),
                                    ),
                                  ],
                                ),
                              ),
                              _error.isEmpty
                                  ? Container()
                                  : const SizedBox(height: 20.0),
                              _error.isEmpty
                                  ? Container()
                                  : Text(
                                      _error,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12.0),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20.0),
                          const Text(
                            'Confirme o código recebido por SMS',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                6, (index) => _buildDigitField(index)),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_isCodeNumber) {
                                  try {
                                    await _authService.verifyPhoneNumberWithCode(
                                        _verificationId, _codeDigits.join());
                                    navigateToHome();
                                  } catch (e) {
                                    setErrors(e);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    (_isCodeNumber && _error.isEmpty)
                                        ? AppColors.lightBlue
                                        : Colors.grey,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width - 40, 0),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Visibility(
                                    visible: !_isLoading,
                                    child: Text('Validar código',
                                        style: TextStyle(
                                            color: _isCodeNumber
                                                ? Colors.white
                                                : Colors.grey[600])),
                                  ),
                                  Visibility(
                                    visible: _isLoading,
                                    child: const CircularProgressIndicator(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _error.isEmpty
                              ? Container()
                              : Text(
                                  _error,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12.0),
                                ),
                          const SizedBox(height: 20.0),
                          Center(
                            child: Image.asset(
                              'assets/icon/logo-transparent.png',
                              width: 150,
                              height: 101,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNavigationBarApp()));
  }

  void getSmsCode(String verificationId) {
    setState(() {
      _isLoading = false;
      _wasCodeSentToUser = true;
      _verificationId = verificationId;
    });
  }

  void setErrors(dynamic e) {
    setState(() {
      e is FirebaseAuthException ? _error = Errors.getError(e.code)! : _error = Errors.getError("default")!;       
      _isLoading = false;
    });
  }

  Widget _buildDigitField(int index) {
    return SizedBox(
      width: 40,
      child: TextFormField(
        controller: _codeControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 24),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
          setState(() {
            _codeDigits[index] = value;
            _isCodeNumber = RegExp(r'[0-9]{6}').hasMatch(_codeDigits.join());
            _error = "";
          });
        },
        maxLength: 1,        
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    for (int i = 0; i < 6; i++) {
      _codeControllers[i].dispose();
    }
    super.dispose();
  }
}

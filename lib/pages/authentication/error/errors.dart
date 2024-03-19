class Errors {
  static const Map<String, String> errors = {
    'network-request-failed': 'Erro de conexão, tente novamente mais tarde.',
    'email-already-in-use':
        'Email já cadastrado. Caso não lembre a senha, clique em "Esqueci minha senha" na página de login.',
    'internal-error': 'Erro interno do servidor, tente novamente mais.',
    'invalid-credential': 'Email ou senha inválidos',
    'invalid-display-name': 'Nome inválido',
    'invalid-email': 'Email inválido',
    'invalid-password': 'Senha inválida',
    'operation-not-allowed': 'Operação não permitida',
    'too-many-requests':
        'Conta temporariamente suspensa devido a muitas tentativas de login malsucedidas. Você pode restaurá-la redefinindo sua senha ou tentar novamente mais tarde.',
    'user-disabled':
        'Conta desativada. Caso entenda que seja um engano, entre em contato com a secretaria da igreja.',
    'user-not-found': 'Usuário não encontrado',
    'weak-password': 'Senha fraca',
    'wrong-password': 'Senha incorreta',
    'invalid-phone-number': 'Número de telefone inválido',
    'invalid-verification-code': 'O Código informado está incorreto',
    'code-expired': 'Código expirado',
    'missing-client-identifier': 'Erro ao carregar verificador CAPTCHA',
    'ERROR_USER_NOT_FOUND': 'Usuário não encontrado',
    'unauthorized-phone-number': 'Número de telefone não autorizado, entre em contato com sua coordenadora.',
    'default': 'Erro desconhecido. Tente novamente mais tarde.',
  };

  static String? getError(String code) {
    return Errors.errors[code] ?? Errors.errors['default'];
  }
}

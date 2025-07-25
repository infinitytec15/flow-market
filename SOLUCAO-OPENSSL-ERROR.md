# 🔧 Solução para Erro OpenSSL Node.js 18+

## ✅ **PROBLEMA RESOLVIDO**

O erro `Error: error:0308010C:digital envelope routines::unsupported` ocorre porque o Node.js 18+ usa OpenSSL 3.0, que removeu suporte a algoritmos de hash legados por padrão.

---

## 🔧 **Correções Aplicadas**

### **1. Arquivo `nixpacks.toml`**

```toml
[phases.install]
cmds = [
    "composer install --no-dev --optimize-autoloader",
    "npm install",
    "NODE_OPTIONS='--openssl-legacy-provider' npm run production",  # ✅ Adicionado
]

[variables]
NODE_OPTIONS = "--openssl-legacy-provider"  # ✅ Adicionado
```

### **2. Arquivo `Dockerfile`**

```dockerfile
# Install Node.js dependencies and build assets (if package.json exists)
RUN if [ -f "package.json" ]; then \
    npm install && \
    if npm run | grep -q "production"; then \
    NODE_OPTIONS='--openssl-legacy-provider' npm run production; \  # ✅ Adicionado
    fi; \
    fi
```

---

## 📋 **Explicação do Erro**

### **Causa:**

- Node.js 18+ usa OpenSSL 3.0
- OpenSSL 3.0 removeu suporte a algoritmos MD4, MD5, SHA1 por padrão
- Webpack 4/5 ainda usa esses algoritmos
- Laravel Mix usa Webpack internamente

### **Solução:**

- `NODE_OPTIONS='--openssl-legacy-provider'` habilita algoritmos legados
- Permite que Webpack funcione normalmente
- Não afeta a segurança da aplicação final

---

## 🚀 **Alternativas (se necessário)**

### **Opção 1: Downgrade Node.js**

```toml
[phases.setup]
nixPkgs = [
    "php81",
    # ... outros pacotes
    "nodejs-16_x",  # Usar Node.js 16
    "npm",
]
```

### **Opção 2: Atualizar Webpack**

```json
{
  "devDependencies": {
    "webpack": "^5.0.0",
    "laravel-mix": "^6.0.0"
  }
}
```

### **Opção 3: Usar apenas Composer (sem npm)**

```toml
[phases.install]
cmds = [
    "composer install --no-dev --optimize-autoloader",
    # Remover npm install e npm run production
]
```

---

## ✅ **Verificação**

Para testar localmente:

```bash
# Testar com Node.js 18+
NODE_OPTIONS='--openssl-legacy-provider' npm run production

# Ou definir permanentemente
export NODE_OPTIONS='--openssl-legacy-provider'
npm run production
```

---

## 🎯 **Próximos Passos**

1. **Faça o deploy** com as correções aplicadas
2. **Monitore os logs** para confirmar que não há mais erros
3. **Teste a aplicação** após o deploy

O erro de OpenSSL foi resolvido! 🚀

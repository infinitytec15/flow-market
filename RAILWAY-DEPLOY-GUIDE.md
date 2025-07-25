# 🚀 Guia de Deploy no Railway - Flow Market

## ✅ **PROBLEMA RESOLVIDO: Dockerfile não encontrado**

O problema foi resolvido alterando a configuração para usar **Nixpacks** em vez de Dockerfile.

---

## 📋 **PASSO A PASSO ATUALIZADO**

### **1. BACKEND (pixer-api)**

#### **1.1 Preparar o Repositório**

- ✅ `railway.json` configurado com Nixpacks
- ✅ `nixpacks.toml` criado para configuração do PHP
- ✅ `health.php` criado para health check
- ✅ `.dockerignore` configurado

#### **1.2 Deploy no Railway**

1. Acesse [Railway Dashboard](https://railway.app/dashboard)
2. Clique em **"New Project"**
3. Selecione **"Deploy from GitHub repo"**
4. **IMPORTANTE**: Selecione o repositório e **não** a pasta `pixer-api`
5. Após conectar, vá em **"Settings"** → **"Root Directory"**
6. Defina o **Root Directory** como: `pixer-api`
7. Clique em **"Save"**

#### **1.3 Configurar Variáveis de Ambiente**

Vá em **"Variables"** e adicione:

```env
APP_NAME=Pixer
APP_ENV=production
APP_KEY=base64:sua_chave_aqui
APP_DEBUG=false
APP_URL=https://seu-backend.railway.app

DB_CONNECTION=mysql
DB_HOST=seu-mysql-host.railway.app
DB_PORT=3306
DB_DATABASE=railway
DB_USERNAME=root
DB_PASSWORD=sua_senha_mysql

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"
```

#### **1.4 Conectar Banco de Dados**

1. Vá em **"Connect"** → **"Database"**
2. Selecione o MySQL criado
3. As variáveis de banco serão configuradas automaticamente

#### **1.5 Deploy**

- O Railway irá detectar automaticamente que é um projeto PHP/Laravel
- Aguarde o build completar (pode demorar alguns minutos)
- Verifique os logs se houver problemas

---

### **2. FRONTEND SHOP**

#### **2.1 Deploy no Railway**

1. Crie **novo projeto** no Railway
2. Conecte o mesmo repositório
3. Defina **Root Directory** como: `shop`
4. O Railway detectará automaticamente que é Next.js

#### **2.2 Variáveis de Ambiente**

```env
NEXT_PUBLIC_API_URL=https://seu-backend.railway.app
NEXT_PUBLIC_APP_URL=https://seu-shop.railway.app
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=sua_chave_stripe
NEXT_PUBLIC_GOOGLE_MAPS_API_KEY=sua_chave_google_maps
```

---

### **3. FRONTEND ADMIN**

#### **3.1 Deploy no Railway**

1. Crie **novo projeto** no Railway
2. Conecte o mesmo repositório
3. Defina **Root Directory** como: `admin`
4. O Railway detectará automaticamente que é Next.js

#### **3.2 Variáveis de Ambiente**

```env
NEXT_PUBLIC_API_URL=https://seu-backend.railway.app
NEXT_PUBLIC_APP_URL=https://seu-admin.railway.app
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=sua_chave_stripe
NEXT_PUBLIC_GOOGLE_MAPS_API_KEY=sua_chave_google_maps
```

---

## 🔧 **COMANDOS PÓS-DEPLOY**

### **Backend (pixer-api)**

```bash
# Executar migrations
railway run php artisan migrate

# Limpar caches
railway run php artisan cache:clear
railway run php artisan config:clear
railway run php artisan route:clear
railway run php artisan view:clear

# Gerar chave da aplicação (se necessário)
railway run php artisan key:generate

# Ver logs
railway logs
```

### **Frontend**

```bash
# Ver logs
railway logs

# Rebuild se necessário
railway up
```

---

## 🚨 **TROUBLESHOOTING**

### **Problema: "Dockerfile não encontrado"**

**Solução**: ✅ Já resolvido usando Nixpacks

### **Problema: Build falha no PHP**

**Solução**:

1. Verifique se o `nixpacks.toml` está correto
2. Verifique os logs do build
3. Certifique-se de que o `composer.json` está válido

### **Problema: Variáveis de ambiente não carregam**

**Solução**:

1. Verifique se as variáveis estão no projeto correto
2. Reinicie o deploy após adicionar variáveis
3. Verifique se não há espaços extras nas variáveis

### **Problema: Banco de dados não conecta**

**Solução**:

1. Verifique se o MySQL está provisionado
2. Confirme as credenciais do banco
3. Teste a conexão via logs

---

## 📊 **MONITORAMENTO**

### **Health Checks**

- Backend: `https://seu-backend.railway.app/health.php`
- Shop: `https://seu-shop.railway.app/`
- Admin: `https://seu-admin.railway.app/`

### **Logs**

- Acesse cada projeto no Railway
- Vá em **"Deployments"** → **"View Logs"**
- Monitore em tempo real

---

## ✅ **CHECKLIST FINAL**

- [ ] Backend deployado com Nixpacks
- [ ] Root Directory configurado corretamente
- [ ] Variáveis de ambiente adicionadas
- [ ] Banco de dados conectado
- [ ] Migrations executadas
- [ ] Frontend Shop deployado
- [ ] Frontend Admin deployado
- [ ] Health checks funcionando
- [ ] URLs configuradas corretamente
- [ ] SSL/HTTPS ativo

---

## 🎯 **PRÓXIMOS PASSOS**

1. **Teste todas as funcionalidades**
2. **Configure domínios customizados** (opcional)
3. **Configure backups** do banco
4. **Monitore performance**
5. **Configure alertas**

O problema do Dockerfile foi resolvido! Agora você pode fazer o deploy seguindo este guia atualizado. 🚀

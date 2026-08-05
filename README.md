# 📻 Servidor Icecast2 no Render.com (HTTPS Gratuito para IMVU / Web)

Estrutura completa de arquivos Docker + Icecast2 com suporte automático a HTTPS/SSL gerenciado pelo **Render.com**. Ideal para transmissões de áudio ao vivo via **BUTT** ou **Mixxx** e compatível com o rádio HTML5 do **IMVU**.

---

## 📁 Arquivos do Projeto

- [`Dockerfile`](file:///g:/Radio/Dockerfile): Imagem Docker Alpine Linux ultra-leve (~20MB) com Icecast2.
- [`icecast.xml`](file:///g:/Radio/icecast.xml): Configuração pré-definida estática do Icecast.
- [`icecast.xml.template`](file:///g:/Radio/icecast.xml.template): Template de configuração com suporte a variáveis de ambiente dinâmicas.
- [`entrypoint.sh`](file:///g:/Radio/entrypoint.sh): Script de inicialização que injeta as senhas e ajusta permissões.

---

## 🚀 Passo a Passo: Subir no GitHub e Deploy no Render.com

### Passo 1: Subir os arquivos para o GitHub

1. Abra o terminal na pasta do seu projeto e execute os comandos:
   ```bash
   git init
   git add .
   git commit -m "Configuração inicial do Icecast2"
   ```
2. Crie um repositório no [GitHub](https://github.com/new) (exemplo: `icecast-stream`).
3. Vincule o repositório local e faça o push:
   ```bash
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/icecast-stream.git
   git push -u origin main
   ```

---

### Passo 2: Conectar ao Render.com (Serviço Web Gratuito)

1. Acesse [render.com](https://render.com) e crie uma conta gratuita.
2. No painel principal, clique em **New +** e selecione **Web Service**.
3. Conecte sua conta do GitHub e escolha o repositório `icecast-stream`.
4. Preencha as configurações do serviço:
   - **Name**: `minha-radio-icecast` (ou o nome de sua preferência)
   - **Language**: `Docker`
   - **Region**: Selecione qualquer uma (ex: *Oregon (US West)*)
   - **Instance Type**: **Free**
5. *(Recomendado)* Na seção **Environment Variables**, adicione suas senhas com segurança:
   - `ICECAST_SOURCE_PASSWORD`: `SuaSenhaSource123` (senha para o BUTT/Mixxx)
   - `ICECAST_ADMIN_PASSWORD`: `SuaSenhaAdmin123` (senha do painel web)
   - `ICECAST_ADMIN_USERNAME`: `admin`
6. Clique em **Create Web Service**.
7. Aguarde 2-3 minutos até o Render compilar o container Docker e indicar o status **Live**.

---

## 🔗 Identificando a URL HTTPS Final e Configurações

Depois que o deploy no Render for concluído, o Render gera automaticamente um link seguro HTTPS com SSL grátis (Let's Encrypt).

### 1. URL Final para o IMVU / Rádio HTML5
A URL do seu painel e stream será semelhante a:
- **Painel Web Admin**: `https://minha-radio-icecast.onrender.com`
- **Link do Stream MP3 (Usar no IMVU)**:
  ```text
  https://minha-radio-icecast.onrender.com/stream.mp3
  ```
  *(ou `https://minha-radio-icecast.onrender.com/stream`)*

> 💡 **Por que funciona no IMVU?**  
> O IMVU bloqueia links `http://` por segurança (Mixed Content). Como o Render entrega a porta `443` HTTPS nativa, o link `.mp3` acima funciona 100% sem erros de SSL no rádio HTML5 do IMVU.

---

### 2. Como Configurar no BUTT / Mixxx (Para Transmitir)

Abra o **BUTT (Broadcast Using This Tool)** ou **Mixxx** e adicione um novo servidor:

- **Server Type**: `Icecast`
- **Address / Server**: `minha-radio-icecast.onrender.com`
- **Port**: `443` *(ou 80)*
- **Use SSL/TLS**: ✅ **Marcado / Ativado** *(Necessário ao usar a porta 443)*
- **Type**: `Icecast`
- **Mount Point**: `/stream.mp3` *(ou `/stream`)*
- **User**: `source`
- **Password**: A senha que você definira em `ICECAST_SOURCE_PASSWORD` (ou a senha padrão do `icecast.xml`).

---

## 📌 Dicas Úteis
- **Modo Sleep do Render (Plano Free)**: Caso fique sem ouvintes por 15 minutos, o servidor gratuito pode entrar em repouso. Ao se conectar com o BUTT ou acessar a URL no navegador, ele acorda em cerca de 30 segundos.
- Para verificar logs em tempo real, use a aba **Logs** no painel do Render.

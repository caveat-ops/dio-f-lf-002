# 🌐 Provisionador Automático de Servidor Web Apache

> **Disclaimer:** Este projeto foi desenvolvido com o auxílio de inteligência artificial como acelerador de produtividade.  
> - **IA Utilizada:** [OpenCode](https://opencode.ai)  
> - **Modelo:** big-pickle  
> - **Plataforma:** OpenCode (plataforma de AI coding agent)  
> - **Metodologia:** Vibe coding - orientação passo a passo do agente de IA para implementação das funcionalidades.  
> - **Fins educacionais:** Este projeto faz parte de minha formação em cibersegurança e infraestrutura Linux. Todo o conteúdo aqui presente é para fins de aprendizado e demonstração de conceitos de Infraestrutura como Código (IaC).

---

## 📋 Descrição do Projeto

Este projeto implementa um script de provisionamento automático de servidor web Apache em container Docker, com suporte a Virtual Hosts e HTTPS/SSL via Let's Encrypt.

O objetivo é demonstrar conceitos de Infraestrutura como Código (IaC), automação de configuração de servidores web e deployment de aplicações web seguras.

---

## 🛠️ Tecnologias Utilizadas

| Categoria | Tecnologia |
|-----------|------------|
| **SO Base** | Debian (Docker) |
| **Servidor Web** | Apache2 |
| **Container** | Docker + Docker Compose |
| **SSL** | Let's Encrypt (Certbot) |
| **Linguagem** | Bash Script |

---

## 📁 Estrutura do Projeto

```
.
├── .env                    # Variáveis de ambiente
├── .gitignore              # Arquivos ignorados pelo git
├── Makefile                 # Comandos Make para automação
├── docker-compose.yml       # Orquestração dos containers
├── Dockerfile               # Imagem Docker do servidor web
├── scripts/
│   ├── provision.sh         # Script principal de provisionamento
│   ├── virtual-hosts.sh    # Gerenciamento de Virtual Hosts
│   ├── ssl.sh              # Configuração SSL/HTTPS
│   └── rollback.sh         # Script de rollback
├── config/
│   ├── apache2/
│   │   ├── ports.conf      # Configuração de portas
│   │   └── sites-available/
│   │       ├── 000-default.conf
│   │       └── default-ssl.conf
│   ├── html/
│   │   ├── site1/
│   │   │   └── index.html
│   │   └── site2/
│   │       └── index.html
│   └── ssl/                 # Certificados SSL (gerados)
└── logs/
    └── apache2/
```

---

## 🚀 Como Usar

### Pré-requisitos

- Docker Desktop ou Docker Engine
- Docker Compose
- Git

### Executando com Make

1. **Clone o repositório:**
```bash
git clone https://github.com/seu-usuario/apache-web-server.git
cd apache-web-server
```

2. **Configure as variáveis de ambiente:**
```bash
# Edite o arquivo .env com suas configurações
```

3. **Build e start dos containers:**
```bash
make build
make up
```

4. **Acesse o servidor:**
- HTTP: `http://localhost`
- Site 1: `http://site1.localhost`
- Site 2: `http://site2.localhost`

### Comandos Make Disponíveis

| Comando | Descrição |
|---------|-----------|
| `make build` | Build das imagens Docker |
| `make up` | Iniciar os containers |
| `make down` | Parar os containers |
| `make restart` | Reiniciar os containers |
| `make bash` | Acessar container Apache |
| `make logs` | Ver logs do Apache |
| `make logs-f` | Logs em tempo real (follow) |
| `make test` | Validar que servidor está respondendo |
| `make clean` | Remover containers, volumes, imagens e certificados |
| `make re` | Rebuild completo (clean + build + up) |
| `make ssl` | Configurar HTTPS com Let's Encrypt |

---

## 🔧 Funcionalidades

- ✅ Instalação automática do Apache2
- ✅ Suporte a Virtual Hosts (múltiplos sites)
- ✅ Configuração automática de SSL/HTTPS
- ✅ Certificados Let's Encrypt
- ✅ Container Docker reproduzível
- ✅ Script de rollback
- ✅ Logs centralizados

---

## 📝 Variáveis de Ambiente

| Variável | Descrição | Padrão |
|----------|-----------|--------|
| `SERVER_NAME` | Domínio principal | localhost |
| `EMAIL_SSL` | Email para Let's Encrypt | admin@localhost |
| `SITE1_NAME` | Nome do primeiro site | site1.localhost |
| `SITE2_NAME` | Nome do segundo site | site2.localhost |
| `HTTP_PORT` | Porta HTTP | 80 |
| `HTTPS_PORT` | Porta HTTPS | 443 |

---

## 📦 Containers

### Servidor Web Apache
- **Imagem:** Debian com Apache2
- **Portas:** 80, 443
- **Volumes:** HTML, logs, configuração

---

## 🔐 Segurança

- Arquivos `.env` contém credenciais sensíveis e estão no `.gitignore`
- SSL/TLS com certificados Let's Encrypt
- Configurações seguras do Apache

---

## 📄 Licença

Este projeto é para fins educacionais.

---

## 👨‍💻 Autor

Seu Nome - [GitHub](https://github.com/seu-usuario)

---

## 🙏 Agradecimentos

- [DIO - Digital Innovation One](https://www.dio.me/) pela formação Linux Fundamentals
- [OpenCode](https://opencode.ai/) pela assistência no desenvolvimento

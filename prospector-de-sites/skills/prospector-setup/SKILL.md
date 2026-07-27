---
name: prospector-setup
description: Configuração inicial do Prospector de Sites no Antigravity — coleta assinatura, nichos, cidade e conexão HostGator, e instala o painel local. Use quando o usuário disser "configurar prospector", "setup", "começar", "meus dados", ou na primeira vez que rodar qualquer skill do prospector sem um prospector-config.json.
---

# Prospector — configuração inicial (Antigravity)

Rode UMA vez. Salva tudo em `prospector-config.json` na pasta de trabalho do projeto.

## 1. Verificar config

Procure `prospector-config.json` na pasta do projeto. Se existir, mostre um resumo (SEM a senha) e pergunte o que atualizar. Se não existir, colete os dados abaixo.

## 2. Dados do usuário (pergunte em blocos curtos)

- **Assinatura da proposta**: nome completo, como se apresenta (ex.: "Designer de páginas de alta conversão") e WhatsApp `55DDDNUMERO`.
- **Nichos padrão**: sugira nutricionistas, psicólogos, advogados, psiquiatras — deixe editar.
- **Cidade/região padrão**.
- **Leads por busca**: padrão 10.
- **Modo de envio da proposta**: padrão "rascunho no Gmail para revisão".

## 3. Conexão HostGator

Se já contratou a hospedagem: **não colete a senha pelo chat**. Oriente a preencher no `prospector-config.json` (ou na aba Configurações do painel), os campos `usuario`, `dominio`, `servidor` e `senha` do cPanel. A senha vive só no arquivo local.

## 4. Salvar

`prospector-config.json` na pasta do projeto:

```json
{
  "assinatura": { "nome": "", "apresentacao": "", "whatsapp": "" },
  "prospeccao": { "nichos": ["nutricionistas","psicologos","advogados","psiquiatras"], "cidade": "", "leadsPorBusca": 10 },
  "envio": { "modo": "rascunho" },
  "hostgator": { "usuario": "", "dominio": "", "servidor": "", "senha": "", "pastaBase": "clientes" }
}
```

## 5. Painel local

Siga a skill `dashboard-leads` para copiar `dashboard-server.py` + o iniciador e criar o banco `prospector.db` e o `dashboard.html`. Explique: duplo clique no `iniciar-dashboard.bat` (Windows) / `.command` (Mac) abre o painel em http://localhost:8765 (precisa de Python no PATH).

## 6. Pré-requisitos do Antigravity (avise o usuário)

Esta versão usa três conectores. O CRM e o navegador vêm no `mcp_config.json` do próprio plugin; o Google Maps é um plugin bundled do Google.

1. **Plugin Google Maps Platform** — instale em Customizations → Build with Google (precisa de uma API key do Maps Platform). É a fonte oficial da busca de negócios (Places) usada pela skill `prospeccao-maps`. Sem ele, a prospecção cai para o modo navegador (raspar o Google Maps pelo Playwright).
2. **MCP de navegador (Playwright)** — abre os sites dos leads para avaliar a qualidade e achar o e-mail. Já declarado no `mcp_config.json` do plugin (ou adicione em Permissions → MCP Tools).
3. **MCP do Prospector CRM** (`prospector-mcp.py`) — administra os leads (listar, salvar, status, follow-ups, financeiro). Já declarado no `mcp_config.json` do plugin.
4. (Opcional) **MCP/plugin do Gmail** do Google — para criar o rascunho da proposta. Sem ele, a skill `proposta-gmail` usa um link de compose do Gmail.

## 7. Encerrar

Confirme o que foi salvo e explique o ciclo: **prospectar** (skill prospeccao-maps) → **redesenhar** (redesign-premium) → **publicar** (deploy-hostgator) → **proposta** (proposta-gmail), com o `dashboard.html` como painel de tudo.

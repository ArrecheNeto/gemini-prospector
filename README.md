# Prospector de Sites — Plugin para Google Antigravity

Prospecção semiautomática de clientes com site fraco, redesign premium, publicação na HostGator e proposta por e-mail — empacotado como **Plugin do Antigravity** (Agy 2.0 / IDE / CLI compartilham a mesma config).

É a mesma lógica da versão Claude, no formato nativo do Antigravity: um **plugin** (`plugin.json` + `mcp_config.json` + `skills/`). A busca de negócios usa o plugin oficial **Google Maps Platform** (Places); o navegador entra só pra avaliar o site do lead.

## Estrutura do plugin

```
prospector-de-sites/          ← esta é a pasta do plugin
├── plugin.json               marcador do plugin
├── mcp_config.json           define os MCP (CRM + navegador Playwright)
├── prospector-mcp.py         servidor MCP do CRM (SQLite)
├── skills/                   as 7 skills (SKILL.md)
│   ├── prospector-setup/
│   ├── prospeccao-maps/
│   ├── redesign-premium/
│   ├── proposta-gmail/
│   ├── deploy-hostgator/
│   ├── dashboard-leads/
│   └── contrato-servico/
└── dashboard/                painel local (Python/SQLite)
```

## Instalação

### 1. Instalar o plugin

Copie a pasta `prospector-de-sites/` inteira para um dos locais que o Antigravity varre:

- **Global (todos os projetos):** `~/.gemini/config/plugins/prospector-de-sites/`
  (no Windows: `C:\Users\SEU_USUARIO\.gemini\config\plugins\prospector-de-sites\`)
- **Só no projeto atual:** `.agents/plugins/prospector-de-sites/` na raiz do workspace aberto.

> Se a pasta `~/.gemini/config/plugins/` não existir ainda, crie ela. (Foi o erro "cannot find the path specified" que apareceu ao baixar um plugin bundled — o Antigravity espera essa pasta existir.)

As **skills** carregam sozinhas — não precisa copiar nada pra `~/.gemini/skills` na mão.

### 2. Ajustar o `mcp_config.json` do plugin

Abra `prospector-de-sites/mcp_config.json` e corrija os dois caminhos do `prospector-crm`:

- o caminho do `prospector-mcp.py` (dentro da pasta do plugin);
- o `--pasta` = a pasta do seu projeto (onde ficam `prospector.db`, os leads e os sites).

O Antigravity lê esse `mcp_config.json` do plugin automaticamente. Se preferir, dá pra adicionar/gerenciar os MCP pela interface: **Settings → Permissions → MCP Tools → Add** (nome + servidor).

### 3. Instalar o plugin Google Maps Platform (a fonte da prospecção)

Em **Settings → Customizations → Build with Google**, baixe o plugin **Google Maps Platform**. Ele dá as ferramentas de Places (buscar negócios, ler nota, nº de avaliações, site, telefone) que a skill `prospeccao-maps` usa. Precisa de uma **API key do Google Maps Platform** (tem cota grátis mensal).

> Sem o plugin do Maps, a prospecção ainda funciona no modo navegador (raspando o Google Maps pelo Playwright) — só é menos confiável.

### 4. Configurar o Prospector

Abra a pasta do projeto e diga no chat: **"configurar o prospector"**. A skill `prospector-setup` coleta seus dados, a conexão HostGator e instala o painel local.

## Como usar (linguagem natural)

1. **"prospecta nutricionistas em São Paulo"** → busca no Google Maps Platform, qualifica (nota alta + site ruim + e-mail) e monta o dashboard.
2. **"redesenha os 5 melhores"** → redesign premium + editor + comparador antes/depois.
3. **"publica na HostGator"** → sobe as páginas e a capa, verifica HTTPS.
4. **"manda a proposta"** → rascunho anti-spam no Gmail.
5. Depois: contrato, e o `dashboard.html` administra tudo (kanban + financeiro).

## Diferenças pra versão Claude

| | Claude Cowork | Antigravity |
|---|---|---|
| Empacotamento | plugin (.claude-plugin) | plugin (`plugin.json` + `mcp_config.json` + `skills/`) |
| Onde instala | marketplace | `~/.gemini/config/plugins/` (ou `.agents/plugins/`) |
| Comandos | `/prospectar`… | linguagem natural aciona a skill |
| Busca no Maps | Claude in Chrome | **plugin Google Maps Platform** (Places) + navegador |
| Navegador | Claude in Chrome | MCP Playwright / plugin Chrome DevTools |
| CRM | MCP stdio | mesmo MCP, no `mcp_config.json` do plugin |
| E-mail | conector Gmail | plugin/MCP Gmail do Google, ou link de compose |

Mesma lógica, mesmos entregáveis. O CRM (`prospector-mcp.py`), o painel e as templates são reaproveitados sem mudança.

---

Feito por **Helio Arreche**.

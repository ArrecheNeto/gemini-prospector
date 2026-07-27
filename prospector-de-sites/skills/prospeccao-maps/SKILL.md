---
name: prospeccao-maps
description: Esta skill deve ser usada ao prospectar clientes no Google Maps — buscar negócios bem avaliados com sites ruins, qualificar leads, avaliar qualidade de sites de terceiros e montar a planilha de leads. Acione quando o usuário disser "prospectar", "buscar clientes", "achar leads", "clientes com site ruim" ou pedir para prospectar (skill prospeccao-maps).
---

# Prospecção no Google Maps

Encontrar o cliente ouro: negócio que JÁ fatura bem (nota alta, muitas avaliações) mas perde clientes por causa de um site fraco. Não se cria demanda — conserta-se onde o dinheiro está escapando.

## Fluxo — busca via Google Maps Platform, avaliação via navegador

A busca dos negócios usa o **plugin Google Maps Platform** (Places), que já vem no Antigravity (Customizations → Build with Google) e é a fonte oficial — mais confiável que raspar a tela. O navegador (MCP Playwright ou plugin Chrome DevTools) entra só na etapa de avaliar o site e caçar o e-mail.

1. **Buscar os negócios (Google Maps Platform / Places):** faça a busca de texto por `[nicho] em [cidade]`. Para cada resultado, o Places já devolve `name`, `rating`, `user_ratings_total`, `website`, `formatted_phone_number` e endereço — sem abrir navegador.
   - **Filtro 1 — potencial financeiro**: `rating` ≥ 4.7 E `user_ratings_total` ≥ 40. Reprovou → próximo.
   - **Filtro 2 — TEM site próprio**: precisa de `website` preenchido e que NÃO seja Instagram/Facebook/linktree/diretório de terceiros. Sem site ou só rede social → descartar (registrar o motivo) e seguir.
   > Se o plugin Google Maps Platform não estiver instalado/configurado (precisa de uma API key do Maps Platform), caia para o modo navegador: abra `https://www.google.com/maps`, busque `[nicho] em [cidade]` e leia nota/avaliações/site de cada perfil pelo MCP de navegador (Playwright).
2. **Avaliar o site + achar o e-mail (navegador):** para cada candidato que passou nos filtros 1 e 2, abra o `website` pelo MCP de navegador e:
   - **Filtro 3 — site ruim**: avalie pelos critérios abaixo. Site bom → descartar. Site ativo porém ruim → candidato.
   - Procure o e-mail público (obrigatório — ver abaixo) e o WhatsApp.
3. Parar ao atingir a meta de leads qualificados (config, padrão 10) ou após avaliar 25 estabelecimentos.
4. Pular estabelecimentos que já estão em `leads.md` (avaliados em buscas anteriores).

## Critérios de site ruim (guardar o motivo específico)

Qualifica como lead se o site (ativo) tiver 2 ou mais destes problemas:

- Layout datado (aparência de template de 10+ anos, fontes de sistema, imagens esticadas/pixeladas)
- Sem CTA claro de agendamento/contato (nenhum botão de WhatsApp ou agenda visível na primeira dobra)
- Domínio gratuito ou hospedado em plataforma alheia (Google Sites, Wix grátis, subdomínio de terceiros com marca da plataforma)
- Não responsivo (quebra no mobile)
- Conteúdo desorganizado: serviços escondidos, sem hierarquia, texto corrido sem seções
- Sem prova social (nenhuma avaliação/depoimento, apesar da nota alta no Google)

O motivo anotado deve ser objetivo e verificável — ele será citado na proposta. Ex.: "domínio redireciona para Google Sites gratuito, template básico, sem CTA de agendamento".

## Coleta por lead

Nome, nota, nº de avaliações, telefone, WhatsApp, e-mail, URL do site, motivo.

**WHATSAPP: capture SEMPRE, separado do telefone.** Fontes, na ordem: botão/link de WhatsApp no site do lead (procure `wa.me/`, `api.whatsapp.com` ou ícone de WhatsApp — extraia o número do link); telefone celular do perfil do Maps (números com 9º dígito são celular no Brasil — assuma WhatsApp). Registre no formato internacional `55 + DDD + número` (ex.: `5511999990000`), pronto pra `wa.me`. O WhatsApp alimenta os botões do dashboard e o plano B de abordagem quando o e-mail não responde.

**E-MAIL É OBRIGATÓRIO.** A proposta vai por e-mail — lead sem e-mail público não fecha o ciclo. Procure nesta ordem: site (rodapé e página de contato), links `mailto:`, home do site da clínica onde atende, busca no Google por "[nome] + email/contato". Se NÃO encontrar e-mail: **descarte o lead, registre na lista de descartados (com o contato que existir, ex. WhatsApp/Instagram) e continue buscando o próximo** até bater a meta. Atenção: "site" que aponta para diretório de terceiros (localtreino, acheioprofissional etc.) não conta como site próprio — descarta pelo Filtro 2.

## Saída — Google Sheets + leads.md local

Destino principal: PLANILHA DO GOOGLE (via conector do Google Drive: `create_file` com CSV em `textContent` e `contentMimeType: text/csv` — converte automaticamente para Sheets). Título `Leads Prospector — [nicho] [cidade]`; incluir qualificados e descartados, ranqueados por potencial (nota alta + site pior). Entregar o link ao usuário.

Cópia de trabalho local `leads.md` (mesmas colunas) para controle de status, já que o conector do Drive não edita células:

```markdown
| # | Nome | Nota | Aval. | E-mail | Telefone | Site atual | Motivo | Status | URL nova |
```

Status possíveis: `novo`, `redesenhado`, `publicado`, `proposta enviada`. Quando um status mudar (redesenhar → publicar → proposta), regenerar a planilha do Google com os dados acumulados e atualizar o `dashboard.html` (skill `dashboard-leads`). Nunca sobrescrever leads antigos — apenas acrescentar e atualizar.

## Boas práticas

- Trabalhar por região dá vantagem: menos concorrência na oferta e conhecimento local.
- Enquanto o navegador trabalha, não interromper o fluxo com perguntas — só reportar a tabela final.
- Se o Google Maps pedir login/captcha, pausar e avisar o usuário.

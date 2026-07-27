---
name: contrato-servico
description: Esta skill deve ser usada ao gerar contratos de prestação de serviço para clientes fechados — criação/redesign de site, publicação e manutenção. Acione quando o usuário disser "contrato", "gerar contrato", "formalizar", "cliente fechou", "enviar contrato" ou pedir o contrato (skill contrato-servico).
---

# Contrato de prestação de serviço

Gerar a minuta do contrato do serviço fechado (redesign + publicação de página, com manutenção opcional), pronta pra virar PDF e ir por e-mail.

## Fonte dos dados (nesta ordem)

1. **Banco (`prospector.db`)**: nome do cliente, cidade, valor fechado, URL publicada.
2. **Config (`prospector-config.json`)**: dados do PRESTADOR — nome, CPF/CNPJ, endereço, cidade/UF (campo `contratante`; se não existir, colete do usuário UMA vez e salve).
3. **Usuário** (ele pergunta ao cliente): CPF/CNPJ e endereço do CONTRATANTE, forma de pagamento, prazo, manutenção mensal (sim/não + valor).

## Geração

- Template: `references/contrato-template.html` — arquivo único com CSS A4 de impressão. Substituir todos os `{{PLACEHOLDERS}}`; conferir que nenhum sobrou (busca por `{{`).
- Salvar em `sites/[slug]/contrato-[slug].html`. PDF: abrir no navegador → Ctrl+P → Salvar como PDF (informe isso ao usuário).
- Cláusulas parametrizáveis: manutenção mensal (incluir só se contratada) e parcelamento (texto muda conforme forma de pagamento).

## DOCX travado (o arquivo que vai pro cliente)

Script pronto: `references/gerar-docx.py` (requer `python-docx`). Recebe `dados.json` (mesmas chaves do template HTML + `MANUTENCAO: true/false` e `VALOR_MANUTENCAO`) e gera o .docx com proteção `readOnly` + regiões editáveis (`permStart/permEnd`, grupo everyone) nos pontos do cliente: CPF/CNPJ e endereço quando vierem como "(preencher)", data e assinatura — destacados em amarelo. Limitação honesta (avise o usuário 1 vez): a proteção do Word é dissuasória, guia o preenchimento mas não impede quem quiser desativá-la; para validade forte, assinatura eletrônica (gov.br, Autentique).

## E-mail de envio (rascunho no Gmail)

Assunto: `Contrato de prestação de serviço — nova página [Nome do negócio]`. Corpo (adaptar à voz do usuário): agradecer a confiança, resumir em 2 linhas o combinado (escopo + valor + prazo), pedir que leia a minuta anexa e responda com um "de acordo" (ou assine digitalmente, se o usuário usar alguma ferramenta), e fechar com a assinatura do config. Instruir o usuário a ANEXAR o PDF exportado antes de enviar.

## Limites

- SEMPRE manter o aviso do rodapé: minuta base, recomenda-se revisão por advogado.
- Não prometer validade jurídica nem substituir assinatura formal; se o usuário pedir assinatura eletrônica, sugerir que suba o PDF na ferramenta dele (gov.br, Autentique etc.).
- Nunca inventar cláusula financeira: tudo vem do banco/usuário.

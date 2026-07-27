---
name: redesign-premium
description: Esta skill deve ser usada ao redesenhar o site de um cliente prospectado — criar uma versão nova, premium e de alta conversão da página existente, mantendo conteúdo, logo e paleta do cliente. Acione quando o usuário disser "redesenhar site", "melhorar página", "refazer o site do cliente" ou pedir para redesenhar (skill redesign-premium).
---

# Redesign premium de páginas

Criar uma NOVA VERSÃO da página do cliente — não uma página nova. O cliente precisa reconhecer o próprio negócio, só que elevado ao padrão que o faturamento dele merece.

## Regras invioláveis

1. **Nenhum FATO inventado — mas o texto deve ser APRIMORADO.** Todo serviço, credencial, número, endereço e contato vem do site original (ou do perfil do Google). Sem dados fictícios, sem depoimentos criados, sem serviços que o cliente não oferece. Porém o TEXTO não é copiado cru: reescreva com copy melhor — títulos mais fortes, frases mais claras, hierarquia de leitura — sempre dizendo a mesma verdade que o original diz.
2. **Fotos e logo originais são OBRIGATÓRIOS no site novo.** Toda foto utilizável do site existente (profissional, consultório, logo) deve constar na página nova, pelas URLs originais (colete via `img.currentSrc` no navegador, rolando a página inteira para vencer lazy-load). O cliente precisa se reconhecer na hora.
3. **Identidade preservada.** Manter logo, paleta de cores e fotos do cliente. Se a paleta original for fraca (ex.: cores puras saturadas), refinar os tons — nunca trocar a família de cores.
4. **Mais completo que o original.** O site novo deve ser MUITO mais profissional e bem estruturado. Se o original tem poucas seções, CRIE as seções relevantes que faltam — desde que preenchidas só com informação real: prova social (nota + avaliações reais do Google), "como funciona o atendimento" (se dedutível do original), localização com mapa, horários (do perfil do Maps), FAQ com dúvidas respondíveis pelo conteúdo real. Seção que exigiria inventar fato = não criar.
5. **Arquivo único.** `sites/[slug]/[slug].html` autocontido: CSS inline no `<head>`, sem build, sem dependências além de Google Fonts.
6. **Responsividade TOTAL (inegociável).** A página será vista no celular do cliente E dentro da moldura da página-capa (~1000-1500px). Ela deve ser perfeita em QUALQUER largura: 360, 375, 768, 1024, 1280 e 1440px — sem rolagem horizontal, sem texto vazando, sem imagem esticada, sem seção quebrada em nenhum desses pontos. Usar grid/flex fluidos, `clamp()` para tipografia e breakpoints testados um a um. Página que quebra em alguma largura NÃO é entregue.
7. **Editor sempre.** Todo redesign gera junto o `sites/[slug]/[slug]-editor.html` (camada de edição de `references/editor-visual.md`) — nunca entregar página sem a versão editável.
8. **Comparador sempre.** Todo lote de redesign termina com `comparar.html` na raiz da pasta conectada, gerado a partir de `references/comparador-template.html` (substituir `__CLIENTES__` pelo array JSON; mesclar com clientes já existentes). A entrega padrão de cada cliente são 3 arquivos: página + editor + aba no comparador.

## Estrutura da página (adaptar à profissão)

1. **Hero**: nome + especialidade, promessa clara em 1 linha, CTA primário (WhatsApp) visível sem rolar, foto do profissional/clínica.
2. **Prova social**: nota do Google em destaque ("5.0 ★ · 121 avaliações no Google") — é real e verificável. Citar 2-3 trechos de avaliações reais do Google Maps se coletados.
3. **Serviços/áreas de atuação**: cards clicáveis — cada card leva à âncora da seção detalhada ou direto ao WhatsApp com mensagem pré-preenchida (`https://wa.me/55DDDNUMERO?text=Olá! Vim pelo site e quero saber sobre [serviço]`).
4. **Sobre**: formação e credenciais reais (geram autoridade — nunca cortar).
5. **Oferta estruturada** (quando fizer sentido): transformar "agende uma consulta" em opções de engajamento (ex.: sessão pontual, acompanhamento 90 dias, plano semestral) — SEM preços, apenas nomes e o que incluem, todos levando ao WhatsApp. Só criar planos que sejam agrupamento óbvio do serviço já oferecido.
6. **Localização e contato**: endereço, mapa (iframe do Google Maps), horários, telefone, redes.
7. **Rodapé**: dados do profissional (registro de classe se existir no original).

## Copywriting (aprimorar sem inventar — reescrever é obrigatório)

O texto do site novo NUNCA é o texto do site velho colado. Reescreva tudo com técnica, dizendo apenas o que o cliente já diz/oferece:

- **Headline do hero = benefício, não rótulo.** "Nutrição esportiva em SP" é rótulo; "Seu treino merece resultados que aparecem" é headline (com o rótulo virando kicker/subtítulo pra SEO).
- **Estrutura PAS suave** ao longo da página: toque na dor real do público, mostre o caminho, apresente o serviço como solução — no tom do nicho, sem agressividade de lançamento.
- **Escaneabilidade**: ninguém lê parágrafo de 8 linhas. Quebre em blocos de 2-3 linhas, bullets com verbo, subtítulos que contam a história sozinhos (quem só lê os títulos entende a página).
- **1 CTA por dobra**, sempre orientado à ação e ao benefício ("Quero minha avaliação" > "Clique aqui"), todos pro WhatsApp com mensagem pré-preenchida contextual.
- **Prova social costurada**, não empilhada: nota do Google perto do CTA, citação real perto da seção a que se refere.
- **Microcopy**: legendas sob botões ("resposta em poucos minutos"), rótulos humanos em formulários e seções.
- Proibido: clichês vazios ("qualidade e compromisso", "excelência no atendimento") sem fato que os sustente; superlativos inventados; promessas de resultado que o cliente não faz.

## Barra de qualidade estrutural (o "profissional de verdade")

A página pronta deve parecer feita por um estúdio de design — teste honesto: colocada ao lado de um template premium do nicho (clínicas/consultórios de alto padrão), ela não pode dever nada. Isso significa: grid consistente (mesmo espaçamento entre TODAS as seções), alinhamento impecável, alternância de ritmo entre seções (fundo claro/escuro/acento, largura cheia/contida), imagens com tratamento coerente (mesmo raio de borda, mesma temperatura), tipografia com no máximo 2 famílias e escala harmônica, e nenhuma seção "órfã" que pareça colada de outro site.

## Padrão estético

- Tipografia: uma serifada elegante para títulos (Playfair Display, Fraunces, Lora) + uma sans limpa para corpo (Inter, Sora, DM Sans), pesos 400/600. Hierarquia forte: h1 ≥ 40px desktop / 30px mobile.
- Espaçamento generoso: seções com 80-120px de respiro vertical desktop; nada encostado.
- Paleta: 1 cor da marca + neutros quentes + 1 tom de destaque para CTA. Contraste AA no mínimo.
- Botão de WhatsApp flutuante fixo no canto inferior direito.
- Micro-toques premium: bordas 12-16px, sombras suaves, transições de 0.2s em hovers. Sem carrosséis, sem animações pesadas, sem JS além do essencial.
- Velocidade: página deve abrir instantânea — sem bibliotecas, sem fontes além de 2 famílias.

## Checklist final (obrigatório antes de entregar)

- [ ] Zero texto placeholder / lorem ipsum
- [ ] Todos os links e CTAs apontam para contato REAL do cliente
- [ ] Número do WhatsApp no formato wa.me correto (55 + DDD + número)
- [ ] Responsivo verificado em 360, 375, 768, 1024, 1280 e 1440px — zero rolagem horizontal e zero quebra em TODAS
- [ ] Título e meta description preenchidos com nome + especialidade + cidade
- [ ] Comparação com o original: todo conteúdo importante do site antigo está presente
- [ ] Logo e fotos ORIGINAIS do cliente presentes na página nova
- [ ] `[slug]-editor.html` gerado e `comparar.html` atualizado

## Editor visual e comparador

A camada de edição visual (para gerar `[slug]-editor.html`) está em `references/editor-visual.md` — injetar o script exatamente como documentado lá. O comparador antes/depois está em `references/comparador-template.html` — substituir `__CLIENTES__` pelo array JSON e salvar como `comparar.html` na raiz da pasta conectada (mesclando com clientes existentes).

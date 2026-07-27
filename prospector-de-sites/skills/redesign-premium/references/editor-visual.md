# Camada de edição visual

Para gerar `editor.html`: copie o `index.html` do cliente e injete o bloco abaixo imediatamente antes de `</body>`. Não altere mais nada na página.

Como funciona para o usuário:
- Clicar em qualquer texto → edita direto na página (contenteditable).
- Clicar em qualquer imagem → seletor de arquivo; a imagem escolhida é embutida em base64.
- Barra fixa no topo com "Exportar página" → baixa o HTML limpo (sem a camada de edição), pronto para substituir o `index.html` e publicar.

```html
<!-- PROSPECTOR-EDITOR-START -->
<style id="pe-style">
#pe-bar{position:fixed;top:0;left:0;right:0;z-index:99999;background:#111;color:#fff;font:14px/1 -apple-system,Segoe UI,Roboto,sans-serif;display:flex;align-items:center;gap:16px;padding:10px 16px;box-shadow:0 2px 8px rgba(0,0,0,.3)}
#pe-bar button{background:#22c55e;color:#fff;border:0;border-radius:8px;padding:8px 16px;font-weight:600;cursor:pointer}
#pe-bar button:hover{background:#16a34a}
body{margin-top:44px !important}
.pe-hover{outline:2px dashed #22c55e !important;outline-offset:2px;cursor:pointer}
[contenteditable="true"]:focus{outline:2px solid #3b82f6 !important;outline-offset:2px}
</style>
<div id="pe-bar">
  <strong>Modo edição</strong>
  <span>Clique em textos para editar · clique em imagens para trocar</span>
  <button id="pe-export" type="button">Exportar página</button>
</div>
<input type="file" id="pe-file" accept="image/*" style="display:none">
<script id="pe-script">
(function(){
  var TEXT='h1,h2,h3,h4,h5,h6,p,li,a,span,button,td,th,figcaption,blockquote,strong,em';
  document.querySelectorAll(TEXT).forEach(function(el){
    if(el.closest('#pe-bar'))return;
    if(el.children.length===0||el.childElementCount<=1){
      el.addEventListener('click',function(e){
        if(el.tagName==='A'||el.tagName==='BUTTON')e.preventDefault();
        el.setAttribute('contenteditable','true');el.focus();
      });
      el.addEventListener('mouseenter',function(){el.classList.add('pe-hover')});
      el.addEventListener('mouseleave',function(){el.classList.remove('pe-hover')});
      el.addEventListener('blur',function(){el.removeAttribute('contenteditable')});
    }
  });
  var fileInput=document.getElementById('pe-file'),currentImg=null;
  document.querySelectorAll('img').forEach(function(img){
    img.addEventListener('click',function(e){e.preventDefault();e.stopPropagation();currentImg=img;fileInput.click()});
    img.addEventListener('mouseenter',function(){img.classList.add('pe-hover')});
    img.addEventListener('mouseleave',function(){img.classList.remove('pe-hover')});
  });
  fileInput.addEventListener('change',function(){
    var f=fileInput.files[0];if(!f||!currentImg)return;
    var r=new FileReader();
    r.onload=function(){currentImg.src=r.result;if(currentImg.srcset)currentImg.removeAttribute('srcset')};
    r.readAsDataURL(f);fileInput.value='';
  });
  document.getElementById('pe-export').addEventListener('click',function(){
    var doc=document.documentElement.cloneNode(true);
    ['#pe-bar','#pe-style','#pe-script','#pe-file'].forEach(function(s){var n=doc.querySelector(s);if(n)n.remove()});
    doc.querySelectorAll('[contenteditable]').forEach(function(n){n.removeAttribute('contenteditable')});
    doc.querySelectorAll('.pe-hover').forEach(function(n){n.classList.remove('pe-hover')});
    var html='<!DOCTYPE html>\n'+doc.outerHTML;
    var blob=new Blob([html],{type:'text/html'});
    var a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='index.html';a.click();
  });
})();
</script>
<!-- PROSPECTOR-EDITOR-END -->
```

Observações:
- Imagens trocadas ficam em base64 dentro do arquivo — o HTML exportado cresce, mas continua autocontido e publicável.
- O comentário `PROSPECTOR-EDITOR-START/END` permite localizar e remover o bloco programaticamente se necessário.

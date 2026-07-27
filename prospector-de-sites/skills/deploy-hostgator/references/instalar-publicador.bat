@echo off
title Prospector de Sites - instalar publicador automatico
echo.
echo  Este instalador cria uma tarefa do Windows que verifica a cada 1 minuto
echo  se ha sites na fila e publica sozinho na HostGator. Sem janelas, sem cliques.
echo.
schtasks /Create /F /TN "ProspectorPublicador" /SC MINUTE /MO 1 /TR "wscript.exe \"%~dp0publicador-oculto.vbs\""
if %errorlevel%==0 (
  echo.
  echo  [OK] Publicador automatico instalado! Pode fechar esta janela.
  echo  Para desinstalar um dia: schtasks /Delete /TN ProspectorPublicador /F
) else (
  echo.
  echo  [ERRO] Nao consegui criar a tarefa. Feche e execute este arquivo
  echo  com botao direito ^> "Executar como administrador".
)
echo.
pause

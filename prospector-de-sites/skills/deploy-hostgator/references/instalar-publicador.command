#!/bin/bash
# Prospector de Sites — instala o publicador automatico no Mac (launchd, 1x na vida).
cd "$(dirname "$0")"
PASTA="$(pwd)"
PLIST="$HOME/Library/LaunchAgents/com.prospector.publicador.plist"
mkdir -p "$HOME/Library/LaunchAgents"
cat > "$PLIST" <<PLISTEOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>Label</key><string>com.prospector.publicador</string>
  <key>ProgramArguments</key><array>
    <string>/bin/bash</string>
    <string>$PASTA/publicar-agora.command</string>
    <string>--auto</string>
  </array>
  <key>StartInterval</key><integer>60</integer>
  <key>RunAtLoad</key><true/>
</dict></plist>
PLISTEOF
launchctl unload "$PLIST" 2>/dev/null
if launchctl load "$PLIST"; then
  echo "[OK] Publicador automatico instalado! A cada 1 minuto ele verifica a fila e publica sozinho."
  echo "Para desinstalar um dia: launchctl unload \"$PLIST\" && rm \"$PLIST\""
else
  echo "[ERRO] Nao consegui registrar. Rode este arquivo de novo ou me mande o erro acima."
fi
read -p "Pressione Enter para fechar..."

' Prospector de Sites - executa o publicador sem janela (tarefa agendada)
Set fso = CreateObject("Scripting.FileSystemObject")
pasta = fso.GetParentFolderName(WScript.ScriptFullName)
cmd = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & pasta & "\publicar-agora.ps1"" -Auto"
CreateObject("Wscript.Shell").Run cmd, 0, False

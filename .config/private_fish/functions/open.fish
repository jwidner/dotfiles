function open --wraps='powershell.exe -Command Start-Process' --description 'alias open powershell.exe -Command Start-Process'
  powershell.exe -Command Start-Process $argv; 
end

def find_rmxp
  path = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
  Win32::Registry::HKEY_LOCAL_MACHINE.open(path) do |reg|
    reg.each_key do |key, wtime|
      reg.open(key) do |sub|
        begin
          if sub['DisplayName'] == "RPG Maker XP"
            return File.join(sub['InstallLocation'], "RPGXP.exe")
          end
        rescue Win32::Registry::Error
        end
      end
    end
  end
end

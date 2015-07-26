return unless platform_family?('mac_os_x')

execute 'switch to login window' do
  command 'sudo "/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'
end

execute 'login to gui' do
  command <<EOF
osascript -e '
  tell application "System Events"
    keystroke "vagrant"
    keystroke return
    delay 3.0
    keystroke "vagrant"
    delay 3.0
    keystroke tab
    keystroke return
    keystroke return
  end tell'
EOF
end

execute 'wait for login to build remote desktop db' do
  command 'sleep 15'
  not_if { ::File.exist?('/Library/Application Support/com.apple.TCC/TCC.db') }
end

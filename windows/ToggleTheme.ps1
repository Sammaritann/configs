$RegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$OldValue = Get-ItemPropertyValue -Path $RegistryPath -Name AppsUseLightTheme
$NewValue = If ($OldValue -eq "0" ) {1} Else {0}
Set-ItemProperty -Path $RegistryPath -Name AppsUseLightTheme -Value $NewValue
Set-ItemProperty -Path $RegistryPath -Name SystemUseLightTheme -Value $NewValue
Set-ItemProperty -Path $RegistryPath -Name SystemUsesLightTheme -Value $NewValue

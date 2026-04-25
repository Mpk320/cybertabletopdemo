(netsh wlan show profiles) | Select-String 'All User Profile' | ForEach-Object {
    $profile = ($_ -split ':')[1].Trim()
    $key = (netsh wlan show profile name="$profile" key=clear) | Select-String 'Key Content'
    [PSCustomObject]@{
        SSID = $profile
        Password = if ($key) { ($key -split ':')[1].Trim() } else { '(none)' }
    }
} | Format-Table -AutoSize

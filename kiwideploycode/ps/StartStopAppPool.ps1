Param(
[string]$StartStop
)

$AppPool = "kiwiservicesAppPool"

if ($StartStop.ToLower() -eq "stop") {
    Write-Host "Stopping AppPool: $AppPool"
    Stop-WebAppPool -name $AppPool;
}
elseif ($StartStop.ToLower() -eq "start") {
    $i = 1
    Do {
        Write-Host "Iteraction $i, Starting AppPool: $AppPool"  
        Start-WebAppPool -name $AppPool; 
        Start-Sleep -s 1; # Sleep for 1 second
        $WAP = Get-WebAppPoolState -Name $AppPool;
        $i++ 
    }
    While ( ($WAP.Value -ne 'Started') -and ($i -le 5) )
}
else {
    Write-Host "No argument passed for start and stop"  
}

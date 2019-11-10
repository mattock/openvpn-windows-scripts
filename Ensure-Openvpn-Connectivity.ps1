param(
    [string] $pingDestination,
    [string] $servicename = "OpenVPNService",
    [int] $pingCount = 10,
    [int] $pingDelay = 3
)
<#
.SYNOPSIS
    Ensure that OpenVPN service is always available

.DESCRIPTION
    Check the status of OpenVPNService and connectivity against a given host. If service is
    down or connectivity is not there, restart OpenVPNService.

.PARAMETER pingDestination
    Host to ping against to determine if connectivity is there.

.PARAMETER pingCount
    Number of pings to send.

.PARAMETER pingDelay
    Delay between pings.
#>

# Check if service is up. If not, restart it.
if ((Get-Service $serviceName).Status -ne "Running") {
    date >> Ensure-OpenVPN-Connectivity.log
    Write-Output "Service ${serviceName} not up, restarting it." >> Ensure-OpenVPN-Connectivity.log
    Start-Service $serviceName
    Exit 0
}

# Check if connectivity works. If not, restart the service.
if (! (Test-Connection -Count $pingCount -Delay $pingDelay -Destination $pingDestination)) {
    date >> Ensure-OpenVPN-Connectivity.log
    Write-Output "Connectivity test failed. Restarting service ${serviceName}." >> Ensure-OpenVPN-Connectivity.log
    Restart-Service $serviceName
    Exit 0
}

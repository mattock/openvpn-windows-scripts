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
    Write-Host "Service ${serviceName} not up, restarting it."
    Start-Service $serviceName
    Exit 0
}

# Check if connectivity works. If not, restart the service.
if (! (Test-Connection -Count $pingCount -Delay $pingDelay -Destination $pingDestination)) {
    Write-Host "Connectivity test failed. Restarting service ${serviceName}."
    Restart-Service $serviceName
    Exit 0
}

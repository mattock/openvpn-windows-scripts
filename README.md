# openvpn-windows-scripts

Assorted scripts for use with OpenVPN on Windows.

# Scripts

## Ensure-Openvpn-Connectivity.ps1

This script can be used to ensure that an OpenVPN connection is always up. The
script can be run from a scheduled task, for example, to convert it to a
primitive monitoring tool. The script monitors two things:

1. Ensures that the service (default: "OpenVPNService") is running
1. Ensures that connectivity is ok (ping test against a defined host)

If either of these checks fail, the service is restarted under the assumption
that the OpenVPN is no longer functioning.

The benefit of using this script over [nssm](https://nssm.cc/) is that we can
run ping tests. If monitoring the status of OpenVPN is enough, then nssm is a
better choice.

At minimum you need one parameter, -pingDestination. Its value can be any host
(IP or name) reachable only through a/the VPN tunnel. Examples:

    Ensure-Openvpn-Connectivity -pingAddress 10.174.1.1

Ping counts and delay can be customized:

    Ensure-Openvpn-Connectivity -pingAddress 10.174.1.1 -pingCount 10 -pingDelay 6

You can also override the default service name which is OpenVPNService:

    Ensure-Openvpn-Connectivity -pingAddress 10.174.1.1 -serviceName OpenVPNServiceLegacy



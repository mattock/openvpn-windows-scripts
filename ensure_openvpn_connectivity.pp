$basepath = 'C:\Programdata'
$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
$taskname = 'puppet_ensure_openvpn_connectivity'
$pingdestination = '10.194.1.1'

dsc_scheduledtask { $taskname:
  dsc_ensure                  => 'present',
  dsc_enable                  => true,
  dsc_taskname                => $taskname,
  dsc_description             => 'Ensure that OpenVPN connection is always up',
  dsc_actionexecutable        => $powershell,
  dsc_actionarguments         => "${basepath}\Ensure-Openvpn-Connectivity.ps1 -pingDestination ${pingdestination}",
  dsc_waketorun               => true,
  dsc_allowstartifonbatteries => true,
  dsc_multipleinstances       => 'IgnoreNew',
  dsc_actionworkingpath       => $basepath,
  dsc_scheduletype            => 'Daily',
  dsc_startwhenavailable      => true,
  dsc_starttime               => '12:54 PM',
  dsc_executiontimelimit      => '00:04:00',
  dsc_repeatinterval          => '00:05:00',
  dsc_repetitionduration      => '23:55:00',
}

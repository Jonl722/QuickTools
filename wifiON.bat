@echo off

rem from command prompt: WIFI (ENABLE | DISABLE)

rem  bat variables
rem  zzid- unique number
rem  zztmpf- temporary unique file path
rem  zname- file name of the bat file (no path info)
for %%t in (%0) do set zzname=%%~nt
set zzid=%zzname%%daterem ~6,4%%daterem ~3,2%%daterem ~0,2%%timerem ~0,2%%timerem ~3,2%%timerem ~6,2%%timerem ~9,2%
set zztmpf="%tmp%\%zzid%"

rem  get a list of network devices and push the wireless one into a file
rem  if you have more than one wireless devices then this might not work
wmic nic get name, index | find /i "wireless" > %zztmpf%

rem  move contents of output to variable
set /p v_idx= < %zztmpf%
del %zztmpf%
rem  keep first 7 chars
set v_idx=%v_idxrem ~0,7%
rem  remove spaces
set v_idx=%v_idxrem  =%

rem  we now have the wireless controler's index number in v_idx

rem  enable adapter (ie switch on)
wmic path win32_networkadapter where index=%v_idx% call enable

rem httprem //answers.microsoft.com/en-us/windows/forum/windows_7-hardware/enabledisable-network-interface-via-command-line/17a21634-c5dd-4038-bc0a-d739209f5081?auth=1
rem httprem //www.hanselman.com/blog/HowToConnectToAWirelessWIFINetworkFromTheCommandLineInWindows7.aspx
rem the above link to investigate CLI connection to specific WLAN

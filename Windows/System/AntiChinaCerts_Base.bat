:: AntiChinaCerts Base batch
:: Anti China Certifications.
:: 
:: Author: Chengr28
:: 

@echo off

:: Permission check
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (set SystemPath = %SystemRoot%\SysWOW64) else (set SystemPath = %SystemRoot%\system32)
::rd "%SystemPath%\Test_Permissions" > nul 2 > nul
::md "%SystemPath%\Test_Permissions" 2 > nul || (echo Require Administrator Permission. && pause > nul && Exit)
::rd "%SystemPath%\Test_Permissions" > nul 2 > nul
del /f /q %SystemPath%\TestPermission.log
echo "Permission check." >> %SystemPath%\TestPermission.log
if not exist %SystemPath%\TestPermission.log (echo Require Administrator Permission. && pause > nul && Exit)
del /f /q %SystemPath%\TestPermission.log

cls
cd /d %~dp0\Certs

:: Architecture check
if "%PROCESSOR_ARCHITECTURE%%PROCESSOR_ARCHITEW6432%" == "x86" (goto X86) else goto X64

:X86
:: Delete certifications(Base)
::  Fake GitHub.Com(2013-01-25)
CertMgr_x86 -del -c -sha1 27A29C3A8B3261770E8B59448557DC9E9339E68C -s -r localMachine Root
CertMgr_x86 -del -c -sha1 27A29C3A8B3261770E8B59448557DC9E9339E68C -s -r localMachine AuthRoot
::  Fake Google.Com(2014-07-24)
CertMgr_x86 -del -c -sha1 F6BEADB9BC02E0A152D71C318739CDECFC1C085D -s -r localMachine Root
CertMgr_x86 -del -c -sha1 F6BEADB9BC02E0A152D71C318739CDECFC1C085D -s -r localMachine AuthRoot
::  CNNIC ROOT
CertMgr_x86 -del -c -sha1 8BAF4C9B1DF02A92F7DA128EB91BACF498604B6F -s -r localMachine Root
CertMgr_x86 -del -c -sha1 8BAF4C9B1DF02A92F7DA128EB91BACF498604B6F -s -r localMachine AuthRoot
::  China Internet Network Information Center EV Certificates Root
CertMgr_x86 -del -c -sha1 4F99AA93FB2BD13726A1994ACE7FF005F2935D1E -s -r localMachine Root
CertMgr_x86 -del -c -sha1 4F99AA93FB2BD13726A1994ACE7FF005F2935D1E -s -r localMachine AuthRoot

@echo.

:: Add certifications to CRL(Base)
CertMgr_x86 -add -c FakeGitHubCom_2013_01.cer -s Disallowed
CertMgr_x86 -add -c FakeGoogleCom_2014_07.cer -s Disallowed
CertMgr_x86 -add -c CNNIC_ROOT.cer -s Disallowed
CertMgr_x86 -add -c China_Internet_Network_Information_Center_EV_Certificates_Root.cer -s Disallowed
goto Exit

:X64
:: Delete certifications(Base)
:: Fake GitHub.Com(2013-01-25)
CertMgr -del -c -sha1 27A29C3A8B3261770E8B59448557DC9E9339E68C -s -r localMachine Root
CertMgr -del -c -sha1 27A29C3A8B3261770E8B59448557DC9E9339E68C -s -r localMachine AuthRoot
:: Fake Google.Com(2014-07-24)
CertMgr -del -c -sha1 F6BEADB9BC02E0A152D71C318739CDECFC1C085D -s -r localMachine Root
CertMgr -del -c -sha1 F6BEADB9BC02E0A152D71C318739CDECFC1C085D -s -r localMachine AuthRoot
::  CNNIC ROOT
CertMgr -del -c -sha1 8BAF4C9B1DF02A92F7DA128EB91BACF498604B6F -s -r localMachine Root
CertMgr -del -c -sha1 8BAF4C9B1DF02A92F7DA128EB91BACF498604B6F -s -r localMachine AuthRoot
::  China Internet Network Information Center EV Certificates Root
CertMgr -del -c -sha1 4F99AA93FB2BD13726A1994ACE7FF005F2935D1E -s -r localMachine Root
CertMgr -del -c -sha1 4F99AA93FB2BD13726A1994ACE7FF005F2935D1E -s -r localMachine AuthRoot

@echo.

:: Add certifications to CRL(Base)
CertMgr -add -c FakeGitHubCom_2013_01.cer -s Disallowed
CertMgr -add -c FakeGoogleCom_2014_07.cer -s Disallowed
CertMgr -add -c CNNIC_ROOT.cer -s Disallowed
CertMgr -add -c China_Internet_Network_Information_Center_EV_Certificates_Root.cer -s Disallowed

:Exit
:: Print to screen.
@echo.
@echo Done. Please confirm the messages on screen.
@echo.
@pause
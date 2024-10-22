echo off
echo .
echo PQMethod_OnMyDrive.bat can be used for starting PQMethod when the 
echo program and projects subfolder had been installed at some place other 
echo than the c: drive.
echo .
echo Please Press ENTER to continue
pause
set EDITOR=%windir%\system32\notepad.exe
set VIEWER=%windir%\system32\notepad.exe
cd projects
..\PQMethod.exe %1

@echo off
set curr_path=%~dp0
echo %curr_path%
for /D %%p in (robotframework selenium python-appium-client decorator docutils kitchen six robotframework-appiumlibrary) do (
echo.
echo.
echo.
echo install %%p...
sleep 2
cd %curr_path%\%%p && python setup.py install
if %ERRORLEVEL% equ 1 echo install failed & GOTO EXIT_LABLE
)

echo install success
:EXIT_LABLE
pause

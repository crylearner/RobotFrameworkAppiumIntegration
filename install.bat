@echo off
set curr_path=%~dp0
echo %curr_path%
for /D %%p in (robotframework selenium python-appium-client decorator docutils kitchen six robotframework-appiumlibrary nose Pygments configobj) do (
echo.
echo.
echo.
echo install %%p...
sleep 2
cd %curr_path%\%%p && python setup.py install
if %ERRORLEVEL% equ 1 echo install failed & GOTO EXIT_LABLE
)

pip install wxPython-4.0.0b1-cp27-cp27m-win_amd64.whl
echo install success
:EXIT_LABLE
pause

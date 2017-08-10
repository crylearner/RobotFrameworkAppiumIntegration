*** Settings ***
Documentation     Testing that listener gets information about different output files. Tests also that the listener can be taken into use with path.
Suite Setup       Run Some Tests
Suite Teardown    Remove Listener Files
Resource          listener_resource.robot

*** Variables ***
${LISTENERS}      ${CURDIR}${/}..${/}..${/}..${/}testresources${/}listeners

*** Test Cases ***
Output Files
    ${file} =    Get Listener File    ${ALL_FILE}
    ${expected} =    Catenate    SEPARATOR=\n
    ...    Debug: mydeb.txt
    ...    Output: myout.xml
    ...    Log: mylog.html
    ...    Report: myrep.html
    ...    Closing...\n
    Should End With    ${file}    ${expected}

Output Files With Java
    [Tags]    require-jython
    ${file} =    Get Listener File    ${JAVA_FILE}
    ${expected} =    Catenate    SEPARATOR=\n
    ...    Debug (java): mydeb.txt
    ...    Output (java): myout.xml
    ...    Log (java): mylog.html
    ...    Report (java): myrep.html
    ...    The End\n
    Should End With    ${file}    ${expected}

*** Keywords ***
Run Some Tests
    ${options} =    Catenate
    ...    --listener "${LISTENERS}${/}ListenAll.py"
    ...    --listener "${LISTENERS}${/}JavaListener.java"
    ...    --log mylog.html
    ...    --report myrep.html
    ...    --output myout.xml
    ...    --debugfile mydeb.txt
    Run Tests    ${options}    misc/pass_and_fail.robot    output=${OUTDIR}/myout.xml
    Should Be Equal    ${SUITE.name}    Pass And Fail

﻿*** Settings ***
Documentation    Example file in UTF-8 format with byte order mark (BOM) in the beginning. No RIDE!
Library          OperatingSystem
Force Tags       bomelo

*** Test Cases ***
Byte order mark in plain text file
    Log    Hyvää päivää €åppa!
    Directory Should Exist    .

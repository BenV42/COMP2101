# this script displays the values of the common parameter variables
# the common parameters are recognized because we use the cmdletbinding()
# attribute for our param() statement

[CmdletBinding()]
Param()

clear-host
# this is an alternate way to get common parameters recognized
# it is useful if you have parameters with attributes that you want to specify
#
# Param([parameter(Mandatory=$true)]$myparameter)


"
Common parameters are parameters present in all cmdlets, although cmdlets
may not pay any attention to them. Specifying the common parameters when
running a cmdlet sets values into variables so that those cmdlets can
know what behaviour the user wants.

Allowing your scripts to recognize the common parameters can be done using
either the Param([parameter(attributelist)]parameterdefinition) or
[cmdletbinding()] attributes at the start of your script
e.g. [CmdletBinding()]Param()
e.g. Param([parameter(Mandatory=$true)]$myparameter)

This script has the CmdletBinding() attribute on the Param statement so it
will recognize any common parameters on the command line. Try running it
with various common parameter settings to see what it does with them. Be warned,
some of the parameters don't work unless the script is saved as a function.
See help about_common_parameters for the rules.

-Verbose sets the `$VerbosePreference variable and currently is '$VerbosePreference'
-Debug sets the `$DebugPreference variable and currently is '$DebugPreference'
-WarningAction sets the `$WarningActionPreference variable and currently is '$WarningActionPreference'
-ErrorAction set the `$ErrorActionPreference variable and currently is '$ErrorActionPreference'

-WarningVariable sets the `$wv variable and currently is '$wv'
-ErrorVariable sets the `$ev variable and currently is '$ev'
-OutVariable sets the `$ov variable and currently is '$ov'

-OutBuffer sets the `$ob variable and currently is '$ob'

-WhatIf sets the `$wi variable and currently is '$wi'
-Confirm sets the `$cf variable and currently is '$cf'
"
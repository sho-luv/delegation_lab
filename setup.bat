
# asreproast attack - APPDBCUSWS16-01$ 

:: create account:
net user web.user Bambam911 /add

:: add domain user to local admin group
net localgroup administrators moosedojo.local\web.user /ADD

    # make account asreproastable by setting doesnotrequirepreauth flag:
    powershell import-module activedirectory; Set-ADAccountControl -Identity web.user  -doesnotrequirepreauth $true

    # check for asreproastable accounts: 
    Get-ADUser -Filter 'useraccountcontrol -band 4194304' -Properties useraccountcontrol | Format-Table name


# Constrained Delegation Attack - jberries-ws16$ (10.0.0.201)

	moosedojo\justine.berries on host 10.0.0.201 (jberries-ws16)

	# create system that allows constrained delegation:
	net computer \\kyan-computer$ /add
	

    # make account constrained:
    powershell import-module activedirectory; Set-ADAccountControl -Identity jberries-ws16$ -TrustedToAuthForDelegation $true
    Set-ADComputer -Identity jberries-ws16$ -Add @{'msDS-AllowedToDelegateTo'=@('WSMAN/CoolThings','WWW/DC-01')}
	Set-ADComputer jberries-ws16 -PrincipalsAllowedToDelegateToAccount (Get-ADComputer matt-laptop)

    # check for constrained delegation:
    get-adcomputer jberries-ws16 -Properties * | Format-List -Property *delegat*,msDS-AllowedToActOnBehalfOfOtherIdentity
    get-adcomputer jberries-ws16 -Properties * | Select-Object -ExpandProperty msDS-AllowedToActOnBehalfOfOtherIdentity |Format-List


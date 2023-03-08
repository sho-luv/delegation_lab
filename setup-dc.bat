
:: create account:
net user web.user Bambam911 /add

:: make account asreproastable by setting doesnotrequirepreauth flag:
powershell import-module activedirectory; Set-ADAccountControl -Identity web.user  -doesnotrequirepreauth $true

:: create system that allows constrained delegation:
net computer \\jberries-ws16 /add
net computer \\matt-laptop /add

net user matt-laptop$ Rapid7isc00l
net user jberries-ws16$ Rapid7isc00l

:: make account constrained:
powershell import-module activedirectory; Set-ADAccountControl -Identity jberries-ws16$ -TrustedToAuthForDelegation $true
powershell import-module activedirectory; Set-ADComputer -Identity jberries-ws16$ -Add @{'msDS-AllowedToDelegateTo'=@('WSMAN/CoolThings','WWW/DC-01','WWW/WIN-4K6AI0OL89J')}
powershell import-module activedirectory; Set-ADComputer jberries-ws16$ -PrincipalsAllowedToDelegateToAccount (Get-ADComputer matt-laptop)

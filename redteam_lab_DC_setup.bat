net computer \\a-aron-ws80 /add
net computer \\adam-ws22 /add
net computer \\APPDBCUSWS16-01 /add
net computer \\eric-ws14 /add
net computer \\jberries-ws16 /add
net computer \\josh-ws55 /add
net computer \\kevin-ws27 /add
net computer \\matt-laptop /add
net computer \\patrick-laptop /add
net computer \\price-laptop /add
net computer \\sholuv-laptop /add

net user a-aron TrollingYou! /add
net user adam Iclfasllfk! /add
net user eric ERasdfslw@# /add
net user justin Big8erries?! /add
net user josh %@1Olkfasdfs /add
net user kevin %Baaskaiepx! /add
net user matt ETSadfssdff! /add
net user patrick Msfadslakf;k# /add
net user price #@Fslksslkds /add
net user sholuv I_Made_1t!! /add
net user web.user Bambam911 /add
net user kgilstrong-adm Kevin15Cool! /add

:: make account asreproastable by setting doesnotrequirepreauth flag:
powershell import-module activedirectory; Set-ADAccountControl -Identity web.user  -doesnotrequirepreauth $true

:: add constrained delegation to multiple accounts
powershell Set-ADComputer -Identity jberries-ws16$ -Add @{'msDS-AllowedToDelegateTo'=@('WSMAN/CoolThings','WWW/LessCoolStuff')}
powershell Set-ADComputer -Identity appdbcusws16-01$ -Add @{'msDS-AllowedToDelegateTo'=@('Hack/All_The_Things','DNS/DC-01')}
powershell Set-ADComputer -Identity matt-laptop$ -Add @{'msDS-AllowedToDelegateTo'=@('MSQL/Service','WWW/patrick-laptop')}
powershell Set-ADComputer -Identity adam-ws22$ -Add @{'msDS-AllowedToDelegateTo'=@('CIFS/kevin-ws27','HOST/sholuv-laptop')}

:: add protocal transition (this allows the orginal auth to be done outside of kerberos ex. ntlm, aesKey, etc):
powershell import-module activedirectory; Set-ADAccountControl -Identity appdbcusws16-01$ -TrustedToAuthForDelegation $true
powershell import-module activedirectory; Set-ADAccountControl -Identity jberries-ws16$ -TrustedToAuthForDelegation $true
powershell import-module activedirectory; Set-ADAccountControl -Identity adam-ws22$ -TrustedToAuthForDelegation $true


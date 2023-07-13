function get-ipreport {
get-ciminstance win32_networkadapterconfiguration | 
where { $_.IPEnabled -eq $True } | 
sort Description, Index, IPAddress, IPSubnet, DNSHostName, DNSDomain, DNSServerSearchOrder, DHCPEnabled |
format-table -Autosize -Wrap | out-string -width 500
}

#Trying to figure out formatting of table

#get-ciminstance win32_networkadapterconfiguration | 
#where { $_.IPEnabled -eq $True } |
#new-object -typename psobject -property @{Description=$_.Description; Index=$_.Index; IPAddress=$_.IPAddress; IPSubnet=$_.IPSubnet; #DNSHostName=$_.DNSHostName; DNSDomain=$_.DNSDomain; DNSServerSearchOrder=$_.DNSServerSearchOrder; DHCPEnabled=$_.DHCPEnabled | 
#format-table -Autosize | 

#Network Table formatted into a table based on IPEnabled

function get-ipreport {
get-ciminstance win32_networkadapterconfiguration | 
where { $_.IPEnabled -eq $True } | 
sort Index |
format-table -Autosize Description, Index, IPAddress, IPSubnet, DNSHostName,
DNSDomain, DNSServerSearchOrder, DHCPEnabled
}



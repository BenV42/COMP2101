#Function to view Max Values

function maxvalue {
foreach ($c in (1..8)) {
new-object -typename psobject -property @{
PlaceCount=$c;
MaxValueInBinary=[math]::pow(2,$c);
MaxValueInOctal=[math]::pow(8,$c);
MaxValueInHex=[math]::pow(16,$c)
		}
	}
}
maxvalue
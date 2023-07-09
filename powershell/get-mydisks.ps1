function get-mydisks {
	get-disk | format-table DiskNumber, Manufacturer, Model, 
	SerialNumber, FirmwareVersion, Size
} 
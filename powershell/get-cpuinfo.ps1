function get-cpuinfo {
get-ciminstance cim_processor | format-list DeviceID, Description, CurrentClockspeed, MaxClockSpeed, Manufacturer, NumberOfCores
}
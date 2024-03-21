# Define an array containing the registry keys, data, and types
$registrySettings = @(
    ("HKLM:\SOFTWARE\JSDSoftware\SEScan4", "DataModes", 123456, "DWORD"),
    ("HKLM:\SOFTWARE\JSDSoftware\SEScan4", "Key" , "ABC123", "String"),
    ("HKLM:\SOFTWARE\JSDSoftware\SEScan4", "Username" , "BOB DYLAN", "String"),
    ("HKLM:\SOFTWARE\Wow6432Node\JSDSoftware\SEScan4", "DataModes", 123456, "DWORD"),
    ("HKLM:\SOFTWARE\Wow6432Node\JSDSoftware\SEScan4", "Key" , "ABC123", "String"),
    ("HKLM:\SOFTWARE\Wow6432Node\JSDSoftware\SEScan4", "Username" , "BOB DYLAN", "String"),
)

# Loop through each item in the registrySettings array
foreach ($setting in $registrySettings) {
    $key = $setting[0]
    $name = $setting[1]
    $data = $setting[2]
    $type = $setting[3]

    # Check if the property already exists
    $propertyExists = Get-ItemProperty -Path $key | Select-Object -ExpandProperty $name -ErrorAction SilentlyContinue
    if ($null -eq $propertyExists) {
        # If property doesn't exist, set the registry value
        if (!(Test-Path $key)) {
            New-Item -Path $key -Force | Out-Null
        }
        New-ItemProperty -Path $key -Name $name -Value $data -PropertyType $type
    }
}

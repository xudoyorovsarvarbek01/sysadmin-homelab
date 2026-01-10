<#
.SYNOPSIS
    Creates security groups for each department
.DESCRIPTION
    Automates creation of AD security groups with proper scope and category
#>

Import-Module ActiveDirectory

$DomainDN = "DC=lab,DC=local"
$GroupsOU = "OU=Security Groups,OU=Groups,OU=Corporate,$DomainDN"

$Departments = @("IT", "Sales", "Finance", "HR")

Write-Host "Creating security groups..." -ForegroundColor Green

foreach ($Dept in $Departments) {
    try {
        $GroupName = "$Dept-Team"
        
        New-ADGroup `
            -Name $GroupName `
            -SamAccountName $GroupName `
            -GroupCategory Security `
            -GroupScope Global `
            -Path $GroupsOU `
            -Description "Security group for $Dept department"
        
        Write-Host "  ✓ Created $GroupName" -ForegroundColor Green
        
    } catch {
        Write-Host "  ✗ Error creating $GroupName: $_" -ForegroundColor Red
    }
}

# Create special admin groups
$AdminGroups = @("Helpdesk", "Server-Admins", "Workstation-Admins")

foreach ($Group in $AdminGroups) {
    try {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupCategory Security `
            -GroupScope Global `
            -Path $GroupsOU `
            -Description "Administrative group: $Group"
        
        Write-Host "  ✓ Created $Group" -ForegroundColor Green
        
    } catch {
        Write-Host "  ✗ Error creating $Group: $_" -ForegroundColor Red
    }
}

Write-Host "`nGroup creation complete!" -ForegroundColor Green

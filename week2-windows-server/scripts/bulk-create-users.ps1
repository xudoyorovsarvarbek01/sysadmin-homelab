<#
.SYNOPSIS
    Bulk creates AD users from CSV file
.DESCRIPTION
    Reads user data from CSV and creates AD user accounts with proper OU placement
.PARAMETER CSVPath
    Path to CSV file containing user data
.EXAMPLE
    .\bulk-create-users.ps1 -CSVPath .\user-list.csv
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$CSVPath
)

# Import AD module
Import-Module ActiveDirectory

# Check if CSV exists
if (-not (Test-Path $CSVPath)) {
    Write-Error "CSV file not found: $CSVPath"
    exit
}

# Import users from CSV
$Users = Import-Csv $CSVPath

Write-Host "Creating $($Users.Count) users from CSV..." -ForegroundColor Green

foreach ($User in $Users) {
    try {
        Write-Host "Creating user: $($User.Username)..." -ForegroundColor Yellow
        
        New-ADUser `
            -Name "$($User.FirstName) $($User.LastName)" `
            -GivenName $User.FirstName `
            -Surname $User.LastName `
            -SamAccountName $User.Username `
            -UserPrincipalName "$($User.Username)@lab.local" `
            -DisplayName "$($User.FirstName) $($User.LastName)" `
            -Path $User.OUPath `
            -Department $User.Department `
            -Title $User.JobTitle `
            -AccountPassword (ConvertTo-SecureString $User.Password -AsPlainText -Force) `
            -Enabled $true `
            -ChangePasswordAtLogon $false
        
        # Add to group if specified
        if ($User.GroupMembership) {
            Add-ADGroupMember -Identity $User.GroupMembership -Members $User.Username
        }
        
        Write-Host "  ✓ Created successfully" -ForegroundColor Green
        
    } catch {
        Write-Host "  ✗ Error creating $($User.Username): $_" -ForegroundColor Red
    }
}

Write-Host "`nUser creation complete!" -ForegroundColor Green
Write-Host "Run 'Get-ADUser -Filter * | Select Name, SamAccountName' to verify" -ForegroundColor Cyan

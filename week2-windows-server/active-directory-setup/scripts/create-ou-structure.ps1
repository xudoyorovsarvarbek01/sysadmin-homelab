<#
.SYNOPSIS
    Creates hierarchical OU structure for Active Directory domain
.DESCRIPTION
    Automates creation of organizational units for departments, users, groups, and servers
.AUTHOR
    [Your Name]
.DATE
    [Current Date]
#>

# Define domain DN
$DomainDN = "DC=lab,DC=local"  # Change to your domain

Write-Host "Creating OU Structure for $DomainDN" -ForegroundColor Green

# Create top-level OUs
Write-Host "Creating top-level OUs..." -ForegroundColor Yellow
New-ADOrganizationalUnit -Name "Corporate" -Path $DomainDN -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Servers" -Path $DomainDN -ProtectedFromAccidentalDeletion $true

# Create Department OUs
Write-Host "Creating Department OUs..." -ForegroundColor Yellow
$CorporateDN = "OU=Corporate,$DomainDN"
New-ADOrganizationalUnit -Name "Departments" -Path $CorporateDN
New-ADOrganizationalUnit -Name "Users" -Path $CorporateDN
New-ADOrganizationalUnit -Name "Groups" -Path $CorporateDN

# Create specific department OUs
$Departments = @("IT", "Sales", "Finance", "HR")
$DeptDN = "OU=Departments,$CorporateDN"

foreach ($Dept in $Departments) {
    Write-Host "  Creating $Dept department..." -ForegroundColor Cyan
    New-ADOrganizationalUnit -Name $Dept -Path $DeptDN
}

# Create User OUs for each department
$UsersDN = "OU=Users,$CorporateDN"
foreach ($Dept in $Departments) {
    Write-Host "  Creating $Dept Users OU..." -ForegroundColor Cyan
    New-ADOrganizationalUnit -Name "$Dept Users" -Path $UsersDN
}

# Create Group OUs
Write-Host "Creating Group OUs..." -ForegroundColor Yellow
$GroupsDN = "OU=Groups,$CorporateDN"
New-ADOrganizationalUnit -Name "Security Groups" -Path $GroupsDN
New-ADOrganizationalUnit -Name "Distribution Groups" -Path $GroupsDN

# Create Server OUs
Write-Host "Creating Server OUs..." -ForegroundColor Yellow
$ServersDN = "OU=Servers,$DomainDN"
New-ADOrganizationalUnit -Name "Production" -Path $ServersDN
New-ADOrganizationalUnit -Name "Development" -Path $ServersDN

Write-Host "`nOU Structure created successfully!" -ForegroundColor Green
Write-Host "Run 'Get-ADOrganizationalUnit -Filter * | Select Name' to verify" -ForegroundColor Cyan
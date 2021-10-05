    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$ClientId,
        [Parameter()]
        [string]$Username,
        [string]$Password,
        $ProjectId,
        [string]$FilePath,
        [string]$FileName)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider nuget -Scope CurrentUser -Force -Confirm:$false
Install-Module -Name AZ -AllowClobber -Scope CurrentUser -Force -Confirm:$False -SkipPublisherCheck
Install-Module -Name d365fo.tools -AllowClobber -Scope CurrentUser -Force -Confirm:$false
Get-D365LcsApiToken -ClientId $ClientId -Username $Username -Password $Password -LcsApiUri "https://lcsapi.lcs.dynamics.com" -Verbose | Set-D365LcsApiConfig -ProjectId $ProjectId
return Invoke-D365LcsUpload -FilePath $FilePath -FileType "SoftwareDeployablePackage" -FileName $FileName


#requires -version 3.0

Function Get-EnvironmentVariable {

[CmdletBinding()]
    
Param(
    [Parameter(ValueFromPipeline=$true,
    Position = 0, 
    HelpMessage="Enter one or more enviromnent variables separated by commas.",
    ValueFromRemainingArguments = $false)]

    [String[]]$Name =  "",

    [Parameter(ValueFromPipeline=$true)]
    [ValidateSet("Machine", "Process", "User")]
    [String[]]$Target 
 
    )
         
Foreach ($SingleTarget in $Target)
  
{
    
       # Remove-Variable outputObject

        If ($SingleTarget -eq "Machine" )
        {
            $MachineKeys = [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Machine)
            Foreach ($Key in $MachineKeys.GetEnumerator()) 
            {
                $objectProperty = @{
                Name =  ($Key).name 
                Value = ($Key).Value -split ";"
                Target = 'Machine'
                }
            }
             $outputObject += @(New-Object pscustomobject -Property $objectProperty)
        }
        
           
        If ($SingleTarget -eq "User" )
        {
            $Userkeys= [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::User)     
            Foreach ($Key in $Userkeys.GetEnumerator())
            {
                $objectProperty = @{
                Name =  ($Key).name 
                Value = ($Key).Value -split ";"
                Target = 'User'
                }
             $outputObject += @(New-Object pscustomobject -Property $objectProperty)
            }   
        }

        If ($SingleTarget -eq "Process" )
        {
            $ProcessKeys = [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Process)     
            Foreach ($Key in $ProcessKeys.GetEnumerator()) 
            {
                $objectProperty = @{
                Name =  ($Key).name 
                Value = ($Key).Value -split ";"
                Target = 'Process'
                }
               $outputObject += @(New-Object pscustomobject -Property $objectProperty)
            }       
        }   
          
    } 

    
     Return $outputObject                 
}


Get-EnvironmentVariable -Target Process, user






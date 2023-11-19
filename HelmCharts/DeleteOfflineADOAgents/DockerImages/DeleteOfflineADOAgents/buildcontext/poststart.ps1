$secret = $env:ADO_PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($secret)"))
$header = @{authorization = "Basic $token"}

$azureDevOpsOrg = $env:ADO_ORG

$getPoolsUrl = "https://dev.azure.com/${azureDevOpsOrg}/_apis/distributedtask/pools?api-version=7.0"
$pools = Invoke-RestMethod -Uri $getPoolsUrl -Method Get -ContentType "application/json" -Headers $header

$pools.value | ForEach-Object {

  $isHosted = $_.isHosted

  if ($isHosted -ne "True") {
      $poolId = $_.id
      $getAgentsUrl = "https://dev.azure.com/${azureDevOpsOrg}/_apis/distributedtask/pools/${poolId}/agents?api-version=6.1-preview.1"
      $agents = Invoke-RestMethod -Uri $getAgentsUrl -Method Get -ContentType "application/json" -Headers $header

      $agents.value | ForEach-Object {

        $status = $_.status
        if ($status -eq "offline") {
            $agentId = $_.id
            $agentName = $_.name

            Write-Host "Deleting Offline ADO Agent: $agentName"

            $deleteAgent = "https://dev.azure.com/${azureDevOpsOrg}/_apis/distributedtask/pools/${poolId}/agents/${agentId}?api-version=6.1-preview.1"
            Invoke-RestMethod -Uri $deleteAgent -Method Delete -Headers $header
        }
      }
  }
}
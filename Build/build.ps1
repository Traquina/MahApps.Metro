function Get-ScriptDirectory
{
   $Invocation = (Get-Variable MyInvocation -Scope 1).Value
   Split-Path $Invocation.MyCommand.Path
}

# build the solution from scratch
$version = "v4.0.30319"
$proj = Join-Path (Get-ScriptDirectory) ..\MahApps.Metro\MahApps.Metro.csproj
$solution_dir = Join-Path (Get-ScriptDirectory) ..\

. $env:windir\Microsoft.NET\Framework\$version\MSBuild.exe $proj /t:Rebuild /ToolsVersion:4.0 /p:SolutionDir=$solution_dir /p:StrongName=True /p:configuration=Release /m /v:q

# package it up

$nuget = Join-Path (Get-ScriptDirectory) ..\Utilities\NuGet.exe
$nuspec = Join-Path (Get-ScriptDirectory) ..\MahApps.Metro\MahApps.Metro.nuspec

. $nuget pack $nuspec -OutputDirectory (Get-ScriptDirectory)


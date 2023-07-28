$made = 0
$total = 35
mode con:cols=80 lines=4

switch ($PSUICulture) 
{
    "fr-FR" {$wordlist = Get-Content -Path ".\wordlist\fr-FR.txt"}
    Default {
        $wordlist = Get-Content -Path ".\wordlist\en-EN.txt"
    }
}

Write-Host "Starting Browser, Please Wait"
Start-Sleep -Seconds 5

while ($made -lt $total) {
    $wait = Get-Random -Minimum 3 -Maximum 16
    $wordlistindex = Get-Random -Minimum 1 -Maximum 501
    $randword = $wordlist[$wordlistindex]
    $made++

    Start-Process "microsoft-edge:"
    Start-Process "microsoft-edge:https://www.bing.com/search?q=$randword"

    Clear-Host
    $title = "$made Searches Made out of $total - Searching for: $randword"
    $host.ui.RawUI.WindowTitle = $title
    Write-Host "$made Searches Made out of $total"

    for ($i = $wait; $i -ge 1; $i--) {
        [Console]::SetCursorPosition(0, [Console]::CursorTop)
        Write-Host (" " * 80) -NoNewline
        [Console]::SetCursorPosition(0, [Console]::CursorTop)
        Write-Host "$i seconds until next search" -NoNewline
        Start-Sleep -Seconds 1
    }
    Get-Process -Name "msedge" | ForEach-Object { $_.CloseMainWindow() } | Out-Null
}

Start-Sleep -Seconds 1

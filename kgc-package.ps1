
# Set source and destination folders
$source = "C:\Work\Chrysalis\KGC\KGC"
$dest = "C:\KGC-Iframe-App"
$zipPath = "$source\KGC-Iframe-App.zip"

# Copy files
Copy-Item "$source\manifest.json" -Destination $dest -Force
Copy-Item "$source\iframe-host.html" -Destination $dest -Force

# Delete old zip files
Get-ChildItem -Path $dest -Filter *.zip -ErrorAction SilentlyContinue | Remove-Item -Force

# Create new zip file (contents in root)
Compress-Archive -Path (Get-ChildItem -Path $dest -File | Select-Object -ExpandProperty FullName) -DestinationPath $zipPath -Force

# Run git commands
Set-Location $source
git add .
$stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
git commit -m "latest changes $stamp"
git push origin main
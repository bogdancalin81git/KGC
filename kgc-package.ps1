
# Set source and destination folders
$source = "C:\Work\Chrysalis\KGC\KGC"
$dest = "$source\KGC-Iframe-App"

$zipPath = "$dest\KGC-Iframe-App.zip"

# Copy files
Copy-Item "$source\manifest.json" -Destination $dest -Force
Copy-Item "$source\iframe-host.html" -Destination $dest -Force


# Copy icons folder (recursively)
Copy-Item "$source" -Destination $dest -Recurse -Force


# Delete old zip files
Get-ChildItem -Path $dest -Filter *.zip -ErrorAction SilentlyContinue | Remove-Item -Force

# Create new zip file (contents in root)
#Compress-Archive -Path (Get-ChildItem -Path $dest -File | Select-Object -ExpandProperty FullName) -DestinationPath $zipPath -Force


# Create new zip file (contents in root, including icons folder)
Compress-Archive -Path "$dest\*" -DestinationPath $zipPath -Force


# Run git commands
Set-Location $source
git add .
$stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
git commit -m "latest changes $stamp"
git push origin main
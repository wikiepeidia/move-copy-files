param (
    [string]$sourceFolder,
    [string]$destinationFolder
)

# Validate source and destination paths
if (-not (Test-Path $sourceFolder -PathType Container)) {
    Write-Host "Source folder does not exist: $sourceFolder"
    exit
}

if (-not (Test-Path $destinationFolder -PathType Container)) {
    Write-Host "Destination folder does not exist: $destinationFolder"
    exit
}

# Prompt user to choose between moving (M) or copying (C)
$operation = Read-Host "Do you want to move or copy files? (M)ove / (C)opy"

# Validate user input
if ($operation -notin @('M', 'C')) {
    Write-Host "Invalid choice. Please enter 'M' for move or 'C' for copy."
    exit
}

# Get all image files in the source folder and its subfolders
$imageFiles = Get-ChildItem -Path $sourceFolder -Recurse -Include *.webp, *.png, *.gif, *.jpeg, *.jpg #change this to WHATEVER extension you WANT TO do.

# Move or copy each image file to the destination folder
foreach ($file in $imageFiles) {
    $destinationPath = Join-Path $destinationFolder $file.Name
    if ($operation -eq 'M') {
        Move-Item $file.FullName -Destination $destinationPath -Force
        Write-Host "$($file.FullName) moved to $($destinationPath)"
    } elseif ($operation -eq 'C') {
        Copy-Item $file.FullName -Destination $destinationPath -Force
        Write-Host "$($file.FullName) copied to $($destinationPath)"
    }
}

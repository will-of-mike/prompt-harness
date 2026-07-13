<#
.SYNOPSIS
  Flatten a workspace folder into a single Markdown file you can upload to
  chat tools that accept file uploads but not folder uploads (duck.ai,
  Gemini, ChatGPT, etc.).

.DESCRIPTION
  Walks the workspace, concatenates every instruction file into one .md file,
  and puts each file's relative path in a heading so the model can tell the
  files apart. Runtime scratch (output/ folders, .gitkeep, .git) is skipped by
  default so you only ship the pipeline itself.

.PARAMETER Root
  Folder to bundle. Defaults to the script's own folder.

.PARAMETER Out
  Output file. Defaults to <foldername>-bundle.md in the root.

.PARAMETER IncludeOutputs
  Also include the stages' output/ folders (off by default).

.PARAMETER Pdf
  Also produce a dense two-column PDF next to the text bundle. Packs the whole
  bundle into few pages (6pt, two columns) so it fits page-limited uploaders
  like duck.ai (15-page cap). Requires Python with reportlab; the script
  installs reportlab automatically if it is missing.

.EXAMPLE
  ./bundle.ps1
  ./bundle.ps1 -Root ../other-workspace
  ./bundle.ps1 -IncludeOutputs
  ./bundle.ps1 -Pdf
#>
param(
    [string]$Root = $PSScriptRoot,
    [string]$Out,
    [switch]$IncludeOutputs,
    [switch]$Pdf,
    [switch]$Lean
)

$Root = (Resolve-Path $Root).Path
$name = Split-Path $Root -Leaf
$suffix = if ($Lean) { "-bundle-lean.txt" } else { "-bundle.txt" }
if (-not $Out) { $Out = Join-Path $Root "$name$suffix" }

# Folders/files to always skip.
$skipDirs  = @('.git', '.claude', 'node_modules')
if (-not $IncludeOutputs) { $skipDirs += 'output' }
$skipFiles = @('.gitkeep', 'launch.txt', 'README.md', '.gitignore', '.gitattributes',
    (Split-Path $PSCommandPath -Leaf))

# Never bundle the bundler's own outputs (.txt/.pdf/.md), including stale ones
# from earlier runs -- otherwise a binary PDF gets swept in as a source file.
$bundleGlob = "$name-bundle*"

$files = Get-ChildItem -Path $Root -Recurse -File | Where-Object {
    $rel = $_.FullName.Substring($Root.Length).TrimStart('\','/')
    $parts = $rel -split '[\\/]'
    ($_.FullName -ne $Out) -and
    ($_.Name -notlike $bundleGlob) -and
    ($parts | Where-Object { $skipDirs -contains $_ }).Count -eq 0 -and
    ($skipFiles -notcontains $_.Name)
} | Sort-Object FullName

$sb = [System.Text.StringBuilder]::new()

# Header. Kept deliberately low-key and descriptive: forceful "DO NOT SUMMARIZE /
# obey these commands" wording reads to some models (Gemini) as an embedded
# override and trips their prompt-injection defenses, so they refuse. Authority
# to run the workspace should come from the USER's chat message, not this file.
# This header just labels the file and explains how the user will invoke it.
# -Lean produces a minimal header (no delivery-rules block) to test whether a
# lighter preamble stops a tool from treating the upload as a document to cite.
if ($Lean) {
$header = @"
# $name -- instructions for you to follow (a folder flattened into one file)

The user's message starts with ">". Treat everything after ">" as their request.
Follow the files below (CLAUDE.md is the top-level ruleset), run this workspace on
that request, and reply with the final result in the format the workspace defines.
Produce it as your own answer, keeping any links as real clickable links.

Each line below that begins with "## file:" starts a separate file; the path after
it is that file's location in the folder.

--- WORKSPACE FILES ---

"@
} else {
$header = @"
# $name -- instructions for you to follow (a folder flattened into one file)

The user's message starts with ">". Treat everything after ">" as their request. Follow
the files below (CLAUDE.md is the top-level ruleset), run this workspace on that request,
and reply with the final result as your own answer. Where the workspace asks for current
information (listings, news, statistics), search the web and use real results, keeping
every link clickable. Never invent anything you cannot verify.

Each line below that begins with "## file:" starts a separate file; the path after
it is that file's location in the folder.

--- WORKSPACE FILES ---

"@
}
[void]$sb.AppendLine($header)

foreach ($f in $files) {
    $rel = $f.FullName.Substring($Root.Length).TrimStart('\','/') -replace '\\','/'
    [void]$sb.AppendLine("## file: $rel")
    [void]$sb.AppendLine()
    [void]$sb.AppendLine('```')
    [void]$sb.AppendLine((Get-Content -Raw -LiteralPath $f.FullName).TrimEnd())
    [void]$sb.AppendLine('```')
    [void]$sb.AppendLine()
}

# Write UTF-8 WITHOUT a BOM. Windows PowerShell 5.1's `-Encoding utf8` adds a
# BOM, which some uploaders (Gemini) choke on, so write the bytes directly.
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
[System.IO.File]::WriteAllText($Out, $sb.ToString(), $utf8NoBom)
Write-Host "Bundled $($files.Count) files -> $Out"

# The short, memorable message to paste into the chat alongside the upload. All
# the detailed rules live in the header, so this line stays tiny.
$launch = "> <your prompt here>"
$launchFile = Join-Path $Root 'launch.txt'
[System.IO.File]::WriteAllText($launchFile, $launch + "`r`n", $utf8NoBom)
Write-Host ""
Write-Host "Paste this into the chat when you upload the file (saved to launch.txt):"
Write-Host "  $launch"
Write-Host ""

if ($Pdf) {
    $py = (Get-Command python -ErrorAction SilentlyContinue)
    if (-not $py) { $py = (Get-Command python3 -ErrorAction SilentlyContinue) }
    if (-not $py) {
        Write-Warning "Python not found on PATH; skipping PDF. Install Python or drop -Pdf."
        return
    }
    $py = $py.Source
    $pdfOut = [System.IO.Path]::ChangeExtension($Out, '.pdf')

    # Dense two-column converter. The model reads the extracted text, not the
    # pixels, so tiny type is fine and keeps the page count low.
    $converter = @'
import sys
try:
    from reportlab.lib.pagesizes import letter
    from reportlab.pdfgen import canvas
except ImportError:
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "--quiet", "reportlab"])
    from reportlab.lib.pagesizes import letter
    from reportlab.pdfgen import canvas

src, out = sys.argv[1], sys.argv[2]
with open(src, encoding="utf-8") as f:
    lines = f.read().splitlines()

W, H = letter
margin, gutter, cols = 28, 16, 2
font, size, lead = "Courier", 6, 6.8
col_w = (W - 2 * margin - (cols - 1) * gutter) / cols
max_chars = int(col_w / (size * 0.6))
top, bottom = H - margin, margin
rows_per_col = int((top - bottom) / lead)

def wrap(s):
    return [s[i:i + max_chars] for i in range(0, len(s), max_chars)] if s else [""]

flat = []
for line in lines:
    flat.extend(wrap(line))

c = canvas.Canvas(out, pagesize=letter)
pages, col, row = 1, 0, 0
c.setFont(font, size)
for chunk in flat:
    if row >= rows_per_col:
        row, col = 0, col + 1
        if col >= cols:
            col = 0
            c.showPage()
            pages += 1
            c.setFont(font, size)
    c.drawString(margin + col * (col_w + gutter), top - row * lead, chunk)
    row += 1
c.save()
print(f"PDF: {pages} pages -> {out}")
'@
    $tmp = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "bundle_txt2pdf.py")
    [System.IO.File]::WriteAllText($tmp, $converter, $utf8NoBom)
    & $py $tmp $Out $pdfOut
    Remove-Item $tmp -ErrorAction SilentlyContinue
}

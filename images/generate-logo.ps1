$ErrorActionPreference = "Stop"

Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

[int]$size = 512
[double]$centerX = $size / 2.0
[double]$centerY = $size / 2.0
[double]$radius = 228.0

$visual = New-Object System.Windows.Media.DrawingVisual
$ctx = $visual.RenderOpen()

$circleBrush = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(8, 8, 8))
$circlePen = New-Object System.Windows.Media.Pen(
  (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(24, 24, 24))),
  2
)

$ctx.DrawEllipse(
  $circleBrush,
  $circlePen,
  (New-Object System.Windows.Point($centerX, $centerY)),
  $radius,
  $radius
)

$grad = New-Object System.Windows.Media.LinearGradientBrush
$grad.StartPoint = New-Object System.Windows.Point(0, 0)
$grad.EndPoint = New-Object System.Windows.Point(1, 1)
$grad.GradientStops.Add((New-Object System.Windows.Media.GradientStop([System.Windows.Media.Color]::FromRgb(245, 248, 255), 0.0)))
$grad.GradientStops.Add((New-Object System.Windows.Media.GradientStop([System.Windows.Media.Color]::FromRgb(190, 196, 206), 0.48)))
$grad.GradientStops.Add((New-Object System.Windows.Media.GradientStop([System.Windows.Media.Color]::FromRgb(130, 136, 146), 1.0)))

$typeface = New-Object System.Windows.Media.Typeface("Segoe UI Black")
$formatted = New-Object System.Windows.Media.FormattedText(
  "N",
  [System.Globalization.CultureInfo]::InvariantCulture,
  [System.Windows.FlowDirection]::LeftToRight,
  $typeface,
  270,
  $grad,
  1.0
)

$x = ($size - $formatted.Width) / 2.0
$y = ($size - $formatted.Height) / 2.0 - 8

$ctx.DrawText($formatted, (New-Object System.Windows.Point($x, $y)))
$ctx.Close()

$bmp = New-Object System.Windows.Media.Imaging.RenderTargetBitmap(
  $size,
  $size,
  96,
  96,
  [System.Windows.Media.PixelFormats]::Pbgra32
)
$bmp.Render($visual)

$encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
$encoder.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($bmp))

$outPath = Join-Path $PSScriptRoot "noir-motion-logo.png"
$file = [System.IO.File]::Open($outPath, [System.IO.FileMode]::Create)
$encoder.Save($file)
$file.Close()

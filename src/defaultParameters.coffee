# Circos
circosJS.Core.prototype.defaultConf =
    width: 700
    height: 700
    container: 'circos'
    defaultTrackWidth: 10

# Layout
circosJS.Layout.prototype.defaultConf =
  innerRadius: 250
  outerRadius: 300
  cornerRadius: 5
  gap: 0.04 # in radian
  opacity: 1
  labels:
    position: 'center'
    display: true
    size: 14
    color: '#000'
    radialOffset: 20
  ticks:
    display: true
    color: 'grey'
    spacing: 10000000
    labels: true
    labelSpacing: 10
    labelSuffix: 'Mb'
    labelDenominator: 1000000
    labelDisplay0: true
    labelSize: 10
    labelColor: '#000'
    labelFont: 'default'
    majorSpacing: 5
    size:
      minor: 2
      major: 5
  onClick: null
  onMouseOver: null

# Heatmap
circosJS.Heatmap.prototype.defaultConf =
  details: 'blablabla'
  innerRadius: 0
  outerRadius: 0
  min: 'smart'
  max: 'smart'
  colorPalette: 'YlGnBu'
  colorPaletteSize: 9
  colorPaletteReverse: false
  logScale: false
  rules: []
  backgrounds: []

# Histogram
circosJS.Histogram.prototype.defaultConf =
  innerRadius: 0
  outerRadius: 0
  min: 'smart'
  max: 'smart'
  direction: 'out'
  colorPaletteSize: 9
  colorPalette: 'YlGnBu'
  usePalette: true
  colorPaletteReverse: false
  color: '#fd6a62'
  logScale: false
  axes:
    display: false
    minor:
      spacing: 5
      spacingType: 'pixel'
      color: '#d3d3d3'
      thickness: 2
    major:
      spacing: 5
      color: '#000000'
      thickness: 2
  rules: []
  backgrounds: []

# Chord
circosJS.Chord.prototype.defaultConf =
  colorPaletteSize: 9
  colorPalette: 'PuBuGn'
  usePalette: true
  colorPaletteReverse: false
  color: '#fd6a62'
  opacity: 0.7
  min: 'smart'
  max: 'smart'
  logScale: false
  rules: []
  backgrounds: []

# Scatter
circosJS.Scatter.prototype.defaultConf =
  innerRadius: 0
  outerRadius: 0
  min: 'smart'
  max: 'smart'
  direction: 'out'
  logScale: false
  glyph:
    color: '#fd6a62'
    fill: true
    size: 15
    shape: 'circle'
    strokeColor: '#d3d3d3'
    strokeWidth: 2
  axes:
    display: false
    minor:
      spacing: 5
      spacingType: 'pixel'
      color: '#d3d3d3'
      thickness: 2
    major:
      spacing: 5
      color: '#000000'
      thickness: 2
  rules: []
  backgrounds: []

# Line
circosJS.Line.prototype.defaultConf =
  innerRadius: 0
  outerRadius: 0
  min: 'smart'
  max: 'smart'
  direction: 'out'
  logScale: false
  color: '#fd6a62'
  fill: true
  fill_color: '#d3d3d3'
  thickness: 2
  max_gap: 10000000
  interpolation: 'linear'
  axes:
    display: true
    minor:
      spacing: 5
      spacingType: 'pixel'
      color: '#d3d3d3'
      thickness: 2
    major:
      spacing: 5
      color: '#000000'
      thickness: 2
  rules: []
  backgrounds: []

# Stack
circosJS.Stack.prototype.defaultConf =
  innerRadius: 0
  outerRadius: 0
  colorPaletteSize: 9
  colorPalette: 'PuBuGn'
  usePalette: true
  colorPaletteReverse: false
  color: '#fd6a62'
  min: 'smart'
  max: 'smart'
  direction: 'out'
  logScale: false
  color: '#fd6a62'
  thickness: 10
  radialMargin: 2
  margin: 2
  strokeWidth: 1
  strokeColor: '#000000'
  axes:
    display: false
    minor:
      spacing: 5
      spacingType: 'pixel'
      color: '#d3d3d3'
      thickness: 2
    major:
      spacing: 5
      color: '#000000'
      thickness: 2
  rules: []
  backgrounds: []

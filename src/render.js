import forEach from 'lodash/forEach'
import sortBy from 'lodash/sortBy'
import renderLayout from './layout/render'

export default function render (ids = [], removeTracks, circos) {
  const renderAll = ids.length === 0

  const svg = circos.svg
    .attr('width', circos.conf.width)
    .attr('height', circos.conf.height)

  let layoutConf = circos._layout.conf

  var defs = svg.append("defs");

  
  if (layoutConf.showCircleButton) {
  svg.append("circle")
  .attr("cx", circos.conf.width/2)
  .attr("cy", circos.conf.height/2)
  .attr("id", "circleColor")
  .attr("class", "circleButton")
  .attr("r", layoutConf.circleButtonRadius)
  .attr("fill", layoutConf.circleButtonColor)
  .attr("stroke", layoutConf.circleButtonStrokeColor)
  .attr("stroke-width", layoutConf.circleButtonStrokeWidth)
  .on("click", layoutConf.circleButtonEvent)

  //If user specified an image
  if (layoutConf.circleButtonImage !== null) {
  defs.append('pattern')
  .attr("id", layoutConf.circleButtonImage)
  .attr("class", "circleButton")
  .attr("width", 1)
  .attr("height", 1)
  .attr("patternUnits", "objectBoundingBox")
  .append("image")
  .attr("xlink:href", "../../data/images" + layoutConf.circleButtonImage)
  .attr("width", layoutConf.circleButtonRadius*2-layoutConf.imageSizeOffset)
  .attr("height", layoutConf.circleButtonRadius*2-layoutConf.imageSizeOffset)
  .attr("y", layoutConf.imageYOffset)
  .attr("x", layoutConf.imageXOffset);

  const addedCircle = svg.append("circle")
  .attr("cx", circos.conf.width/2)
  .attr("cy", circos.conf.height/2)
  .attr("id", "circleButton")
  .attr("class", "circleButton")
  .attr("r", layoutConf.circleButtonRadius)
  .on("click", layoutConf.circleButtonEvent)
  .style("fill", 'url(#' + layoutConf.circleButtonImage + ')')
  .style("stroke", layoutConf.circleButtonStrokeColor)
  .style("stroke-width", layoutConf.circleButtonStrokeWidth)
  }

  
  }

  

  if (removeTracks) {
    forEach(circos.tracks, (track, trackId) => {
      svg.select('.' + trackId).remove()
    })
  }

  let translated = svg.select('.all')
  if (translated.empty()) {
    translated = svg.append('g')
      .attr('class', 'all')
      .attr(
        'transform',
        `translate(
          ${parseInt(circos.conf.width / 2)},
          ${parseInt(circos.conf.height / 2)}
        )`
      )
  }

  forEach(circos.tracks, (track, trackId) => {
    if (renderAll || trackId in ids) {
      track.render(circos, translated, trackId)
    }
  })
  if (renderAll || 'layout' in ids) {
    renderLayout(translated, circos)
  }

  // re-order tracks and layout according to z-index
  const trackContainers = svg.selectAll('.all > g').remove()
  const sortedTrackContainers = sortBy(
    trackContainers._groups[0],
    (elt) => elt.getAttribute('z-index')
  )

  svg.select('.all').selectAll('g')
    .data(sortedTrackContainers)
    .enter()
    .append((d) => d)

  return circos
}

# a retravailler
circosJS.renderLayout = (d3, svg, instance) ->
    conf = instance._layout.getConf()

    svg.select('.cs-layout').remove()

    layout = svg
        .attr 'width', instance.conf.width
        .attr 'height', instance.conf.height
        .append 'g'
        .attr 'class', 'cs-layout'
        .on 'click', conf.clickCallback
        .attr 'transform', 'translate(' + parseInt(instance.conf.width/2) + ',' + parseInt(instance.conf.height/2) + ')'

    block = layout
        .selectAll 'path'
        .data instance._layout.getData()
        .enter()
        .append 'g'

    entry = d3.svg.arc()
        .innerRadius conf.innerRadius
        .outerRadius conf.outerRadius
        # .cornerRadius conf.cornerRadius
        .startAngle (d,i) -> d.start
        .endAngle (d,i) -> d.end

    block.append 'path'
        .attr 'd', entry
        .attr 'fill', (d) -> d.color
        .attr 'id', (d) -> d.id

    if conf.labels.display
        circosJS.renderLayoutLabels conf, d3, block

    if conf.ticks.display
        circosJS.renderLayoutTicks conf, layout, d3, instance

circosJS.renderLayoutLabels = (conf, d3, block) ->
    # http://stackoverflow.com/questions/20447106/how-to-center-horizontal-and-vertical-text-along-an-textpath-inside-an-arc-usi
    r = conf.innerRadius + conf.labels.radialOffset

    labelArc = d3.svg.arc()
        .innerRadius r
        .outerRadius r
        .startAngle (d,i) -> d.start
        .endAngle (d,i) -> d.end

    block.append 'path'
        .attr 'fill', 'none'
        .attr 'stroke', 'none'
        .attr 'd', labelArc
        .attr 'id', (d) -> 'arc-label' + d.id

    label = block.append 'text'
        .style 'font-size', '' + conf.labels.size + 'px'
        .attr 'text-anchor', 'middle'

    label.append 'textPath'
        .attr 'startOffset', '25%'
        .attr 'xlink:href', (d) -> '#arc-label' + d.id
        .style 'fill', conf.labels.color
        .text (d) -> d.label

circosJS.renderLayoutTicks = (conf, layout, d3, instance) ->
    # Returns an array of tick angles and labels, given a block.
    blockTicks = (d) ->
        k = (d.end - d.start) / d.len
        d3.range(0, d.len, conf.ticks.spacing).map (v, i) ->
            angle: v * k + d.start,
            label: displayLabel v, i

    displayLabel = (v, i) ->
        if conf.ticks.labels == false
            null
        else if conf.ticks.labelDisplay0 == false and i == 0
            null
        else if i % conf.ticks.labelSpacing
            null
        else
            v / conf.ticks.labelDenominator + conf.ticks.labelSuffix

    ticks = layout.append("g").selectAll("g")
        .data(instance._layout.getData())
        .enter().append("g").selectAll("g")
        .data(blockTicks)
        .enter().append("g")
        .attr("transform", (d) -> "rotate(" + (d.angle * 180 / Math.PI - 90) + ")" + "translate(" + conf.outerRadius + ",0)")

    ticks.append("line")
        .attr("x1", 0)
        .attr("y1", 1)
        .attr("x2", (d, i) -> if i % conf.ticks.majorSpacing then conf.ticks.size.minor else conf.ticks.size.major)
        .attr("y2", 1)
        .style("stroke", conf.ticks.color)

    ticks.append("text")
        .attr("x", 8)
        .attr("dy", ".35em")
        .attr("transform", (d) -> if d.angle > Math.PI then "rotate(180)translate(-16)" else null)
        .style("text-anchor", (d) -> if d.angle > Math.PI then "end" else null)
        .style 'font-size', '' + conf.ticks.labelSize + 'px'
        .style 'fill', conf.ticks.labelColor
        .text((d) -> d.label)


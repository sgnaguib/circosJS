circosJS.Core.prototype.histogram = (id, conf, data) ->
    # Check layout is defined
    unless this._layout?
        circosJS.log(
            1,
            'No layout defined',
            'Circos cannot add or update a histogram track without layout',
            {'histogram_id': id}
        )
        return this

    #check data consistency with layout
    layout_ids = (d.id for d in this._layout.getData())
    layout_lengths = {}
    for d in this._layout.getData()
        layout_lengths[d.id] = d.len
    # for datum in data
    for block in data
        # check match between track and layout block id
        unless block.parent in layout_ids
            circosJS.log(
                2,
                'No layout block id match',
                'Histogram data has a parent property that does not correspond to any layout block id',
                {'histogram_id': id, 'block_id': block.parent}
            )
        # check datum lengths and layout block length
        for datum in block.data
            if datum.start < 0 or datum.end > layout_lengths[block.parent]
                circosJS.log(
                    2,
                    'Track data inconsistency',
                    'Track data has a start < 0 or a end above the block length',
                    {'track_id': id, 'datum': datum, 'layout block': this._layout.getBlock(block.parent)}
                )

    this._histograms[id] = new circosJS.Histogram(conf, data)
    return this


# Histogram instance constructor
circosJS.Histogram = (conf, data) ->
    # this refers the histogram instance
    this._data = data

    # deep copy of default conf
    this._conf = JSON.parse JSON.stringify this._defaultConf

    # conf override the default configuration. Conf not in default conf
    # object are removed
    for k,v of this._conf
        this._conf[k] = if conf[k]? then conf[k] else v

    # add parent is datum. Needed for rendering
    for k,v of data
        for i, datum of v.data
            datum.block_id = v.parent

    # compute min and max values
    if this._conf.min == 'smart' and this._conf.max == 'smart'
        histogramMin = 99999999
        histogramMax = -99999999
        for k,v of data
            for kc,vc of v.data
                if vc.value > histogramMax then histogramMax = vc.value
                if vc.value < histogramMin then histogramMin = vc.value
        this._conf.cmin = histogramMin
        this._conf.cmax = histogramMax
    else if this._conf.min == 'smart'
        histogramMin = 99999999
        for k,v of data
            for kc,vc of v.data
                if vc.value < histogramMin then histogramMin = vc.value
        this._conf.cmin = histogramMin
        this._conf.cmax = this._conf.max
    else if this._conf.max == 'smart'
        histogramMax = -99999999
        for k,v of data
            for kc,vc of v.data
                if vc.value < histogramMax then histogramMax = vc.value
        this._conf.cmax = histogramMax
        this._conf.cmin = this._conf.min
    else
        this._conf.cmin = this._conf.min
        this._conf.cmax = this._conf.max

    this.height = (value, scale) ->
        if value >= this._conf.cmax
            this._conf.outerRadius - this._conf.innerRadius
        else if scale == 'linear'
            Math.floor((value - this._conf.cmin) / this._conf.cmax * (this._conf.outerRadius - this._conf.innerRadius))
            # else
                # null

    this.colorScale = (value, scale) ->
        if value == this._conf.cmax
            this._conf.colorPaletteSize - 1
        else if scale == 'linear'
            Math.floor((value - this._conf.cmin) / (this._conf.cmax - this._conf.cmin) * this._conf.colorPaletteSize)
            # else
                # null


    # getters/setters
    this.getData = ->
        this._data
    this.getConf = ->
        this._conf
    return this


export default {
  innerRadius: 250,
  outerRadius: 300,
  cornerRadius: 0,
  showCircleButton: true,
  circleButtonRadius: 100,
  circleButtonEvent: null,//function() {console.log("JSON is magic")},
  circleButtonImage: null,
  imageSizeOffset: null,
  imageYOffset: 0,
  circleButtonColor: "black",
  circleButtonStrokeColor: "gray",
  circleButtonStrokeWidth: 10,
  gap: 0.04, // in radian
  opacity: 1,
  labels: {
    position: 'center',
    display: true,
    size: 14,
    color: '#000',
    radialOffset: 20
  },
  ticks: {
    display: true,
    tickStartPosition: 0,
    color: 'grey',
    spacing: 10000000,
    labels: true,
    labelSpacing: 10,
    labelSuffix: '',
    labelDenominator: 1,
    labelDisplay0: true,
    labelSize: 10,
    labelColor: '#000',
    labelFont: 'default',
    majorSpacing: 5,
    radialOffset: 0,
    size: {
      minor: 2,
      major: 5
    }
  },
  onClick: null,
  onMouseOver: null,
  events: {},
  zIndex: 100
}

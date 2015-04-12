# Attributions:
# The svg path for the bolt icon provided by Open Iconic
# The source code is available at https://github.com/iconic/open-iconic

command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 10000

render: -> """
  <svg version="3.1" id="battery"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    viewBox="0 0 120 28" >
    <defs>
      <clipPath id="cut-off-left">
        <rect x="109" y="0" width="10" height="100" />
      </clipPath>
    </defs>
    <rect id="hull" x="1" y="1" rx="3" ry="3" width="106" height="26" />
    <circle id="tip" cx="106" cy="14" r="6"
      clip-path="url(#cut-off-left)" />
    <rect id="charge" x="4" y="4" rx="2" ry="2" height="20" />
    <path id="bolt" d="M3 0l-3 5h2v3l3-5h-2v-3z" transform="translate(50,6), scale(2)" />
  </svg>
  <div id="text"></div>
"""

update: (output, domEl) ->
  values = output.split(' ')
  text = $('#text')
  state = values[0]
  charge = parseInt(values[1])

  if charge <= 25
    fill = '250,'+ 8 * charge + ',0'
  else
    fill = '91,158,91'
  fill = 'rgba('+fill+',1)'

  $('#charge').attr('width',charge)
  $('#charge').css('fill',fill)
  $('#bolt').css('display',if state != 'charging' then 'none')

  text.html(charge + '%: ' + state)

style: """
    main = rgba(#fff,1)
    color: main
    scale = .9
    opacity = .6

    bottom: 80px
    left: 20px
    font-family: Helvetica Neue
    font-size: 1em * scale

    svg
      width: 220px * scale
      height: auto
      margin: 0
      opacity: opacity

    #hull
      fill: none
      stroke: main
      stroke-width: 2

    #tip
      fill: main

    #charge
      stroke-width: 2

    #text
      font-weight: bold
      opacity: opacity

    #bolt
      position: absolute
      fill: main
      height: 25px
"""

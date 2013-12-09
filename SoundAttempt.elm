-- Play sound code

import Graphics.Input as Input
import JavaScript as JS

sounds = { click = False }

buttonRed = collage 50 50 [ circle 20 |> filled red]
(buttonImageR,buttonSignalR) = Input.hoverable buttonRed

buttonBlue = collage 50 50 [ circle 20 |> filled blue]
(buttonImageB,buttonSignalB) = Input.hoverable buttonBlue

click sounds = sounds.click

playClick = lift (JS.fromBool . click) mainSignal
foreign export jsevent "click"
    playClick : Signal JS.JSBool

handle (start, stop) = startMusic start . stopMusic stop

startMusic start sounds = 
    case start of
      True -> {sounds | click <- True}
  
stopMusic stop sounds = 
    case stop of
      True -> {sounds | click <- False}

inputSignal = lift2 (,) buttonSignalB buttonSignalR
mainSignal =  foldp handle sounds inputSignal

render sounds = flow right [buttonImageB, buttonImageR]

main = render <~ mainSignal
menuWindow = nil
topButton = nil
movingButton = nil

currentTime = os.time() -- Attempted timekeeping for ticking movement
targetTime = currentTime

-- Create the base screen and attempt to begin ticking
function init()
  connect(g_game, { onGameStart = refresh })

  g_keyboard.bindKeyDown('Ctrl+V', toggle)

  topButton = modules.client_topmenu.addLeftGameToggleButton('topButton', tr('Moving Window Test') .. ' (Ctrl+V)', '/images/topbuttons/inventory', toggle)
  topButton:setOn(true)

  menuWindow = g_ui.displayUI('question7')

  movingButton = menuWindow:getChildById('movingButton')
  
  tick()
end

-- When the button is clicked, we would reset the X to the far right edge of the menu and randomize the Y
function buttonPressMove()
  movingButton:setY(math.random(380, 630))
end

-- The idea here is to count ticks inside this menu to be able to smoothly move the button left. Unfortunately this isn't working as envisioned.
function tick()
  if (currentTime >= targetTime) then
    movingButton:move(movingButton:getX() - 50, movingButton:getY())
	targetTime = targetTime + 10
  end
  refresh()
end

function terminate()
  disconnect(g_game, { onGameStart = refresh })

  g_keyboard.unbindKeyDown('Ctrl+V')

  menuWindow:destroy()
  topButton:destroy()
end

-- This would be the way to ensure constant ticking, but uncommenting this call causes a crash 100% of the time,
-- seems like the client can't handle too much stress/recursion
function refresh()
  --tick()
end

function toggle()
  if menuWindow:isVisible() then
    hide()
	topButton:setOn(false)
  else
    show()
	topButton:setOn(true)
  end
end

function show()
  menuWindow:show()
  menuWindow:raise()
  menuWindow:focus()
end

function hide()
  menuWindow:hide()
end

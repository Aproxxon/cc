local monitor = peripheral.wrap("top")
local modem = peripheral.wrap("front")
local speaker = peripheral.wrap("right")

local args = { ... }
local floor = args[1]

print("Cabine Floor "..floor)

monitor.clear()
monitor.setCursorPos(1,1)
monitor.write("-------")
monitor.setCursorPos(1,2)
monitor.write(" FL "..floor)
monitor.setCursorPos(1,3)
monitor.write("-------")
monitor.setCursorPos(1,5)
monitor.write("12 Yann")
monitor.setCursorPos(1,6)
monitor.write("11 Yann")
monitor.setCursorPos(1,7)
monitor.write("10 Yann")
monitor.setCursorPos(1,8)
monitor.write("9 ????")
monitor.setCursorPos(1,9)
monitor.write("8 ????")
monitor.setCursorPos(1,10)
monitor.write("7 ????")
monitor.setCursorPos(1,11)
monitor.write("6 ????")
monitor.setCursorPos(1,12)
monitor.write("5 ????")
monitor.setCursorPos(1,13)
monitor.write("4 ????")
monitor.setCursorPos(1,14)
monitor.write("3 Popo")
monitor.setCursorPos(1,15)
monitor.write("2 Popo")
monitor.setCursorPos(1,16)
monitor.write("1 Popo")
monitor.setCursorPos(1,17)
monitor.write("0 RDC")
monitor.setCursorPos(1,18)
monitor.write("-1 Cave")

modem.open(97)
modem.open(98)

local oldy = -1

while(true) do
    local event, p1, p2, p3, p4, p5 = os.pullEvent()
    local isRedstone = (event == "redstone")
    local isTouch = (event == "monitor_touch")
    local isModem = (event == "modem_message")

    if (isRedstone) then
        modem.transmit(99,98,floor)
    end

    if(isTouch) then
      local x = p2
      local y = p3
      local nf = 17 - y

      print ("going to "..nf)
      speaker.playSound(
        "minecraft:entity.experience_orb.pickup",
        1, 0.5
      )

      modem.transmit(98,98,tonumber(nf))
      
      monitor.setTextColor( colors.red )
      monitor.setCursorPos(1, y)
      monitor.write(tostring(nf))
      monitor.setTextColor( colors.white )
      monitor.setCursorPos(1, 17 - oldy)
      monitor.write(tostring(oldy))
      oldy = nf
    end

    if(isModem) then
      local chan = p2
      local message = tonumber(p4)

      if(tonumber(chan) == 98) then
        local y = 17 - message
        monitor.setTextColor( colors.red )
        monitor.setCursorPos(1, y)
        monitor.write(tostring(message))
        monitor.setTextColor( colors.white )
        monitor.setCursorPos(1, 17 - oldy)
        monitor.write(tostring(oldy))
        oldy = message
      end
      
      if(tonumber(chan) == 97) then
        if(tonumber(message) == tonumber(floor)) then
          speaker.playSound(
            "minecraft:entity.player.levelup",
            1, 0.5
          )
        end
      end
    end
end

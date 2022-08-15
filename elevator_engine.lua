local modem = peripheral.wrap("top")

modem.open(99)
modem.open(98)

local floor = -1
local destination = -1

redstone.setOutput("right", false)
sleep(0.1)
redstone.setOutput("right", true)

redstone.setOutput("back", false)


while true do
  local event, modemSide, senderChannel,
    replyChannel, message, senderDistance = os.pullEvent("modem_message")

    print(senderChannel)

    if(senderChannel == 99) then
      floor = tonumber(message)
      redstone.setOutput("front", math.abs(destination - floor) <= 1)
      print("floor is: "..tostring(floor).." destination is "..tostring(destination))
      if(floor == destination) then
         print("arrived")
         redstone.setOutput("back", true)
         modem.transmit(97,98,tonumber(destination))
      end
    end

    if(senderChannel == 98) then
      destination = tonumber(message)
      print("going to " ..tostring(destination).." floor is "..tostring(floor))
      if(destination < floor) then
        print("going down")
        redstone.setOutput("back", false)
        --redstone.setOutput("right", false)
        sleep(0.1)
        redstone.setOutput("right", true)
      end
      if(destination > floor) then
        print("going up")
        redstone.setOutput("back", false)
        --redstone.setOutput("right", true)
        sleep(0.1)
        redstone.setOutput("right", false)
      end
    end
end

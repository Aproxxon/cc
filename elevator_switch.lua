local modem = peripheral.wrap("front")

local args = { ... }
local floor = args[1]

while(true) do
    local event, p1, p2, p3, p4, p5 = os.pullEvent()
    local isRedstone = (event == "redstone")
    
    if (isRedstone) then
        modem.transmit(98,98,floor)
        print("call elevator to "..floor)
    end
end 

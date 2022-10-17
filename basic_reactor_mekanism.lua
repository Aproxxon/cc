local reactor = peripheral.wrap("back")
local monitor = peripheral.find("monitor")

print(reactor.getStatus())

local function activate()
  if(not reactor.getStatus()) then
    reactor.activate()
  end
end

local function scram()
  if(reactor.getStatus()) then
    reactor.scram()
    return true
  end
  return false
end

while(true) do
  local act = reactor.getStatus()
  local actLabel = (act) ? "Activated" : "Stopped";
  local dam = reactor.getDamagePercent()
  local cool = reactor.getHeatedCoolantFilledPercentage()
  local waste = reactor.getWasteFilledPercentage()
  local fuel = reactor.getFuelFilledPercentage()
  local burn = reactor.getBurnRate()
  
  monitor.clear()
  
  monitor.setCursorPos(1,1)
  monitor.write("Status: "..actLabel)
  monitor.setCursorPos(1,2)
  monitor.write("Damage: "..dam.."%")
  monitor.setCursorPos(1,3)
  monitor.write("Heat. Cool.: "..cool.."%")
  monitor.setCursorPos(1,4)
  monitor.write("Waste: "..waste.."%")
  monitor.setCursorPos(1,5)
  monitor.write("Fuel: "..fuel.."%")
  monitor.setCursorPos(1,6)
  monitor.write("Burn Rate: "..burn.."mB / t")
  monitor.setCursorPos(1,7)
  
  if(dam > 5) then
    if(scram()) then
      print("Stopped because of damages")
      reactor.setBurnRate(1.0)
    end
  
  
  elseif(cool > 15) then
    if(scram()) then
      print("Stopped because of coolant")
      reactor.setBurnRate(1.0)
    end
  
  
  elseif(waste > 15) then
    if(scram()) then
      print("Stopped because of waste")
      reactor.setBurnRate(1.0)
    end
  
  else
     activate()
  end
  
  sleep(1)
end

local component = require("component")
local capacitor = component.ie_hv_capacitor
local rs = component.redstone
local sides = require("sides")
local sleepTime = 20

function getCapacitorLevel()
    return ((capacitor.getEnergyStored() / capacitor.getMaxEnergyStored()) * 100)
end

function turnGeneratorOn()
    rs.setOutput(sides.back, 0)
end

function turnGeneratorOff()
    rs.setOutput(sides.back, 15)
end

function main()
    local isGeneratorOn = false
    turnGeneratorOff()
    while true do
        local currentPower = getCapacitorLevel()
        os.execute("clear")
        print("Current Power: " .. tostring(currentPower) .. "%")
        if(currentPower < 40 and isGeneratorOn == false) then
            turnGeneratorOn()
            isGeneratorOn = true
        elseif (currentPower > 90 and isGeneratorOn) then
            turnGeneratorOff()
            isGeneratorOn = false
        end
        os.sleep(sleepTime)
    end
end

main()

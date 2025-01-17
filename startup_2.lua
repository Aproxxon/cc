local h = fs.open("/setup.conf", "r")
local program = h.readLine()
local argP = h.readLine() or ""

local function getFileFromURL(file)
  local res = http.get(file, {
  --    ["Authorization"] = "token "..GITHUB_ACCESS_TOKEN,
  })
  if res == nil then return nil end
  local content = res.readAll()
  res.close()

  if content == nil then
      error("Critical error, could not download "..PROGRAM.." from repo!")
  end
  print("Downloaded")
  return content
end

local function saveFile(path, content)
  print("saving "..path)
  local f = fs.open(path, "w")
  f.write(content)
  f.close()
end

print("Updating "..program)
url = "https://aproxxon.github.io/cc/"..program..".lua"
saveFile("/"..program..".lua", getFileFromURL(url))

print("Starting "..program.." "..argP)

multishell.launch({}, "/"..program..".lua", argP)

local modem = peripheral.find("modem")
modem.open(1)

while(true) do
  local event, modemSide, senderChannel,
    replyChannel, message, senderDistance = os.pullEvent("modem_message")

  if((senderChannel == 1 and tonumber(message) == os.getComputerID()) or message == "all") then
    os.reboot()
    print("reboot")
  end
end

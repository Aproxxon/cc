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

if(not fs.exists("/startup.lua")) then
  print("Downloading Startup")
  saveFile("/startup.lua", getFileFromURL("https://azukaar.github.io/cc/startup.lua"))
  print("done")
end

if(not fs.exists("/setup.conf")) then
  print("Creating Config")
  
  local h = fs.open("/setup.conf", "w")
  
  print("done")
end


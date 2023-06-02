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

print("Updating Startup_2.lua")
saveFile("/startup_2.lua", getFileFromURL("https://aproxxon.github.io/cc/startup_2.lua"))

os.run({shell = shell, multishell = multishell}, "/startup_2.lua")
